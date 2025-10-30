vim.cmd([[set mouse=a]])
vim.cmd([[set noswapfile]])
vim.cmd [[set completeopt+=menuone,noselect,noinsert,popup,preview]]
vim.o.tabstop = 2
vim.o.cursorcolumn = false
vim.o.ignorecase = true
vim.o.shiftwidth = 2
vim.o.smartindent = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"
vim.o.wrap = false
vim.o.tabstop = 4
vim.o.swapfile = false
vim.o.termguicolors = true
vim.o.undofile = true
vim.o.incsearch = true
vim.o.winborder = "rounded"

vim.g.mapleader = " "

local map = vim.keymap.set

--saving, reloading
map('n', '<leader>rc', ':update<CR>:source $HOME/.config/nvim/init.lua<CR>')
map('n', '<leader>vc', ':e $MYVIMRC<CR>')
map('n', '<leader>vz', ':e ~/.zshrc<CR>')
map('n', '<leader>w', ':update<CR>')
map('n', '<leader>q', ':quit<CR>')
map('n', '<C-f>', ':Open .<CR>')
map('n', '<leader>te', ":term<CR>")

--clipboard
map({ 'n', 'v', 'x' }, '<leader>y', '"+y<CR>')
map({ 'n', 'v', 'x' }, '<leader>d', '"+d<CR>')
map({ 'n', 'v', 'x' }, '<leader>p', '"+p<CR>')

--rename
vim.keymap.set('n', '<leader>rr', function()
	local word = vim.fn.expand('<cword>')
	vim.cmd('vim /' .. word .. '/ **/*')
end, { desc = 'Search word under cursor with :vim' })

-- substitute

map({ "x", "n" }, "<C-s>", [[<esc>:'<,'>s/]],
	{ desc = "Enter substitue mode in selection" })

-- quickfix list
--
-- Function to toggle quickfix
-- use :vim command to find text inside files mathing that path
-- :vim text */**, :vim gringo.txt

local function toggle_qf()
	local qf_exists = false
	for _, win in ipairs(vim.fn.getwininfo()) do
		if win.quickfix == 1 then
			qf_exists = true
			break
		end
	end
	if qf_exists then
		vim.cmd("cclose")
	else
		vim.cmd("copen")
	end
end

map('n', '<S-q>', toggle_qf, { desc = 'Toggle quickfix list' })
map('n', '<leader>qn', ':cn<CR>')
map('n', '<leader>qp', ':cp<CR>')

--resize
map('n', '<C-Left>', '<cmd>vertical resize -2<CR>')
map('n', '<C-Right>', '<cmd>vertical resize +2<CR>')
map('n', '<C-Up>', '<cmd>resize +2<CR>')
map('n', '<C-Down>', '<cmd>resize -2<CR>')

--file navigation
map({ 'n', 'v', 'x' }, '<leader>e', ':e #<CR>')
map({ 'n', 'v', 'x' }, '<leader>vs', ':rightbelow vs #<CR>')

--useful remaps
map('n', "''", "''zz")
map('t', '', "")
map('t', "<Esc>", "<C-\\><C-N>")

-- plugins
vim.pack.add({
  -- dependencies
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/MunifTanjim/nui.nvim"},
	{ src = "https://github.com/folke/snacks.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },

  -- packages
	{ src = "https://github.com/nvim-neo-tree/neo-tree.nvim"},
	{ src = "https://github.com/nvim-tree/nvim-tree.lua" },
	{ src = "https://github.com/nvim-mini/mini.hipatterns" },
	{ src = "https://github.com/vague2k/vague.nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/ThePrimeagen/harpoon", version="harpoon2" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/nvzone/showkeys", cmd = "ShowkeysToggle" },
	{ src = "https://github.com/L3MON4D3/LuaSnip" },
	{ src = "https://github.com/smithbm2316/centerpad.nvim" },
	{ src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" }, -- depends on mini, treesitter
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-context" },

	-- debug
	{ src = "https://github.com/mfussenegger/nvim-dap" },
	{ src = "https://github.com/mfussenegger/nvim-dap-python" },
	{ src = "https://github.com/theHamsta/nvim-dap-virtual-text" },
	{ src = "https://github.com/nvim-neotest/nvim-nio" },
	{ src = "https://github.com/rcarriga/nvim-dap-ui" },

	-- Completion engine
	{ src = "https://github.com/hrsh7th/nvim-cmp" },
	{ src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
	{ src = "https://github.com/hrsh7th/cmp-buffer" },
	{ src = "https://github.com/hrsh7th/cmp-path" },
	{ src = "https://github.com/saadparwaiz1/cmp_luasnip" },

	-- (Optional) nice extras for quality of life
	{ src = "https://github.com/folke/trouble.nvim" },     -- diagnostics list
	{ src = "https://github.com/onsails/lspkind.nvim" },

	{ src = "https://github.com/NickvanDyke/opencode.nvim" },
  })


-- Auto-load all plugin files
local plugin_dir = vim.fn.expand("~/dotfiles/nvim/.config/nvim/plugins")
local success, files = pcall(vim.fn.readdir, plugin_dir)
if success and files then
  for _, file in ipairs(files) do
    if file:match("%.lua$") then
      local plugin_name = file:sub(1, -5)
      local ok, err = pcall(require, "plugins." .. plugin_name)
      if not ok then
        vim.api.nvim_echo({{"Error loading " .. plugin_name .. ": " .. err, "Error"}}, true, {})
      end
    end
  end
end

