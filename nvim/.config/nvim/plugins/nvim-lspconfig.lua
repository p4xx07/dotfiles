-- List of servers to set up
local servers = {
  "lua_ls",
  "pyright",
  "gopls",
  "clangd",
  "dockerls",
  "docker_compose_language_service",
  "omnisharp",
  "jdtls",
  "html",
  "cssls",
  "ts_ls",
  "yamlls",
  "bashls",
  "zls"
}

local capabilities = require("blink.cmp").get_lsp_capabilities()

-- Setup LSP servers
for _, server in ipairs(servers) do
  require("lspconfig")[server].setup({
    capabilities = capabilities,
  })
end

-- Keymaps for LSP functionality
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    vim.keymap.set("n", "grn", vim.lsp.buf.rename, { desc = "[R]e[n]ame", buffer = ev.buf })
    vim.keymap.set({ "n", "x" }, "gra", vim.lsp.buf.code_action, { desc = "[G]oto Code [A]ction", buffer = ev.buf })
    vim.keymap.set("n", "grr", require("telescope.builtin").lsp_references, { desc = "[G]oto [R]eferences", buffer = ev.buf })
    vim.keymap.set("n", "gri", require("telescope.builtin").lsp_implementations, { desc = "[G]oto [I]mplementation", buffer = ev.buf })
    vim.keymap.set("n", "grd", require("telescope.builtin").lsp_definitions, { desc = "[G]oto [D]efinition", buffer = ev.buf })
    vim.keymap.set("n", "grD", vim.lsp.buf.declaration, { desc = "[G]oto [D]eclaration", buffer = ev.buf })
    vim.keymap.set("n", "grO", require("telescope.builtin").lsp_document_symbols, { desc = "Open Document Symbols", buffer = ev.buf })
    vim.keymap.set("n", "grW", require("telescope.builtin").lsp_dynamic_workspace_symbols, { desc = "Open Workspace Symbols", buffer = ev.buf })
    vim.keymap.set("n", "grt", require("telescope.builtin").lsp_type_definitions, { desc = "[G]oto [T]ype Definition", buffer = ev.buf })
  end,
})

-- Setup mason
require("mason").setup()


