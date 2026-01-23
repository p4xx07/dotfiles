require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },

		javascript = { "prettier" },
		typescript = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },

		json = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },

		go = { "gofmt" },
		rust = { "rustfmt" },
		python = { "ruff_format", "black" },
		sh = { "shfmt" },
		bash = { "shfmt" },

		html = { "prettier" },
		css = { "prettier" },

		dockerfile = { "dockfmt" },
		yaml = { "prettier" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
})
