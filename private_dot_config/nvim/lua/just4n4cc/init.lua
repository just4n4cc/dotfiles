require("just4n4cc.lazy")
require("just4n4cc.set")
require("just4n4cc.remap")

local augroup = vim.api.nvim_create_augroup
local just4n4ccGroup = augroup('just4n4cc', {})
local autocmd = vim.api.nvim_create_autocmd

-- Remove whitespace on buffer write
autocmd({"BufWritePre"}, {
    group = just4n4ccGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

