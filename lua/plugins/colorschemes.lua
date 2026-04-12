return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = {},
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		priority = 1000,
		opts = {
			variant = "auto",
			dark_variant = "moon",
			styles = {
				bold = true,
				italic = true,
				transparency = false,
			},
		},
		config = function(_, opts)
			require("rose-pine").setup(opts)
			vim.cmd.colorscheme("rose-pine-moon")
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		compile = false,
		undercurl = true,
		commentStyle = { italic = true },
		functionStyle = {},
		keywordStyle = { italic = true },
		statementStyle = { bold = true },
		typeStyle = {},
		transparent = false,
		dimInactive = false,
		terminalColors = true,
		colors = {
			palette = {},
			theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
		},
		overrides = function(colors)
			return {}
		end,
		theme = "wave",
		background = {
			dark = "wave",
			light = "lotus",
		},
	},
	{
		"edeneast/nightfox.nvim",
		options = {
			compile_path = vim.fn.stdpath("cache") .. "/nightfox",
			compile_file_suffix = "_compiled",
			transparent = true,
			terminal_colors = true,
			dim_inactive = false,
			module_default = true,
			colorblind = {
				enable = false,
				simulate_only = false,
				severity = {
					protan = 0,
					deutan = 0,
					tritan = 0,
				},
			},
			styles = {
				comments = "NONE",
				conditionals = "NONE",
				constants = "NONE",
				functions = "NONE",
				keywords = "NONE",
				numbers = "NONE",
				operators = "NONE",
				strings = "NONE",
				types = "NONE",
				variables = "NONE",
			},
			inverse = {
				match_paren = false,
				visual = false,
				search = false,
			},
			modules = {
				-- ...
			},
		},
		palettes = {},
		specs = {},
		groups = {},
	},
}
