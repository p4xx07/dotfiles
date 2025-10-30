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
