vim.cmd("abbreviate ag Ag")

vim.api.nvim_create_autocmd("ExitPre", {
  group = vim.api.nvim_create_augroup("Exit", { clear = true }),
  command = "set guicursor=a:ver90",
  desc = "Set cursor back to beam when leaving Neovim."
})

-- Copy current file path to clipboard
vim.api.nvim_create_user_command("Cpp", function()
  local path = vim.fn.expand("%")
  vim.fn.setreg("+", path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})

-- Delete all buffer files except current
vim.api.nvim_create_user_command("BufferDelete", function()
  local currentBuffer = vim.api.nvim_get_current_buf()
  for _, buffer in ipairs(vim.api.nvim_list_bufs()) do
    if buffer ~= currentBuffer then
      vim.api.nvim_buf_delete(buffer, { force = true })
    end
  end
end, {})

-- Trim trailing whitespace on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = vim.api.nvim_create_augroup('TrailingSpaces', {}),
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})


-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Command to toggle strategy  let test#strategy between "dispatch_background" and "dispatch"
vim.api.nvim_create_user_command("TToggleTestStrategy", function()
  local strategy = vim.api.nvim_get_var("test#strategy")
  if strategy == "dispatch_background" then
    vim.api.nvim_set_var("test#strategy", "dispatch")
    print("test#strategy set to dispatch")
  else
    vim.api.nvim_set_var("test#strategy", "dispatch_background")
    print("test#strategy set to dispatch_background")
  end
end, {})

-- Command to toggle strategy  let test#strategy between "dispatch_background" and "dispatch"
vim.api.nvim_create_user_command("ToggleQuickFix", function()
  local qf_exists = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win["quickfix"] == 1 then
      qf_exists = true
    end
  end
  if qf_exists == true then
    vim.cmd "cclose"
    return
  end
  if not vim.tbl_isempty(vim.fn.getqflist()) then
    vim.cmd "copen"
    vim.cmd "cbo"
  end
end, {})

--
vim.api.nvim_create_user_command("VPR", function()
  local command =
  "Dispatch npm run format:check -- --base=origin/develop && npm run typecheck  && npm run lint -- --base=origin/develop"
  vim.fn.execute(command)
end, {})


vim.api.nvim_create_user_command("Outline", function()
  vim.lsp.buf_request(0,
    'textDocument/documentSymbol',
    vim.lsp.util.make_position_params(),
    function(err, method, result)
      print(err, vim.inspect(method), vim.inspect(result))
    end)
end, {})

vim.api.nvim_create_user_command("Alternate", function()
  local currentPath = vim.fn.expand('%')
  -- if currentPath contains .spec.ts or .spec.tsx then remove spec and open the file
  -- if currentPath contains .ts or .tsx then add spec and open the file
  if currentPath:find(".spec") then
    local possibleTSFilePath = currentPath:gsub("%.spec.ts", ".ts")
    if vim.fn.filereadable(possibleTSFilePath) == 1 then
      vim.cmd("e " .. possibleTSFilePath)
      return
    end

    local possibleTSXFilePath = currentPath:gsub("%.spec.tsx", ".tsx")
    if vim.fn.filereadable(possibleTSXFilePath) == 1 then
      vim.cmd("e " .. possibleTSFilePath)
      return
    end
  else
    if currentPath:find(".tsx") then
      local possibleSpecTSXFilePath = currentPath:gsub("%.tsx", ".spec.tsx")
      vim.cmd("e " .. possibleSpecTSXFilePath)
      return
    end
    if currentPath:find(".ts") then
      local possibleSpecTSFilePath = currentPath:gsub("%.ts", ".spec.ts")
      vim.cmd("e " .. possibleSpecTSFilePath)
      return
    end
  end
end, {})


-- Telescoe commands
vim.api.nvim_create_user_command("Quickfix", function()
  require('telescope.builtin').quickfix()
end, {})

vim.api.nvim_create_user_command("Maps", function()
  require('telescope.builtin').keymaps()
end, {})

vim.api.nvim_create_user_command("Colorscheme", function()
  require('telescope.builtin').colorscheme()
end, {})


vim.api.nvim_create_user_command("Ag", function(params)
  local builtin = require('telescope.builtin')
  local fullArgs = params.args
  local search = fullArgs:match("\"(.-)\"") or fullArgs:match("'(.-)'")
  local glob_pattern = nil

  local glob_index = string.find(fullArgs, " --glob ")

  if (glob_index) then
    glob_pattern = string.sub(fullArgs, glob_index + 6)
  end

  if search == nil then
    search = glob_index and string.sub(fullArgs, 1, glob_index - 2) or fullArgs
  end

  search = search:gsub("^%s*(.-)%s*$", "%1")

  local aditional_args = {}

  if glob_pattern then
    table.insert(aditional_args, "--glob")
    table.insert(aditional_args, glob_pattern)

    --ignore hidden files
    table.insert(aditional_args, "--glob")
    table.insert(aditional_args, "!.*")
  end

  builtin.grep_string({
    search = search,
    additional_args = aditional_args
  })
end, { nargs = '?' })


-- local function stdout(_, data)
--   print("success");
-- end

-- local function stderr(_, err)
--   print("Error")
-- end

