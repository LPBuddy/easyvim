return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "modern",
			icons = { rules = false },
			win = { border = "rounded" },
		},
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)

			wk.add({
				{ "<leader>f", group = "find" },
				{ "<leader>o", desc = "Open Config" },
			})
		end,
	},
}
