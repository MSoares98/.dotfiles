-- Set background and leader key
vim.g.background = "light"
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.opt.updatetime = 50

-- Set indentation to 2 spaces
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

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

-- Navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>', { desc = "Move to upper window" })
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>', { desc = "Move to lower window" })
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>', { desc = "Move to left window" })
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>', { desc = "Move to right window" })

-- Clear search highlights
vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>', { desc = "Clear search highlights" })

-- Auto indent file
vim.keymap.set('n', '<leader>ai', 'mzgg=G`z', { desc = "Auto-indent whole file" })

-- Some ThePrimeagen keymaps
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join line with next (keep cursor)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down (keep cursor centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up (keep cursor centered)" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (keep centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (keep centered)" })
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]], { desc = "Copy to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Copy line to system clipboard" })
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]], { desc = "Delete without yanking" })
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Search and replace word under cursor" })

-- Buffer Management
vim.keymap.set('n', '<leader>bn', ':bnext<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<leader>bp', ':bprevious<CR>', { desc = 'Previous buffer' })
vim.keymap.set('n', '<leader>bd', ':bdelete<CR>', { desc = 'Delete buffer' })

-- Open NVIM Cheatsheet
vim.api.nvim_create_user_command('Keymaps', function()
    local buf = vim.api.nvim_create_buf(false, true)
    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.8)
    local win = vim.api.nvim_open_win(buf, true, {
        relative = 'editor',
        width = width,
        height = height,
        col = math.floor((vim.o.columns - width) / 2),
        row = math.floor((vim.o.lines - height) / 2),
        style = 'minimal',
        border = 'rounded',
    })

    -- Load content from your cheatsheet file
    local lines = vim.fn.readfile(vim.fn.expand('/home/msoares/comprehensive-nvim-keymaps.md'))
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.api.nvim_buf_set_option(buf, 'filetype', 'markdown')
    vim.api.nvim_buf_set_option(buf, 'modifiable', false)

    -- Close with q
    vim.api.nvim_buf_set_keymap(buf, 'n', 'q', ':close<CR>', {noremap = true, silent = true})
end, {})

-- Toggle Wrap
local wrapenabled = 0
vim.keymap.set('n', '<leader>w', function()
  vim.cmd('set wrap nolist')
  if wrapenabled == 1 then
    vim.cmd('set nolinebreak')
    vim.keymap.del('n', 'j')
    vim.keymap.del('n', 'k')
    vim.keymap.del('n', '0')
    vim.keymap.del('n', '^')
    vim.keymap.del('n', '$')
    wrapenabled = 0
  else
    vim.cmd('set linebreak')
    vim.keymap.set('n', 'j', 'gj')
    vim.keymap.set('n', 'k', 'gk')
    vim.keymap.set('n', '0', 'g0')
    vim.keymap.set('n', '^', 'g^')
    vim.keymap.set('n', '$', 'g$')
    wrapenabled = 1
  end
end, { desc = "Toggle Wrap" })
