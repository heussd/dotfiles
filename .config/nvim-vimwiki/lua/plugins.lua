return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "auto", -- latte, frappe, macchiato, mocha
                background = { -- :h background
                    light = "latte",
                    dark = "mocha"
                },
                transparent_background = true,
                RenderMarkdownH1 = {fg = "#000000"},
                RenderMarkdownH2 = {fg = "#89ddff"},
                RenderMarkdownH3 = {fg = "#94E2D5"},
                RenderMarkdownH4 = {fg = "#B4BEFE"},
                RenderMarkdownH1Bg = {bg = "#d9ff00"},
                RenderMarkdownH2Bg = {bg = "#528599"},
                RenderMarkdownH3Bg = {bg = "#675161"},
                RenderMarkdownH4Bg = {bg = "#526c96"},
                RenderMarkdownH5Bg = {bg = "#6c7298"},
                RenderMarkdownH6Bg = {bg = "#36394d"}
            })
        end
    }, {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = {
            'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim'
        }, -- if you use the mini.nvim suite
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {},
        setup = {file_types = {'markdown', 'vimwiki'}}
    }, {
        'vimwiki/vimwiki',
        init = function()
            vim.g.vimwiki_path = '~/vimwiki/'
            vim.g.vimwiki_syntax = 'markdown'
            vim.g.vimwiki_ext = 'md'
        end
    }, {
        'jakewvincent/mkdnflow.nvim',
        ft = {'markdown', 'rmd', 'vimwiki'}, -- Add custom filetypes here if configured
        config = function()
            require('mkdnflow').setup({
                -- Your config
            })
        end
    }
}
