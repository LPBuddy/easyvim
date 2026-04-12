return {
	{
		"mason-org/mason.nvim",
		opts = {},
	},

	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "mason-org/mason.nvim" },
		opts = {
			ensure_installed = {
				"stylua",
				"shfmt",
				"clang-format",
			},
		},
	},
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		opts = {
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},

			formatters_by_ft = {
				lua = { "stylua" },
				sh = { "shfmt" },
				bash = { "shfmt" },
				c = { "clang-format" },
				cpp = { "clang-format" },
			},
		},

		keys = {
			{
				"<leader><leader>f",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = { "n", "v" },
				desc = "Format buffer",
			},
		},
	},
}
