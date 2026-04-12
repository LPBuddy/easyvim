return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
		},

		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			local builtin = require("telescope.builtin")

			telescope.setup({
				extensions = {
					["ui-select"] = require("telescope.themes").get_dropdown({}),
				},
			})

			pcall(telescope.load_extension, "ui-select")

			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope: Find files" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope: Live grep" })
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope: Help tags" })
		end,
	},
}
