local dap = require('dap')
local dapui = require('dapui')
local dapgo = require('dap-go')

local function find_main_go()
  local cwd = vim.fn.expand("%:p:h")
  while cwd ~= "/" do
    local candidate = cwd .. "/main.go"
    if vim.fn.filereadable(candidate) == 1 then
      return candidate
    end
    cwd = vim.fn.fnamemodify(cwd, ":h")
  end
  return vim.fn.expand("%:p")
end

dap.configurations.go = {
  {
    type = "go",
    name = "Debug main.go",
    request = "launch",
    program = find_main_go,
  },
  {
    type = "go",
    name = "Debug main.go with ENV=DEBUG",
    request = "launch",
    program = find_main_go,
	env = {
      ENVIRONMENT = "DEBUG",
    },
  },
  {
    type = "go",
    name = "Debug main.go (with args)",
    request = "launch",
    program = find_main_go,
    args = function()
      local input = vim.fn.input("Args: ")
      return vim.fn.split(input, " ")
    end,
  },
}

dapgo.setup()
dapui.setup()
require("nvim-dap-virtual-text").setup()

-- Keybindings
vim.keymap.set('n', '<leader>ds', dap.continue, { desc = "Start/Continue Debugging" })
vim.keymap.set('n', '<F1>', dap.step_over, { desc = "Step Over" })
vim.keymap.set('n', '<F2>', dap.step_into, { desc = "Step Into" })
vim.keymap.set('n', '<F3>', dap.step_out, { desc = "Step Out" })
vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
vim.keymap.set('n', '<leader>B', function()
  dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
end, { desc = "Conditional Breakpoint" })
vim.keymap.set('n', '<leader>dr', dap.repl.toggle, { desc = "Toggle REPL" })
vim.keymap.set('n', '<leader>du', dapui.toggle, { desc = "Toggle Debug UI" })

local function with_center(step_fn)
  return function()
    step_fn()
    vim.cmd("normal! zz")
  end
end
-- Save previous mappings to restore later
local saved_mappings = {}

-- Debug layer keys (Shift+J/K/L)
local debug_keys = {
  J = { with_center(dap.step_over), "Step Over" },
  H = { with_center(dap.step_out),  "Step Out" },
  L = { with_center(dap.step_into), "Step Into" },
  R = { dap.repl.toggle, "Toggle REPL" },
  S = { dap.disconnect, "Stop"},
  U = { dapui.toggle, "Toggle Debug UI" },
  B = { dap.toggle_breakpoint, "Toggle Breakpoint" },
  C = { function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, "Conditional Breakpoint" },
}

local function enter_debug_layer()
  for key, mapping in pairs(debug_keys) do
    local prev = vim.fn.maparg(key, "n", false, true)

    if prev and type(prev) == "table" and prev.rhs and prev.rhs ~= "" then
      saved_mappings[key] = prev.rhs
    end

    vim.keymap.set('n', key, mapping[1], { desc = mapping[2]})
  end

  require("zen-mode").close()
  dapui.open()
end

local function exit_debug_layer()
  for key, _ in pairs(debug_keys) do
    vim.keymap.del('n', key)

    local rhs = saved_mappings[key]
    if rhs then
      vim.api.nvim_set_keymap('n', key, rhs, { noremap = true, silent = true })
      saved_mappings[key] = nil
    end
  end
end

dap.listeners.after.event_initialized["layer"] = enter_debug_layer

local function on_terminate()
	exit_debug_layer()
	pcall(function() require("nvim-dap-virtual-text").clear() end)
	pcall(function() require("dapui").close() end)
	vim.cmd("redraw!")
end 

dap.listeners.before.event_terminated["layer"] = on_terminate

vim.keymap.set('n', '<leader>de', exit_debug_layer, { desc = "Exit debug layer" })
