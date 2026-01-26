vim.cmd([[
  syntax enable
  filetype plugin indent on
]])
vim.cmd([[set mouse=a]])
vim.cmd([[set noswapfile]])
vim.cmd([[set completeopt+=menuone,noselect,noinsert,popup,preview]])
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
map("n", "<leader>rc", ":update<CR>:source $HOME/.config/nvim/init.lua<CR>")
map("n", "<leader>vc", ":e $MYVIMRC<CR>")
map("n", "<leader>vz", ":e ~/.zshrc<CR>")
map("n", "<leader>w", ":update<CR>")
map("n", "<leader>q", ":quit<CR>")
map("n", "<C-f>", ":Open .<CR>")
map("n", "<leader>te", ":term<CR>")

--clipboard
map({ "n", "v", "x" }, "<leader>y", '"+y<CR>')
map({ "n", "v", "x" }, "<leader>d", '"+d<CR>')
map({ "n", "v", "x" }, "<leader>p", '"+p<CR>')

--rename
vim.keymap.set("n", "<leader>rr", function()
	local word = vim.fn.expand("<cword>")
	vim.cmd("vim /" .. word .. "/ **/*")
end, { desc = "Search word under cursor with :vim" })

-- substitute

map({ "x", "n" }, "<C-s>", [[<esc>:'<,'>s/]], { desc = "Enter substitue mode in selection" })

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

map("n", "<S-q>", toggle_qf, { desc = "Toggle quickfix list" })
map("n", "<C-S-n>", ":cn<CR>")
map("n", "<C-S-p>", ":cp<CR>")

--resize
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>")
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>")
map("n", "<C-Up>", "<cmd>resize +2<CR>")
map("n", "<C-Down>", "<cmd>resize -2<CR>")

--file navigation
map({ "n", "v", "x" }, "<leader>e", ":e #<CR>")
map({ "n", "v", "x" }, "<leader>vs", ":rightbelow vs #<CR>")

--useful remaps
map("n", "''", "''zz")
map("t", "", "")
map("t", "<Esc>", "<C-\\><C-N>")
map("n", "G", "Gzz")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "{", "{zz")
map("n", "}", "}zz")

-- plugins
vim.pack.add({
	-- dependencies
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/MunifTanjim/nui.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
	{ src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },

	-- packages
	{ src = "https://github.com/saghen/blink.cmp" },
	{ src = "https://github.com/folke/zen-mode.nvim" },
	{ src = "https://github.com/christoomey/vim-tmux-navigator" },
	{ src = "https://github.com/nvim-neo-tree/neo-tree.nvim" },
	{ src = "https://github.com/nvim-mini/mini.hipatterns" },
	{ src = "https://github.com/vague2k/vague.nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" }, -- depends on mini, treesitter
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-context" },
	{ src = "https://github.com/folke/flash.nvim" },
	{ src = "https://github.com/stevearc/conform.nvim" },

	-- debug
	{ src = "https://github.com/mfussenegger/nvim-dap" },
	{ src = "https://github.com/mfussenegger/nvim-dap-python" },
	{ src = "https://github.com/leoluz/nvim-dap-go" },
	{ src = "https://github.com/theHamsta/nvim-dap-virtual-text" },
	{ src = "https://github.com/rcarriga/nvim-dap-ui" },
	{ src = "https://github.com/nvim-neotest/nvim-nio" },

	-- (Optional) nice extras for quality of life
	{ src = "https://github.com/folke/trouble.nvim" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	{ src = "https://github.com/pocco81/auto-save.nvim" },

	--golang
	{ src = "https://github.com/ray-x/go.nvim" },
	{ src = "https://github.com/ray-x/guihua.lua" },
	{ src = "https://github.com/sebdah/vim-delve" },
	{ src = "https://github.com/meain/vim-jsontogo" },
})

-- Auto-load all plugin files
local plugin_dir = vim.fn.stdpath("config") .. "/plugins"
local success, files = pcall(vim.fn.readdir, plugin_dir)
if success and files then
	for _, file in ipairs(files) do
		if file:match("%.lua$") then
			-- Construct the full path to the plugin file
			local plugin_path = plugin_dir .. "/" .. file
			-- Load the file directly using dofile
			local ok, err = pcall(dofile, plugin_path)
			if not ok then
				vim.api.nvim_echo({ { "Error loading " .. file .. ": " .. err, "Error" } }, true, {})
			end
		end
	end
end
