return {
  "mfussenegger/nvim-lint", -- Linter support
  version = "*",
  config = function()
    local nvim_lint = require("lint")

    nvim_lint.linters_by_ft = {
      bitbake = { "oelint-adv" },
      zsh = { "zsh" },
      sh = { "shellcheck" },
      markdown = { "proselint" },
      systemd = { "systemdlint" },
      rst = { "sphinx-lint" },
      -- c = {'checkpatch'},
    }

    -- Specify path to checkpatch perl script here (from linux kernel source).
    -- nvim_lint.linters.checkpatch.cmd = '/path/to/linux/scripts/checkpatch.pl'

    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        nvim_lint.try_lint()
      end,
    })
  end,
}
