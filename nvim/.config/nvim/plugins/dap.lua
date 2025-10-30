require("nvim-dap-virtual-text").setup()
require("dapui").setup()

local dap = require("dap")

-- DAP key mappings
vim.keymap.set("n", ",b", dap.toggle_breakpoint)
vim.keymap.set("n", ",r", dap.continue)
vim.keymap.set("n", ",i", dap.step_into)
vim.keymap.set("n", ",n", dap.step_over)
vim.keymap.set("n", ",o", dap.step_out)
vim.keymap.set("n", ",p", dap.pause)
vim.keymap.set("n", ",s", dap.terminate)
vim.keymap.set("n", ",c", function() require("dapui").toggle() end, { desc = "Toggle DAP UI" })
vim.keymap.set("n", ",m", function() require("dap").repl.open() end, { desc = "Open DAP REPL" })

-- Python debug adapter setup
local python = vim.fn.expand("~/.local/share/nvim/mason/packages/debugpy/venv/bin/python")
require("dap-python").setup(python)
