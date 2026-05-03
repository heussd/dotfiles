-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({
        "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo,
        lazypath
    })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            {"Failed to clone lazy.nvim:\n", "ErrorMsg"}, {out, "WarningMsg"},
            {"\nPress any key to exit..."}
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        -- import your plugins
        {import = "plugins"}
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = {colorscheme = {"catppuccin-nvim"}},
    -- automatically check for plugin updates
    checker = {enabled = true}
})

require('render-markdown').setup({file_types = {'markdown', 'vimwiki'}})

vim.treesitter.language.register('markdown', 'vimwiki')

vim.cmd.colorscheme "catppuccin-nvim"

local function next_closed_fold(dir)
    local cmd = "norm!z" .. dir
    local view = vim.fn.winsaveview()
    local l0, l, open = 0, view.lnum, true

    while l ~= l0 and open do
        vim.cmd(cmd)
        l0, l = l, vim.fn.line('.')
        open = vim.fn.foldclosed(l) < 0
    end

    if open then vim.fn.winrestview(view) end
end

vim.keymap.set('n', '<space>', 'za', {noremap = true})
vim.keymap.set('v', '<space>', 'za', {noremap = true})
vim.keymap.set('n', '<leader>0', 'zczA', {noremap = true})
vim.keymap.set('v', '<leader>0', 'zczA', {noremap = true})
vim.keymap.set('n', '<S-j>', function() next_closed_fold('j') end,
               {silent = true})
vim.keymap.set('n', '<S-k>', function() next_closed_fold('k') end,
               {silent = true})

