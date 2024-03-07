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

vim.api.nvim_set_keymap('n', 'ta', ':Alternate<CR>', { noremap = true })




vim.api.nvim_create_user_command("Ag", function(params)
  local builtin = require('telescope.builtin')
  local fullArgs = params.args
  local search, glob_pattern = unpack(vim.split(fullArgs, " "))

  builtin.grep_string({
    search = search,
    additional_args = {"--glob", glob_pattern or "*" }
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
