require "vague".setup({transparent = true})
vim.cmd("colorscheme vague")
vim.cmd(":hi statusline guibg=NONE")

-- mini.hipatterns configuration
local hipatterns = require('mini.hipatterns')
hipatterns.setup({
  highlighters = {
    -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE', 'WARN'
    fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
    hack  = { pattern = '%f[%w]()HACK()%f[%W]',  group = 'MiniHipatternsHack'  },
    warn  = { pattern = '%f[%w]()WARN()%f[%W]',  group = 'MiniHipatternsHack'  },
    todo  = { pattern = '%f[%w]()TODO()%f[%W]',  group = 'MiniHipatternsTodo'  },
    note  = { pattern = '%f[%w]()NOTE()%f[%W]',  group = 'MiniHipatternsNote'  },

    -- Highlight hex color strings (`#rrggbb`) using that color
    hex_color = hipatterns.gen_highlighter.hex_color(),
	-- #FF0000
	-- #00FF00
	-- #0000FF
  },
})

require("showkeys").setup({
  timeout = 1,
  maxkeys = 5,
  position = "bottom-right"
})

-- centerpad keymap
local map = vim.keymap.set
map("n", "<leader>cp", ":Centerpad<CR>")

-- neo-tree
require("neo-tree").setup({
  filesystem = {
    window = {
      position = "right",
    },
    filtered_items = {
      visible = true,
      hide_dotfiles = false,
      hide_gitignored = true,
    },
  }
})

vim.keymap.set('n', '<leader>nt', '<cmd>Neotree reveal toggle<CR>', {
  desc = 'NeoTree reveal',
  silent = true,
})

