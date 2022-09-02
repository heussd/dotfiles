-- Taken from https://github.com/akrawiel/dotfiles/blob/main/.config/nvim/lua/plugins.lua

local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

local packer_bootstrap

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  print 'Downloading packer.nvim...'

  packer_bootstrap = vim.fn.system {
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  }

  print(packer_bootstrap)

  print 'Packer.nvim installed'
  print 'Restart neovim now'

  vim.cmd [[2sleep]]
  vim.cmd [[qa]]
end

return require 'packer'.startup(function(use)
  vim.cmd [[
    augroup packer_user_config
      autocmd!
      autocmd BufWritePost plugins.lua source <afile> | PackerCompile
    augroup end
  ]]

  use 'wbthomason/packer.nvim'

  use 'mfussenegger/nvim-lint'

    -- bootstrap sync check
    if packer_bootstrap then
        require 'packer'.sync()
    end
end)