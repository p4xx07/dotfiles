--  Luasnip configuration
--  This is currently commented out in the original init.lua
--  To enable, uncomment the following lines and adjust as needed

--  require "luasnip".setup({ enable_autosnippets = true })
--  require "luasnip.loaders.from_lua".load({ paths = "~/.config/nvim/snippets/" })

--  local ls = require("luasnip")
--  local map = vim.keymap.set

--  -- Expand snippet
--  map({ "i" }, "<C-e>", function() ls.expand() end, { silent = true })

--  -- Jump forward and backward through snippet placeholders
--  map({ "i", "s" }, "<C-J>", function() ls.jump(1) end, { silent = true })
--  map({ "i", "s" }, "<C-K>", function() ls.jump(-1) end, { silent = true })

--  For more information on configuring Luasnip, see:
--  https://github.com/L3MON4D3/LuaSnip
