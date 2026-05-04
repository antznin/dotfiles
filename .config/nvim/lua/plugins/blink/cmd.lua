--- @module 'blink.cmp'
--- @class blink.cmp.Source
local source = {}

function source.new(opts)
  local self = setmetatable({}, { __index = source })
  self.opts = opts
  return self
end

function source:enabled()
  local ft = "text"
  if self.opts.ft ~= nil then
    ft = self.opts.ft
  end
  return vim.bo.filetype == ft
end

function source:get_trigger_characters()
  local trigger_characters = {}
  if self.opts.trigger_characters ~= nil then
    trigger_characters = self.opts.trigger_characters
  end
  return trigger_characters
end

function source:get_completions(ctx, callback)
  --- @type lsp.CompletionItem[]
  local items = {}

  if type(self.opts.cmd) == "string" then
    self.opts.cmd = { self.opts.cmd }
  end

  for _, cmd in pairs(self.opts.cmd) do
    local handle = io.popen(cmd)
    local result = ""
    if handle ~= nil then
      result = handle:read("*a")
      handle:close()
      for line in string.gmatch(result, "[^\r\n]+") do
        local item = {
          label = line,
          kind = require("blink.cmp.types").CompletionItemKind.Text,
          filterText = line,
          insertText = line,
          insertTextFormat = vim.lsp.protocol.InsertTextFormat.PlainText,
        }
        table.insert(items, item)
      end
    end
  end

  callback({
    items = items,
    -- Whether blink.cmp should request items when deleting characters
    -- from the keyword (i.e. "foo|" -> "fo|")
    -- Note that any non-alphanumeric characters will always request
    -- new items (excluding `-` and `_`)
    is_incomplete_backward = false,
    -- Whether blink.cmp should request items when adding characters
    -- to the keyword (i.e. "fo|" -> "foo|")
    -- Note that any non-alphanumeric characters will always request
    -- new items (excluding `-` and `_`)
    is_incomplete_forward = false,
  })
end

function source:resolve(item, callback)
  -- item = vim.deepcopy(item)

  if type(self.opts.doc_cmd) == "string" then
    local doc_cmd = self.opts.doc_cmd:gsub("##item##", item.label)
    local result = ""
    local handle = io.popen(doc_cmd)
    if handle ~= nil then
      result = handle:read("*a")
      handle:close()

      item.documentation = {
        kind = "plaintext",
        value = result,
      }
    end
  end

  callback(item)
end

return source
