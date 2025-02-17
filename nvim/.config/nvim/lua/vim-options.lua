-- Set background and leader key
vim.g.background = "light"
vim.g.mapleader = " "
vim.opt.updatetime = 50

-- Set indentation to 2 spaces
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

-- Navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

-- Clear search highlights
vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')

-- Auto indent file
vim.keymap.set('n', '<leader>ai', 'mzgg=G`z')

-- Toggle line numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- Undo file
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. '/.vim/undodir'

-- Always show 8 lines
vim.opt.scrolloff = 8

-- Highlight search
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Some ThePrimeagen keymaps
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
