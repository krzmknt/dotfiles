local pluginLoader = require("util.pluginLoader")
local plugin = pluginLoader.load({ pluginName = "dap-vscode-js", enable = false })
if plugin == nil then return end

plugin.setup({
  -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
  -- debugger_path = "(runtimedir)/site/pack/packer/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
  debugger_path = "/Users/krzmknt/ghq/github.com/microsoft/vscode-js-debug",                   -- Path to vscode-js-debug installation.
  -- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
  adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
  -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
  -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
  -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
})

for _, language in ipairs({ "typescript", "javascript" }) do
  require("dap").configurations[language] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      cwd = "${workspaceFolder}",
    },
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach",
      processId = require("dap.utils").pick_process,
      cwd = "${workspaceFolder}",
    },
    {
      type = "pwa-node",
      request = "launch",
      name = "Debug Jest Tests",
      -- trace = true, -- include debugger info
      runtimeExecutable = "node",
      runtimeArgs = {
        "./node_modules/jest/bin/jest.js",
        "--runInBand",
      },
      rootPath = "${workspaceFolder}",
      cwd = "${workspaceFolder}",
      console = "integratedTerminal",
      internalConsoleOptions = "neverOpen",
    },
  }
end


-- ====================================
-- Python debugger
-- ------------------------------------
local venv = os.getenv('VIRTUAL_ENV')
local command = string.format('%s/bin/python', venv)

require('dap-python').setup(command)


-- ====================================
-- DAP UI
-- ------------------------------------
require("dapui").setup({
  icons = { expanded = "", collapsed = "" },
  layouts = {
    {
      elements = {
        { id = "watches",     size = 0.20 },
        { id = "stacks",      size = 0.20 },
        { id = "breakpoints", size = 0.20 },
        { id = "scopes",      size = 0.40 },
      },
      size = 64,
      position = "right",
    },
    {
      elements = {
        "repl",
        "console",
      },
      size = 0.20,
      position = "bottom",
    },
  },
})
