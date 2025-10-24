vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", {silent = true})
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", {silent = true})

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "=ap", "ma=ap'a")
vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>")

-- Tab remaps
local opts = { noremap = true, silent = true }
vim.keymap.set("i",    "<S-Tab>",       "<C-D>",  opts)
vim.keymap.set("n",    "<Tab>",         ">>",  opts)
vim.keymap.set("n",    "<S-Tab>",       "<<",  opts)
vim.keymap.set("v",    "<Tab>",         ">gv", opts)
vim.keymap.set("v",    "<S-Tab>",       "<gv", opts)

-- Comments remaps
vim.keymap.set("n",    "<C-_>",         ":norm gcc<CR>")
vim.keymap.set("v", "<C-_>", function()
    vim.cmd.norm("gc")
end)

-- Remap Ctrl+o and Ctrl+i, bc Ctrl+i = Tab
vim.api.nvim_set_keymap('n', '<C-o>', '<C-o>zz', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-p>', '<C-i>zz', { noremap = true, silent = true })
-- -- Turn off highlight when done searching
-- vim.keymap.set("n", "n", function()
--     vim.cmd.norm("set ")
-- end)

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({"n", "v"}, "<leader>d", "\"_d")

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set(
    "n",
    "<leader>ee",
    "oif err != nil {<CR>}<Esc>Oreturn err<Esc>"
)

vim.keymap.set(
    "n",
    "<leader>ea",
    "oassert.NoError(err, \"\")<Esc>F\";a"
)

vim.keymap.set(
    "n",
    "<leader>ef",
    "oif err != nil {<CR>}<Esc>Olog.Fatalf(\"error: %s\\n\", err.Error())<Esc>jj"
)

vim.keymap.set(
    "n",
    "<leader>el",
    "oif err != nil {<CR>}<Esc>O.logger.Error(\"error\", \"error\", err)<Esc>F.;i"
)

vim.keymap.set("n", "<leader>ca", function()
    require("cellular-automaton").start_animation("make_it_rain")
end)

-- Toggles
vim.keymap.set("n", "<leader>tn", ":set rnu!<CR>", opts)
vim.keymap.set("n", "<leader>th", ":Hardtime toggle<CR>", opts)

