return {
  "cappyzawa/trim.nvim",
  version = "*",
  config = function()
    require("trim").setup({
      ft_blocklist = {},
      patterns = {
        [[%s/\s\+$//e]], -- remove unwanted spaces
        [[%s/\($\n\s*\)\+\%$//]], -- trim last line
        [[%s/\%^\n\+//]], -- trim first line
      },
      trim_on_write = false,
    })
  end,
}
