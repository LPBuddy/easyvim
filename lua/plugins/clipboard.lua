return {
	"ojroques/vim-oscyank",
	config = function()
		vim.g.oscyank_max_length = 0
		vim.api.nvim_set_keymap(
			"v",
			"<leader>y",
			":OSCYankVisual<CR>",
			{ noremap = true, silent = true, desc = "Yank via OSC52" }
		)
	end,
}
