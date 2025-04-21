return {
  {
    "mg979/vim-visual-multi", -- Multiple cursors support
    lazy = false,
    version = "*",
  },
  {
    "tpope/vim-commentary", -- Comment with gcc
    lazy = true,
    version = "*",
  },
  {
    "tpope/vim-sleuth", -- Automatically adjusts 'shiftwidth' and 'expandtab'
    lazy = true,
    version = "*",
  },
  {
    "gabrielpoca/replacer.nvim", -- Replace through a quickfix list
    lazy = true,
    version = "*",
  },
  {
    "caenrique/nvim-maximize-window-toggle", -- Toggle fullscreen
    lazy = true,
    version = "*",
  },
  {
    "tpope/vim-fugitive", -- Git interactions
    lazy = false,
    version = "*",
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
}
