vim.cmd [[
  au BufRead,BufNewFile *.bb set filetype=bitbake
  au BufRead,BufNewFile *.bbclass set filetype=bitbake
  au BufRead,BufNewFile *.bbappend set filetype=bitbake
  au BufRead,BufNewFile *.inc set filetype=bitbake
  au BufRead,BufNewFile local.conf.sample set filetype=bitbake
  au BufRead,BufNewFile bblayers.conf.sample set filetype=bitbake
]]
