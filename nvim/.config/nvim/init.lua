vim.cmd([[set mouse=a]])
vim.cmd([[set noswapfile]])
vim.cmd [[set completeopt+=menuone,noselect,popup]]
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
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/folke/snacks.nvim" },



	{ src = "https://github.com/nvim-mini/mini.hipatterns" },
	{ src = "https://github.com/vague2k/vague.nvim" },
	{ src = "https://github.com/preservim/nerdtree" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
	{ src = "https://github.com/ThePrimeagen/harpoon", version="harpoon2" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/NvChad/showkeys" },
	{ src = "https://github.com/L3MON4D3/LuaSnip" },
	{ src = "https://github.com/smithbm2316/centerpad.nvim" },
	{ src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" }, -- depends on mini, treesitter
	{ src = "https://github.com/NickvanDyke/opencode.nvim" },
})

--mini.hipatterns
local hipatterns = require('mini.hipatterns')
hipatterns.setup({
  highlighters = {
    -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
    fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
    hack  = { pattern = '%f[%w]()HACK()%f[%W]',  group = 'MiniHipatternsHack'  },
    todo  = { pattern = '%f[%w]()TODO()%f[%W]',  group = 'MiniHipatternsTodo'  },
    note  = { pattern = '%f[%w]()NOTE()%f[%W]',  group = 'MiniHipatternsNote'  },

    -- Highlight hex color strings (`#rrggbb`) using that color
    hex_color = hipatterns.gen_highlighter.hex_color(),
	-- #FF0000
	-- #00FF00
	-- #0000FF
  },
})

-- oil
require "mason".setup()

-- snacks and open code
require("snacks").setup({
	input = {},
	picker = {},
})

vim.g.opencode_opts = {}
vim.opt.autoread = true

map({ "n", "x" }, "<leader>oa", function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "Ask about this" })
map({ "n", "x" }, "<leader>o+", function() require("opencode").prompt("@this") end, { desc = "Add this" })
map({ "n", "x" }, "<leader>os", function() require("opencode").select() end, { desc = "Select prompt" })
map("n", "<leader>ot", function() require("opencode").toggle() end, { desc = "Toggle embedded" })
map("n", "<leader>on", function() require("opencode").command("session_new") end, { desc = "New session" })
map("n", "<leader>oi", function() require("opencode").command("session_interrupt") end, { desc = "Interrupt session" })
map("n", "<leader>oA", function() require("opencode").command("agent_cycle") end, { desc = "Cycle selected agent" })
map("n", "<S-C-u>", function() require("opencode").command("messages_half_page_up") end, { desc = "Messages half page up" })
map("n", "<S-C-d>", function() require("opencode").command("messages_half_page_down") end, { desc = "Messages half page down" })

-- telescope
--
require('telescope').setup{
  defaults = {
    layout_config = {
      width = 0.95,
      height = 0.95,
	  preview_width = 0.6,
    },
  },
}

local builtin = require 'telescope.builtin'
map('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
map('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
map('n', '<leader>sf', ":Telescope find_files hidden=true<CR>", { desc = '[S]earch [F]iles' })
map('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
map('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
map('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
map('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
map('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
map('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
map('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
map('n', '<leader>st', ":TodoTelescope<CR>", { desc = '[S]earch [T]odos' })

--harpoon
local harpoon = require "harpoon"
harpoon.setup()
map("n", "<leader>a", function() harpoon:list():add() end)
map("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
map("n", "<C-h>", function() harpoon:list():select(1) end)
map("n", "<C-t>", function() harpoon:list():select(2) end)
map("n", "<C-n>", function() harpoon:list():select(3) end)
map("n", "<C-s>", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
map("n", "<C-S-P>", function() harpoon:list():prev() end)
map("n", "<C-S-N>", function() harpoon:list():next() end)


-- oil
require "oil".setup()
map('n', '<leader>oi', ":Oil<CR>")

-- centerpad
map('n', '<leader>cp', ":Centerpad<CR>")

--colors
require "vague".setup({transparent = true})
vim.cmd("colorscheme vague")
vim.cmd(":hi statusline guibg=NONE")

--snippets
--require "luasnip".setup({ enable_autosnippets = true })
--require "luasnip.loaders.from_lua".load({ paths = "~/.config/nvim/snippets/" })

-- local ls = require("luasnip")
--map({ "i" }, "<C-e>", function() ls.expand() end, { silent = true })
--map({ "i", "s" }, "<C-J>", function() ls.jump(1) end, { silent = true })
--map({ "i", "s" }, "<C-K>", function() ls.jump(-1) end, { silent = true })

-- NERDTree
map('n', '<leader>nt', ":NERDTreeToggle<CR>")
map('n', '<leader>ns', ":NERDTreeFind<CR>")

--lsp
vim.lsp.enable({
	"lua_ls",
	"pyright",
	"gopls"
})

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true)
			}
		}
	}
})

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client:supports_method('textDocument/completion') then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
	end,
})

-- treesitter
require 'nvim-treesitter.configs'.setup {
	ensure_installed = { "go", "typescript", "javascript", "css", "python", "dockerfile", "java" },
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
}
