vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.scrolloff = 999

vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true
vim.opt.wrap = false

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true

vim.opt.updatetime = 300
vim.opt.undofile = true

vim.o.winborder = "rounded"
vim.o.winblend = 20
vim.o.pumblend = 20

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "<leader>w", "<cmd>w<cr>", opts)
map("n", "<leader>q", "<cmd>q<cr>", opts)

map("n", "u", "u", opts)
map("n", "U", "<C-r>", opts)

map("n", "<A-Up>", "<cmd>m .-2<cr>==", opts)
map("n", "<A-Down>", "<cmd>m .+1<cr>==", opts)
map("v", "<A-Up>", ":m '<-2<cr>gv=gv", opts)
map("v", "<A-Down>", ":m '>+1<cr>gv=gv", opts)

map("n", "<leader>o", function()
	local cfgDir = vim.fn.stdpath("config") .. "/"
	vim.cmd.edit(vim.fn.fnameescape(cfgDir))
end, opts)

map("n", "<leader>tl", ":colorscheme dayfox<CR>")
map("n", "<leader>tn", ":colorscheme rose-pine-moon<CR>")

vim.keymap.set("n", "<C-Left>", "<C-w>h", { noremap = true })
vim.keymap.set("n", "<C-Down>", "<C-w>j", { noremap = true })
vim.keymap.set("n", "<C-Up>", "<C-w>k", { noremap = true })
vim.keymap.set("n", "<C-Right>", "<C-w>l", { noremap = true })

