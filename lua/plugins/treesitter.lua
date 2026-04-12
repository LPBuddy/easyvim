return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		build = ":TSUpdate",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			ensure_installed = {
                "vim",
                "vimdoc",
                "lua",
				"c",
				"cpp",
				"bash",
			},
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}
