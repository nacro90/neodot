local M = {}

local dap = require "dap"
local dap_vt = require "nvim-dap-virtual-text"
local dap_ui = require "dapui"
local dap_telescope = require('telescope').extensions.dap

local dap_go = require "dap-go"

local function setup_signs()
  vim.fn.sign_define("DapBreakpoint", {
    text = "⬤",
    texthl = "ErrorMsg",
    linehl = "DiffDelete",
    numhl = "DiffDelete",
  })
  vim.fn.sign_define("DapBreakpointRejected", {
    text = "∅",
    texthl = "NonText",
    linehl = "",
    numhl = "",
  })
  vim.fn.sign_define("DapStopped", {
    text = "▶",
    texthl = "Constant",
    linehl = "Visual",
    numhl = "Visual",
  })
end

local function setup_keymaps()
  vim.keymap.set("n", "<leader>dd", dap.continue, { silent = true })
  vim.keymap.set("n", "<leader>dn", dap.step_over, { silent = true })
  vim.keymap.set("n", "<leader>di", dap.step_into, { silent = true })
  vim.keymap.set("n", "<leader>do", dap.step_out, { silent = true })
  vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { silent = true })
  vim.keymap.set("n", "<leader>dB", dap_telescope.list_breakpoints, { silent = true })
  vim.keymap.set("n", "<leader>df", dap_telescope.frames, { silent = true })
  vim.keymap.set("n", "<leader>d<C-b>", function()
    dap.set_breakpoint(vim.fn.input "Breakpoint condition: ")
  end, {
    silent = true,
  })
  vim.keymap.set("n", "<leader>dq", dap.terminate)
  vim.keymap.set("n", "<leader>dc", dap.clear_breakpoints)
  vim.keymap.set("n", "<leader>du", dap_ui.toggle)
end

local function setup_dap_ui()
  dap_ui.setup()

  dap.listeners.after.event_initialized["dapui_config"] = function()
    dap_ui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dap_ui.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dap_ui.close()
  end
end

function M.setup()
  setup_signs()
  setup_keymaps()
  setup_dap_ui()

  dap_vt.setup()

  dap_go.setup()
end

return M
