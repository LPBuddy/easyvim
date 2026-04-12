return {
	{
		"crag666/code_runner.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		cmd = { "RunCode", "RunFile", "RunProject" },
		keys = {
			{ "<leader>r", ":RunCode<CR>", desc = "Run code" },
		},
		opts = {
			filetype = {
				lua = "lua",
				sh = function(...)
					local file = vim.api.nvim_buf_get_name(0)
					local f = io.open(file, "r")
					if not f then
						return "bash $fileName"
					end
					local first = f:read("*l")
					f:close()

					if first and first:match("^#!") then
						return "chmod +x $fileName && $fileName"
					else
						return "bash $fileName"
					end
				end,

				c = "cd $dir && gcc $fileName -o $fileNameWithoutExt && $dir/$fileNameWithoutExt",
				cpp = "cd $dir && g++ $fileName -o $fileNameWithoutExt && $dir/$fileNameWithoutExt",
			},
		},
	},
}
