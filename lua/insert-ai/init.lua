local M = {}

M.last_prompt = "(no previous prompt)"
M.last_output = ""
M.last_filetype = nil
M.window_width = 60

function M.close_windows() end

local function close_buffer(buf)
  if vim.api.nvim_buf_is_valid(buf) then
    vim.api.nvim_buf_delete(buf, { force = true })
  end
end

local function open_input_window(callback)
  local buf = vim.api.nvim_create_buf(false, true)
  local height = 1
  local row = math.floor((vim.o.lines - height) / 4)
  local col = math.floor((vim.o.columns - M.window_width) / 2)

  local opts = {
    style = "minimal",
    relative = "editor",
    width = M.window_width,
    height = height,
    row = row,
    col = col,
    border = "rounded",
  }

  vim.api.nvim_open_win(buf, true, opts)
  vim.api.nvim_buf_set_option(buf, 'buftype', 'prompt')
  vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
  vim.api.nvim_buf_set_option(buf, 'swapfile', false)
  vim.api.nvim_buf_set_option(buf, 'filetype', 'PromptWindow')
  vim.api.nvim_buf_set_option(buf, 'buflisted', false)
  vim.api.nvim_buf_set_option(buf, 'wrap', true)

  vim.opt_local.showbreak = '   '

  vim.fn.prompt_setprompt(buf, " > ")
  vim.fn.prompt_setcallback(buf, function(input)
    M.close_windows()
    close_buffer(buf)
    callback(input)
  end)

  vim.api.nvim_create_autocmd("TextChangedI", {
    buffer = buf,
    callback = function()
      local line = vim.api.nvim_get_current_line()
      local win_id = vim.api.nvim_get_current_win()
      local display_width = vim.fn.strdisplaywidth(line) + 1
      local win_width = vim.api.nvim_win_get_width(win_id)

      local required_lines = math.ceil(display_width / win_width)
      local new_height = math.max(1, math.min(10, required_lines))

      vim.api.nvim_win_set_height(win_id, new_height)
    end
  })

  vim.keymap.set('n', 'q', function()
    close_buffer(buf)
  end, { buffer = buf, nowait = true, silent = true })

  vim.keymap.set('n', '<Esc>', function()
    close_buffer(buf)
  end, { buffer = buf, nowait = true, silent = true })

  vim.api.nvim_create_autocmd("WinLeave", {
    buffer = buf,
    callback = function()
      vim.schedule(function()
        close_buffer(buf)
      end)
    end,
  })

  vim.cmd("startinsert")
end

