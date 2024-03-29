local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used in lots of plugins
  use "wikitopian/hardmode" -- Stop using arrows
  use "mg979/vim-visual-multi" -- Multiple cursors support
  use "tpope/vim-commentary" -- Comment with gcc
  use "tpope/vim-sleuth" -- Automatically adjusts 'shiftwidth' and 'expandtab'
  use "tpope/vim-surround" -- Delete, change and add surroundings in pairs
  use "lewis6991/gitsigns.nvim"
  use "kyazdani42/nvim-web-devicons"
  use "kyazdani42/nvim-tree.lua" -- Tree file navigation
  use "nvim-lualine/lualine.nvim" -- Sleek line
  use "akinsho/toggleterm.nvim" -- Show a terminal
  -- use "windwp/nvim-autopairs" -- Autopairs of bracket, etc.
  use "cappyzawa/trim.nvim" -- Trim whitespace, etc.
  use "tpope/vim-repeat" -- Repeat plugin maps
  use "rcarriga/nvim-notify" -- Better notifications
  use "gabrielpoca/replacer.nvim" -- Replace through a quickfix list
  use "echasnovski/mini.align" -- Better alignments
  use "caenrique/nvim-maximize-window-toggle" -- Toggle fullscreen
  use "opdavies/toggle-checkbox.nvim" -- Check / uncheck markdown boxes.
  use "tpope/vim-fugitive" -- Git interactions.
  use({ "vladdoster/remember.nvim", config = "require('remember')" })
  use "folke/zen-mode.nvim" -- Chill while coding.

  use({
      "iamcco/markdown-preview.nvim",
      run = function() vim.fn["mkdp#util#install"]() end,
  })

  use {
    'TimUntersberger/neogit',
    requires = 'nvim-lua/plenary.nvim'
  }

  -- Colorschemes
  use "projekt0n/github-nvim-theme"


  -- cmp plugins
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"
  use "antznin/cmp-bitbake-path" -- Path completion for bitbake
  use "f3fora/cmp-spell" -- Spell checking cmp intergration

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"

  -- Lint
  use 'mfussenegger/nvim-lint'

  -- Telescope
  use "nvim-telescope/telescope.nvim"
  use 'nvim-telescope/telescope-media-files.nvim'
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make',
  }

  -- Bufferline
  use "akinsho/bufferline.nvim" -- Tabs line
  use "moll/vim-bbye" -- Needed by bufferline

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
  use "p00f/nvim-ts-rainbow" -- colored brackets/parenthesis/…
  use "nvim-treesitter/nvim-treesitter-context" -- line of context at the top of the buffer
  use "nvim-treesitter/nvim-treesitter-textobjects" -- manipulate text-objects
  use "nvim-treesitter/playground" -- manipulate text-objects

  -- DAP
  use "mfussenegger/nvim-dap" -- Debug Adapter Protocol
  use "rcarriga/nvim-dap-ui" -- UI for DAP, requires mfussenegger/nvim-dap.
  use "mfussenegger/nvim-dap-python" -- DAP for Python
  -- use "nvim-telescope/telescope-dap.nvim" -- Uses telescope to replace DAP commands TODO
  -- use "theHamsta/nvim-dap-virtual-text" TODO

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
