-- treesitter.lua
return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  branch = "main",
  config = function()
    local ts = require("nvim-treesitter")
    local parsers = {
      "bash",
      "bitbake",
      "c",
      "comment",
      "css",
      "diff",
      "dockerfile",
      "git_config",
      "gitcommit",
      "gitignore",
      "go",
      "html",
      "http",
      "javascript",
      "jsdoc",
      "json",
      "json5",
      "lua",
      "make",
      "markdown",
      "markdown_inline",
      "python",
      "regex",
      "rst",
      "rust",
      "scss",
      "sql",
      "ssh_config",
      "terraform",
      "toml",
      "tsx",
      "typescript",
      "typst",
      "vim",
      "vimdoc",
      "yaml",
    }

    for _, parser in ipairs(parsers) do
      ts.install(parser)
    end

    -- Not every tree-sitter parser is the same as the file type detected
    -- So the patterns need to be registered more cleverly
    local patterns = {}
    for _, parser in ipairs(parsers) do
      local parser_patterns = vim.treesitter.language.get_filetypes(parser)
      for _, pp in pairs(parser_patterns) do
        table.insert(patterns, pp)
      end
    end

    vim.api.nvim_create_autocmd("FileType", {
      pattern = patterns,
      callback = function()
        vim.treesitter.start()
        vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.wo[0][0].foldmethod = "expr"
      end,
    })
  end,
}
