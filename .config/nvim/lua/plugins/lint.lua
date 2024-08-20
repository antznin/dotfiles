return {
  'mfussenegger/nvim-lint', -- Linter support
  version = '*',
  config = function()
    local nvim_lint = require("lint")

    nvim_lint.linters_by_ft = {
      python = {'flake8',},
      bitbake = {'oelint-adv',},
      zsh = {'zsh'},
      sh = {'shellcheck'},
      markdown = {'proselint'},
      systemd = {'systemdlint'},
      -- c = {'checkpatch'},
    }

    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        nvim_lint.try_lint()
      end,
    })
  end,
}
