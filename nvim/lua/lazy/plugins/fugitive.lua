-- Git diff navigation module with proper file closing
local M = {}

-- State to track current file index
M.current_file_index = 0
M.changed_files = {}
M.config = {
  include_staged = true,
  include_unstaged = true,
  include_untracked = false,
  auto_center = true,
  show_progress = true,
}

-- Function to get all changed files from git status
local function get_changed_files()
  local commands = {}

  if M.config.include_staged then
    table.insert(commands, "git diff --cached --name-only")
  end

  if M.config.include_unstaged then
    table.insert(commands, "git diff --name-only")
  end

  if M.config.include_untracked then
    table.insert(commands, "git ls-files --others --exclude-standard")
  end

  local all_files = {}
  local seen = {}

  for _, cmd in ipairs(commands) do
    local handle = io.popen(cmd .. " 2>/dev/null")
    if handle then
      local result = handle:read("*a")
      handle:close()

      for file in result:gmatch("[^\r\n]+") do
        if vim.fn.filereadable(file) == 1 and not seen[file] then
          table.insert(all_files, file)
          seen[file] = true
        end
      end
    end
  end

  return all_files
end

-- Function to properly close diff and clean up windows
local function close_current_diff()
  -- Check if we're in diff mode
  if vim.opt.diff:get() then
    -- Turn off diff mode for all windows
    vim.cmd("diffoff!")

    -- Get current window count
    local win_count = vim.fn.winnr('$')

    -- If there are multiple windows, close all but the current one
    if win_count > 1 then
      vim.cmd("only")
    end
  else
    -- If not in diff mode but multiple windows exist, still clean up
    local win_count = vim.fn.winnr('$')
    if win_count > 1 then
      vim.cmd("only")
    end
  end
end

-- Enhanced navigation function with proper cleanup
function M.navigate_to_file(direction)
  M.changed_files = get_changed_files()

  if #M.changed_files == 0 then
    vim.notify("No changed files found", vim.log.levels.WARN)
    return
  end

  -- Store current file path before navigation
  local current_file = vim.fn.expand('%:p')

  if direction == "next" then
    M.current_file_index = M.current_file_index + 1
    if M.current_file_index > #M.changed_files then
      M.current_file_index = 1
    end
  elseif direction == "prev" then
    M.current_file_index = M.current_file_index - 1
    if M.current_file_index < 1 then
      M.current_file_index = #M.changed_files
    end
  elseif direction == "first" then
    M.current_file_index = 1
  elseif direction == "last" then
    M.current_file_index = #M.changed_files
  end

  local target_file = M.changed_files[M.current_file_index]
  local target_file_full = vim.fn.fnamemodify(target_file, ':p')

  -- Only proceed if we're navigating to a different file
  if current_file ~= target_file_full then
    -- Close current diff and clean up windows
    close_current_diff()

    -- Open the new file
    vim.cmd("edit " .. vim.fn.fnameescape(target_file))
  end

  -- Check if file has changes to diff
  local has_changes = vim.fn.system("git diff HEAD -- " .. vim.fn.shellescape(target_file)) ~= ""

  if has_changes then
    -- Open in diff mode
    vim.cmd("Gvdiffsplit")

    if M.config.auto_center then
      -- Small delay to ensure diff is loaded before centering
      vim.defer_fn(function()
        vim.cmd("normal! zz")
      end, 50)
    end
  else
    vim.notify("File has no changes to diff", vim.log.levels.WARN)
  end

  if M.config.show_progress then
    vim.notify(
      string.format("File %d/%d: %s", M.current_file_index, #M.changed_files, target_file),
      vim.log.levels.INFO
    )
  end
end

-- Function to show current status
function M.show_status()
  M.changed_files = get_changed_files()

  if #M.changed_files == 0 then
    vim.notify("No changed files found", vim.log.levels.WARN)
    return
  end

  local status_lines = { "Changed files:" }
  for i, file in ipairs(M.changed_files) do
    local marker = (i == M.current_file_index) and "→ " or "  "
    table.insert(status_lines, marker .. i .. ". " .. file)
  end

  vim.notify(table.concat(status_lines, "\n"), vim.log.levels.INFO)
end

-- Configuration function
function M.setup(opts)
  M.config = vim.tbl_deep_extend("force", M.config, opts or {})
end

M.next_changed_file = function() M.navigate_to_file("next") end
M.prev_changed_file = function() M.navigate_to_file("prev") end

-- Create user commands
vim.api.nvim_create_user_command('GitDiffNext', M.next_changed_file, {
  desc = 'Open next changed file in vimdiff'
})

vim.api.nvim_create_user_command('GitDiffPrev', M.prev_changed_file, {
  desc = 'Open previous changed file in vimdiff'
})

-- Rest of the functions remain the same...

return {
  'tpope/vim-fugitive',
  dependencies = {
    "tpope/vim-rhubarb",
  },
  config = function()
    local opts = { noremap = true, silent = true }
    vim.keymap.set("n", "gs", ":abo Git<CR>", opts)
    vim.keymap.set({ "n", "v" }, "go", ":GBrowse<CR>", opts)
    vim.keymap.set("n", "gd", ":Gvdiff<CR>", opts)
    vim.keymap.set("n", "gu", ":Dispatch git up<CR>", opts)
    vim.keymap.set("n", "gp", ":echom('Pushing... ') | Dispatch git push<CR>", opts)
    vim.keymap.set("n", "<leader>gf", ":echom('Force pushing... ') | Dispatch git push --force-with-lease<CR>", opts)
    vim.keymap.set("n", "gb", ":Git blame<CR>", opts)
    vim.keymap.set("n", "gcpr", ":Dispatch gh pr create -f<CR>", opts)
    vim.keymap.set("n", "gopr", ":Dispatch gh pr view --web<CR>", opts)

    vim.api.nvim_create_autocmd("OptionSet", {
      group = vimdiff_group,
      pattern = "diff",
      callback = function()
        if vim.opt.diff:get() then
          vim.keymap.set("n", "<Tab>", "]c", { noremap = true, silent = true, buffer = true })
          vim.keymap.set("n", "<S-Tab>", "[c", { noremap = true, silent = true, buffer = true })


          -- navigate between changed files
          vim.keymap.set("n", "gn", M.next_changed_file, { noremap = true, silent = true, buffer = true })
          vim.keymap.set("n", "gp", M.prev_changed_file, { noremap = true, silent = true, buffer = true })
        end
      end,
    })
  end
}