-- vim.api.nvim_create_user_command("TestsAll", function()
--   vim.g.test_all_status = -1
--   vim.fn.jobstart("npm run jest", {
--     on_exit = function(jid, data)
--       vim.g.test_all_status = data
--       print("result", vim.inspect(jid), vim.inspect(data))
--     end,
--     stdout_buffered = true,
--   })
-- end, {})



-- function CodeRunner()
--   print("got executed")
-- end

-- vim.cmd "autocmd QuickFixCmdPost cgetfile * lua CodeRunner()"



-- function! Get_Selection()
--   " Why is this not a built-in Vim script function?!
--   let [lnum1, col1] = getpos("'<")[1:2]
--   let [lnum2, col2] = getpos("'>")[1:2]
--   let lines = getline(lnum1, lnum2)
--   let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
--   let lines[0] = lines[0][col1 - 1:]
--   return join(lines,'\n')
-- endfunction
-- translate the above function to lua

local function get_selection()
  local lnum1, col1 = unpack(vim.api.nvim_buf_get_mark(0, "<"))
  local lnum2, col2 = unpack(vim.api.nvim_buf_get_mark(0, ">"))
  local lines = vim.api.nvim_buf_get_lines(0, lnum1 - 1, lnum2, false)
  lines[#lines] = lines[#lines]:sub(1, col2 + 1)
  lines[1] = lines[1]:sub(col1 + 1)
  return table.concat(lines, "\n")
end

-- function! Get_visual_selection()
--   " Why is this not a built-in Vim script function?!
--   let selection = Get_Selection()
--   let change = input('Replace with: ')
--   if change !=  ""
--     execute ":%s/".selection."/".change."/g"
--   endif
-- endfunction

function Get_visual_selection()
  local selection = get_selection()
  local change = vim.fn.input('Replace with: ')
  if change ~= "" then
    vim.api.nvim_command(":%s/" .. selection .. "/" .. change .. "/g")
  end
end

-- function! Get_visual_selection_rg()
--   " Why is this not a built-in Vim script function?!
--   let selection = Get_Selection()
--   " let change = input('Replace with: ')
--   execute ":Ag \"".selection."\""
-- endfunction
function Get_visual_selection_rg()
  local selection = get_selection()
  vim.api.nvim_command(":Ag \"" .. selection .. "\"")
end

-- function! Get_visual_selection_ag_folder()
--   " Why is this not a built-in Vim script function?!
--   let selection = Get_Selection()
--   let folder = input('Folder: ', "", "file")
--   if folder !=  ""
--     execute ":Ag ".selection." ".folder
--   endif
-- endfunction
function Get_visual_selection_ag_folder()
  local selection = get_selection()
  local folder = vim.fn.input('Folder: ', "", "file")
  if folder ~= "" then
    vim.api.nvim_command(":Ag " .. selection .. " " .. folder)
  end
end

-- " if selection mode : grab selection
-- " if normal mode: prompt command
-- " if normal mode differnt command: grap word

-- " makes * and # work on visual mode too.
-- function! s:VSetSearch(cmdtype)
--   let temp = @s
--   norm! gv"sy
--   let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
--   let @s = temp
-- endfunction

function VSetSearch(cmdtype)
  local temp = vim.fn.getreg('s')
  vim.cmd('normal! gv"sy')
  local s = vim.fn.getreg('s')
  local escaped_s = vim.fn.substitute(vim.fn.escape(s, cmdtype .. '\\'), '\n', '\\\\n', 'g')
  vim.fn.setreg('/', '\\V' .. escaped_s)
  vim.fn.setreg('s', temp)
end

vim.keymap.set('x', '*', ':<C-u>call v:lua.VSetSearch("/")<CR>/<C-R>=@/<CR><CR>', { noremap = true })

-- " Mappings
vim.keymap.set('v', '<leader>r', ':<C-u>call v:lua.Get_visual_selection()<CR>')
vim.keymap.set('v', '<leader>af', ':<C-u>call v:lua.Get_visual_selection_ag_folder()<CR>')


-- " Easier fold toggling
vim.keymap.set('n', '<leader>S', ':%s//gc<Left><Left><Left>', { noremap = true })
vim.keymap.set('n', 's*', ':let @/=\'\\<\'..expand(\'<cword>\')..\'\\>\'<CR>cgn', { noremap = true, silent = true })
vim.keymap.set('x', 's*', '"sy:let @/=@s<CR>cgn', { noremap = true, silent = true })
-- " Start substitute on current word under the cursor
-- " nnoremap <Leader>r :%s///g<Left><Left>
-- " nnoremap <Leader>rc :%s///gc<Left><Left>
-- nnoremap <Leader>R :cfdo %s//g \| update<C-Left><C-Left><Left><Left><Left><Left>
vim.keymap.set('n', '<leader>R', ':cfdo %s///g | update<C-Left><C-Left><Left><Left><Left><Left>',
  { noremap = true })



local function getVisualSelection()
  vim.cmd('noau normal! "vy"')
  local text = vim.fn.getreg("v")
  vim.fn.setreg("v", {})

  text = string.gsub(text, "\n", "")
  if #text > 0 then
    return text
  else
    return ""
  end
end

vim.keymap.set("v", "<leader>*", function()
  local text = getVisualSelection()
  require('telescope.builtin').grep_string({ search = text })
end, {})
