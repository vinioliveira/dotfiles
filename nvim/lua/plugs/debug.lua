local dap = require('dap')

local function debugJest(testName, filename)
  print("starting " .. testName .. " in " .. filename)
  dap.run({
    type = 'pwa-node',
    request = 'launch',
    runtimeExecutable = "node",
    name = "Debug Jest Tests",
    -- cwd = vim.fn.getcwd(),
    -- program = vim.fn.getcwd() .. '/node_modules/jest/bin/jest.js',
    -- args = { '--config', 'jest.config.js', '-t', testName, '--', filename },
    runtimeArgs = {
      "./node_modules/jest/bin/jest.js",
      "--config",
      "./jest.config.js",
      "-t",
      testName,
      "--",
      filename
    },
    -- rootPath = "${workspaceFolder}",
    -- cwd = "${workspaceFolder}",
    console = "integratedTerminal",
    internalConsoleOptions = "neverOpen",
    port = 9229,
    -- outputCapture = 'console',
    -- diagnosticLogging = true,
    -- verboseDiagnosticLogging = true,
    -- disableOptimisticBPs = true,
    skipFiles = {
      '<node_internals>/**/*.js',
      "${workspaceFolder}/node_modules/**",
    },
    resolveSourceMapLocations = {
      "${workspaceFolder}/**",
      "!**/node_modules/**"
    }
    -- sourceMaps = 'inline',
    -- sourceMapPathOverrides = {
    -- ["*"] = "${workspaceFolder}/*",
    -- },
    -- outFiles = { "${workspaceFolder}/dist/**/*.js" },
  })
end

local function attach()
  print("attaching")
  dap.run({
    type = 'node2',
    request = 'attach',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    skipFiles = { '<node_internals>/**/*.js' },
  })
end

local function attachToRemote()
  print("attaching")
  dap.run({
    type = 'node2',
    request = 'attach',
    address = "127.0.0.1",
    port = 9229,
    localRoot = vim.fn.getcwd(),
    remoteRoot = "/home/vcap/app",
    sourceMaps = true,
    protocol = 'inspector',
    skipFiles = { '<node_internals>/**/*.js' },
  })
end

return {
  debugJest = debugJest,
  attach = attach,
  attachToRemote = attachToRemote,
}
