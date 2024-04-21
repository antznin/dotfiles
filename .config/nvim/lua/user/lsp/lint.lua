local status_ok, nvim_lint = pcall(require, "lint")
if not status_ok then
  return
end

nvim_lint.linters_by_ft = {
  python = {'flake8',},
  bitbake = {'oelint-adv',},
  zsh = {'zsh'},
  sh = {'shellcheck'},
  markdown = {'proselint'},
  systemd = {'systemdlint'},
  -- c = {'checkpatch'},
}

nvim_lint.linters.checkpatch.cmd = '/data/misc/bootlin/driver-dev/linux/scripts/checkpatch.pl'

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    nvim_lint.try_lint()
  end,
})
