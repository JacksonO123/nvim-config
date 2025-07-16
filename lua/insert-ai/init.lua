local M = {}

function M.close_windows() end

local function close_buffer(buf)
  if vim.api.nvim_buf_is_valid(buf) then
    vim.api.nvim_buf_delete(buf, { force = true })
  end
end

local function open_input_window(callback)
  local buf = vim.api.nvim_create_buf(false, true)
  local width = 60
  local height = 1
  local row = math.floor((vim.o.lines - height) / 4)
  local col = math.floor((vim.o.columns - width) / 2)

  local opts = {
    style = "minimal",
    relative = "editor",
    width = width,
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

  vim.opt_local.wrap = true
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
      local new_height = math.max(1, math.min(10, required_lines)) -- Clamp between 1 and 10

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
    while vim.fn.strdisplaywidth(lines[i]) > width - 1 do
      local parts = vim.split(lines[i], " ")

      if #parts == 1 then
        local first = string.sub(parts[1], 0, width - 2)
        local second = string.sub(parts[1], width - 1, string.len(parts[1]))
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
        next_line = string.sub(next_line, 1, string.len(next_line))
      end
      table.insert(lines, i + 1, next_line)
    end

    i = i + 1
  end

  return lines
end

local function outline_text(text, label)
  local win_width     = vim.api.nvim_win_get_width(0)
  local content_width = win_width - 2

  local wrapped_lines = wrap_text(text, content_width)

  local showLabel     = " " .. label .. " "
  local border_top    = "╭─" .. showLabel .. string.rep("─", win_width - 3 - string.len(showLabel)) .. "╮"
  local border_bottom = "╰" .. string.rep("─", win_width - 2) .. "╯"
  local lines         = { border_top }
  for _, line in ipairs(wrapped_lines) do
    local line_width = vim.fn.strdisplaywidth(line)
    local padding_spaces = string.rep(" ", win_width - 3 - line_width)
    table.insert(lines, "│ " .. line .. padding_spaces .. "│")
  end
  table.insert(lines, border_bottom)

  return lines
end

local function ask_prompt_and_render_output(buf, final_prompt, cli_path, update_callback, done_callback)
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

    on_stderr = function(_, err)
      -- local err_str = vim.inspect(err)
      -- if err_str ~= "" then
      --   print("stderr:", err_str)
      -- end
    end,

    on_exit = function()
      done_callback()
    end,
  })

  -- Send prompt to stdin
  vim.fn.chansend(job, final_prompt .. "\n")
  vim.fn.chanclose(job, "stdin")
end

local function open_prompt_preview(buf, prompt)
  local width = 60
  local row = 0
  local col = math.floor((vim.o.columns - width))
  local lines = wrap_text(prompt, width)
  for i, line in ipairs(lines) do
    lines[i] = " " .. line
  end
  local height = #lines

  local opts = {
    style = "minimal",
    relative = "editor",
    width = width,
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

  vim.opt_local.showbreak = ' '

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
  local width = 60
  local col = math.floor((vim.o.columns - width))
  local height = 1

  local opts = {
    style = "minimal",
    relative = "editor",
    width = width,
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

  vim.opt_local.showbreak = ' '

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "Loading..." })
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
  ask_prompt_and_render_output(buf, prompt, cli_path, function(content)
    local lines = wrap_text(content, width)
    if lines[#lines] == "" then
      table.remove(lines, #lines)
    end
    vim.api.nvim_win_set_height(win, #lines)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  end, function()
    vim.api.nvim_buf_set_option(buf, "modifiable", false)
  end)
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
  local file_lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  local file_data = table.concat(file_lines, "\n")
  local cli_path = "insert-ai"

  open_input_window(function(prompt)
    local final_prompt = string.format([[
    Use this code as context for the following prompt, and output only the code that is specified to be generated:
    (.%s file)
    ```
    %s
    ```
    The current cursor position is at line %d and column %d.
    Use the context of the cursor position in this program in your output.
    Generate code based on this prompt:
    "%s"
    Generate only the code for this new addition. *important*: Exclude any quotes or language specification surrounding your output.
    Your output is in text form, not markdown, so avoid using markdown features.
    ]], file_ext, file_data, row, col, prompt)

    local prompt_buf = vim.api.nvim_create_buf(false, true)
    local output_buf = vim.api.nvim_create_buf(false, true)

    function M.close_windows()
      close_buffer(prompt_buf)
      close_buffer(output_buf)
    end

    local height = open_prompt_preview(prompt_buf, prompt)
    open_output_preview(output_buf, final_prompt, height, cli_path)
  end)
end

return M
