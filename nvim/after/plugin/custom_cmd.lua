vim.api.nvim_create_user_command("VPR", function()
  local command = "Dispatch npm run format:check -- --base=origin/develop && npm run typecheck  && npm run lint -- --base=origin/develop"
  vim.fn.execute(command)
end, {})



vim.api.nvim_create_user_command("Outline", function()
  vim.lsp.buf_request(0, 'textDocument/documentSymbol', vim.lsp.util.make_position_params(), function(err, method, result)
    print(err, vim.inspect(method), vim.inspect(result))
  end)
end, {})


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
