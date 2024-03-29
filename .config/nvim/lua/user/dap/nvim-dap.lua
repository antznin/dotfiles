local status_ok, dap
status_ok, dap = pcall(require, "dap")
if not status_ok then
  return
end

-- Python
-- Plug-and-play configuration
local nvim_dap_python
status_ok, nvim_dap_python = pcall(require, "dap-python")
if not status_ok then
  return
end

-- Default intepreter. Virtualenv interpreter will overtake this one.
nvim_dap_python.setup(os.getenv('HOME') .. '/.virtualenvs/debugpy/bin/python')

-- C
dap.adapters.cppdbg = {
    id = 'cppdbg',
    type = 'executable',
    command = os.getenv('HOME') .. '/.local/share/nvim/mason/bin/OpenDebugAD7',
    -- args = {},
    -- attach = {
    --     pidProperty = "processId",
    --     pidSelect = "ask"
    -- }
}

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopAtEntry = true,
  },
  {
    name = 'Yocto-gdb EZ3 192.168.1.3:5551',
    type = 'cppdbg',
    request = 'launch',
    MIMode = 'gdb',
    miDebuggerServerAddress = '192.168.1.3:5551',
    miDebuggerPath = '/opt/poky/txl/v1.7.0/sysroots/x86_64-pokysdk-linux/usr/bin/aarch64-poky-linux/aarch64-poky-linux-gdb',
    cwd = '${workspaceFolder}',
    program = function()
      return vim.fn.input('Path to executable: ', '/data/txl/md20xx/workspace/wyld/build/build/tmp/work', 'file')
    end,
  },
}
-- Same configs for C and CPP
dap.configurations.c = dap.configurations.cpp

local nvim_dap_vscode_ext
status_ok, nvim_dap_vscode_ext = pcall(require, "dap.ext.vscode")
if status_ok then
  local vscode_dir = vim.fs.find(
    ".vscode",
    { upward = true, type = "directory", limit = 1 })
  if next(vscode_dir) == nil then
    nvim_dap_vscode_ext.load_launchjs()
  else
    local launchjs = vscode_dir[1] .. "/launch.json"
    if vim.fn.filereadable(launchjs) then
      nvim_dap_vscode_ext.load_launchjs(launchjs,
        {
          cppdbg = {"c", "cpp"}, -- Map cppbdg types for c and cpp files.
        })
      -- vim.notify("Loaded " .. launchjs .. ".")
    end
  end
end
