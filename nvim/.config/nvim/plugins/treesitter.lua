require"nvim-treesitter.configs".setup {
  ensure_installed = {
    -- Core programming
    "c",
    "cpp",
    "c_sharp",
    "go",
    "python",
    "java",
    "lua",

    -- Web dev
    "html",
    "css",
    "javascript",
    "typescript",
    "json",
    "yaml",

    -- DevOps / config
    "dockerfile",
    "bash",
    "toml",
    "ini",

    -- Documentation / text
    "markdown",
    "markdown_inline",
    "vim",
    "vimdoc",
    "query",

    -- SQL and data
    "sql",
    "csv"
  },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

-- treesitter-context configuration
require"treesitter-context".setup{
  enable = true,
  multiwindow = false,
  max_lines = 0,
  min_window_height = 0,
  line_numbers = true,
  multiline_threshold = 20,
  trim_scope = "outer",
  mode = "cursor",
  separator = nil,
  zindex = 20,
}
