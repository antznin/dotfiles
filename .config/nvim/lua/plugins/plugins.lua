return {
  -- {
  --   "mg979/vim-visual-multi", -- Multiple cursors support
  --   lazy = false,
  -- },
  {
    "tpope/vim-commentary", -- Comment with gcc
    lazy = true,
  },
  {
    "gabrielpoca/replacer.nvim", -- Replace through a quickfix list
    lazy = true,
  },
  {
    "tpope/vim-fugitive", -- Git interactions
    cmd = "Git",
  },
  {
    "folke/snacks.nvim",
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      indent = { enabled = true },
      -- input = { enabled = true },
      toggle = { enabled = true },
      words = { enabled = true },
    },
  },
}
