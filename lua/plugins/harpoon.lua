return {
	"ThePrimeagen/harpoon",
	dependencies = { "nvim-lua/plenary.nvim" },

	config = function()
		require("harpoon").setup({
			global_settings = {
				save_on_toggle = true,
				save_on_change = true,
				tabline = false,
			},
		})

		local mark = require("harpoon.mark")
		local ui = require("harpoon.ui")

		local function harpoon_label(path)
			if not path or path == "" then
				return "[empty]"
			end

			local file = vim.fn.fnamemodify(path, ":t")
			local dir = vim.fn.fnamemodify(path, ":h:t")

			if dir == "." or dir == "" then
				return file
			end

			return dir .. "/" .. file
		end

		function _G.harpoon_tabline()
			local current = vim.fn.expand("%:p")
			local items = {}

			for i = 1, mark.get_length() do
				local path = mark.get_marked_file_name(i)

				if path and path ~= "" then
					local active = vim.fn.fnamemodify(path, ":p") == current
					local num_hl = active and "%#HarpoonNumberActive#" or "%#HarpoonNumberInactive#"
					local text_hl = active and "%#HarpoonActive#" or "%#HarpoonInactive#"

					items[#items + 1] = string.format("%s%d %s%s ", num_hl, i, text_hl, harpoon_label(path))
				end
			end

			if #items == 0 then
				return ""
			end

			return "%#TabLineFill# " .. table.concat(items, "%#TabLineFill#│ ")
		end

		vim.o.showtabline = 2
		vim.o.tabline = "%!v:lua.harpoon_tabline()"

		vim.cmd("highlight default link HarpoonInactive TabLine")
		vim.cmd("highlight default link HarpoonNumberInactive TabLine")
		vim.cmd("highlight default link HarpoonActive TabLineSel")
		vim.cmd("highlight default link HarpoonNumberActive TabLineSel")

		vim.keymap.set("n", "<leader>a", mark.add_file)
		vim.keymap.set("n", "<leader>e", ui.toggle_quick_menu)

		for i = 1, 6 do
			vim.keymap.set("n", "<leader>" .. i, function()
				ui.nav_file(i)
			end)
		end
	end,
}
