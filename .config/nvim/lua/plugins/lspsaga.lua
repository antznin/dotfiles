return {
  'nvimdev/lspsaga.nvim',
  config = function()
    require('lspsaga').setup({
      lightbulb = {
        virtual_text = false,
      },
    })
  end,
  lazy = false,
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  }
}
