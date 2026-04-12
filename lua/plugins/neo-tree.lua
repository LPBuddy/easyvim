return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	lazy = false,
	opts = {},

	config = function()
		require("neo-tree").setup({
			event_handlers = {
				{
					event = "neo_tree_window_after_open",
					handler = function(args)
						vim.cmd("wincmd H")
						vim.api.nvim_win_set_width(0, 40)
						vim.cmd("setlocal winfixwidth")
					end,
				},
				{
					event = "neo_tree_window_after_close",
					handler = function(args)
						vim.cmd("setlocal nowinfixwidth")
					end,
				},
				{
					event = "file_open_requested",
					handler = function()
						require("neo-tree.command").execute({ action = "close" })
					end,
				},
			},
			filesystem = {
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
					hide_by_name = {},
					never_show = {},
				},
				follow_current_file = {
					enabled = true,
				},
				use_libuv_file_watcher = true,
			},
			buffers = {
				follow_current_file = {
					enabled = true,
				},
			},
		})

		vim.keymap.set("n", "<leader>ls", ":Neotree filesystem reveal left<CR>")
	end,
}