local function wrap_text(text, width)
  local lines = vim.split(text, "\n", { plain = true })

  local i = 1
  while i <= #lines do
    local next_line = ""

    local count = 0
    while vim.fn.strdisplaywidth(lines[i]) >= width - 1 do
      local parts = vim.split(lines[i], " ")

      if #parts == 1 then
        local first = parts[1]:sub(0, width - 2)
        local second = parts[1]:sub(width - 1)
        lines[i] = first
        table.insert(lines, i + 1, second)
        i = i + 1
        goto continue
      end

      next_line = parts[#parts] .. " " .. next_line
      table.remove(parts, #parts)
      lines[i] = table.concat(parts, " ")

      count = count + 1

      ::continue::
    end

    if next_line ~= "" then
      while next_line[1] == " " and next_line[2] == " " do
        next_line = next_line:sub(1)
      end
      table.insert(lines, i + 1, next_line)
    end

    i = i + 1
  end

  return lines
end

local function ask_prompt_and_render_output(final_prompt, cli_path, update_callback, done_callback)
  local content = ""

  local job = vim.fn.jobstart({ cli_path }, {
    stdout_buffered = true,
    stdin = "pipe",

    on_stdout = function(_, data)
      for _, chunk in ipairs(data) do
        content = content .. chunk .. "\n"
      end
      update_callback(content)
    end,

    on_stderr = function() end,

    on_exit = function()
      done_callback()
    end,
  })

  vim.fn.chansend(job, final_prompt .. "\n")
  vim.fn.chanclose(job, "stdin")
end

local function open_prompt_preview(buf, prompt)
  local row = 0
  local col = math.floor((vim.o.columns - M.window_width))
  local lines = wrap_text(prompt, M.window_width)
  for i, line in ipairs(lines) do
    lines[i] = " " .. line
  end
  local height = #lines

  local opts = {
    style = "minimal",
    relative = "editor",
    width = M.window_width,
    height = height,
    row = row,
    col = col,
    border = "rounded",
    title = "─ Prompt ",
    title_pos = "left",
  }

  vim.api.nvim_set_hl(0, "FloatTitle", { link = "FloatBorder" })

  vim.api.nvim_open_win(buf, true, opts)
  vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
  vim.api.nvim_buf_set_option(buf, 'swapfile', false)
  vim.api.nvim_buf_set_option(buf, 'buflisted', false)

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.api.nvim_buf_set_option(buf, 'modifiable', false)

  vim.keymap.set('n', 'q', function()
    M.close_windows()
  end, { buffer = buf, nowait = true, silent = true })

  vim.api.nvim_create_autocmd("BufWipeout", {
    buffer = buf,
    callback = function()
      vim.schedule(M.close_windows)
    end
  })

  return height + 2
end

local function open_output_preview(buf, prompt, y_pos, cli_path)
  local col = math.floor((vim.o.columns - M.window_width))
  local height = 1

  local opts = {
    style = "minimal",
    relative = "editor",
    width = M.window_width,
    height = height,
    row = y_pos,
    col = col,
    border = "rounded",
    title = "─ Output ",
    title_pos = "left",
  }

  vim.api.nvim_set_hl(0, "FloatTitle", { link = "FloatBorder" })

  local win = vim.api.nvim_open_win(buf, true, opts)
  vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
  vim.api.nvim_buf_set_option(buf, 'swapfile', false)
  vim.api.nvim_buf_set_option(buf, 'buflisted', false)
  vim.api.nvim_buf_set_option(buf, 'wrap', true)

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "Crunching they digits..." })
  vim.api.nvim_buf_set_option(buf, 'modifiable', false)

  vim.keymap.set('n', 'q', function()
    M.close_windows()
  end, { buffer = buf, nowait = true, silent = true })

  vim.api.nvim_create_autocmd("BufWipeout", {
    buffer = buf,
    callback = function()
      vim.schedule(M.close_windows)
    end
  })

  vim.api.nvim_buf_set_option(buf, "modifiable", true)

  ask_prompt_and_render_output(prompt, cli_path, function(content)
    M.last_output = content
    local wrapped_lines = wrap_text(content, M.window_width)
    local lines = vim.split(content, "\n", { plain = true })
    while lines[#lines] == "" do
      table.remove(lines, #lines)
    end
    vim.api.nvim_win_set_height(win, #wrapped_lines)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  end, function()
    vim.api.nvim_buf_set_option(buf, "modifiable", false)
  end)
end

local function open_prev_output_preview(buf, content, y_pos)
  local col = math.floor((vim.o.columns - M.window_width))
  local height = 1

  local opts = {
    style = "minimal",
    relative = "editor",
    width = M.window_width,
    height = height,
    row = y_pos,
    col = col,
    border = "rounded",
    title = "─ Output ",
    title_pos = "left",
  }

  vim.api.nvim_set_hl(0, "FloatTitle", { link = "FloatBorder" })

  local win = vim.api.nvim_open_win(buf, true, opts)
  vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
  vim.api.nvim_buf_set_option(buf, 'swapfile', false)
  vim.api.nvim_buf_set_option(buf, 'buflisted', false)
  vim.api.nvim_buf_set_option(buf, 'wrap', true)

  local wrapped_lines = wrap_text(content, M.window_width)
  local lines = vim.split(content, "\n", { plain = true })
  while lines[#lines] == "" do
    table.remove(lines, #lines)
  end
  vim.api.nvim_win_set_height(win, #wrapped_lines)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.api.nvim_buf_set_option(buf, 'modifiable', false)

  vim.keymap.set('n', 'q', function()
    M.close_windows()
  end, { buffer = buf, nowait = true, silent = true })

  vim.api.nvim_create_autocmd("BufWipeout", {
    buffer = buf,
    callback = function()
      vim.schedule(M.close_windows)
    end
  })
end

local function clone_buffer_with_marker(buf, marker, row, col)
  local line = row - 1 -- 0 based
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  local scratch_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(scratch_buf, 0, -1, false, lines)

  local target_line = lines[row]
  local new_line = target_line:sub(1, col) .. marker .. target_line:sub(col + 1)
  vim.api.nvim_buf_set_lines(scratch_buf, line, line + 1, false, { new_line })

  local final_lines = vim.api.nvim_buf_get_lines(scratch_buf, 0, -1, false)
  local content = table.concat(final_lines, "\n")

  close_buffer(scratch_buf)

  return content
end

function M.run_inference()
  local buf = vim.api.nvim_get_current_buf()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local file_path = vim.api.nvim_buf_get_name(buf)
  local path_parts = vim.split(file_path, "/")
  local file_name = path_parts[#path_parts]
  local name_parts = vim.split(file_name, "%.")
  local file_ext = ""
  if #name_parts == 1 then
    file_ext = "(unknown extension)"
  else
    file_ext = name_parts[#name_parts]
  end
  local cli_path = "insert-ai"
  local filetype = vim.bo.filetype;
  M.last_filetype = filetype;

  open_input_window(function(prompt)
    M.close_windows()
    M.last_prompt = prompt

    local time_string = tostring(os.time())
    local marker = string.format("<|CURSOR_POSITION_%s|>", time_string)
    local new_data = clone_buffer_with_marker(buf, marker, row, col)

    local final_prompt = string.format([[
Use this code as context for the following prompt, and output only the code that is specified to be generated at the position of %s:
(.%s file)
```
%s
```
The current cursor position is at line %d and column %d.
Use the context of the cursor position, and cursor position marker within this program in your output.
Generate code based on this prompt:
"%s"
Generate only the code for this new addition. *important*: Exclude any quotes or language specification surrounding your output.
Your output is in text form, not markdown, so avoid using markdown features.
]], marker, file_ext, new_data, row, col, prompt)

    local prompt_buf = vim.api.nvim_create_buf(false, true)
    local output_buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_option(output_buf, 'filetype', filetype)

    function M.close_windows()
      close_buffer(prompt_buf)
      close_buffer(output_buf)
    end

    local height = open_prompt_preview(prompt_buf, prompt)
    open_output_preview(output_buf, final_prompt, height, cli_path)
  end)
end

function M.show_prev_output()
  M.close_windows()
  local prompt_buf = vim.api.nvim_create_buf(false, true)
  local output_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(output_buf, 'filetype', M.last_filetype)

  function M.close_windows()
    close_buffer(prompt_buf)
    close_buffer(output_buf)
  end

  local height = open_prompt_preview(prompt_buf, M.last_prompt)
  open_prev_output_preview(output_buf, M.last_output, height)
end

return M
