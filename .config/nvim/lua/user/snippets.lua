local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("text", {
  -- TXL changelog entry.
  s(
    "txl_chlg",
    fmt("- [{}]  {}\n\n  {}", {
      i(1, "commits"),
      i(2, "title"),
      i(3, "body"),
    })
  ),
})

ls.add_snippets("yaml", {
  -- Soup patch entry.
  s(
    "patch",
    fmt([[    - names:
{}
      modified_files:
{}
      description: {}]], {
      i(1, "names"),
      i(2, "modified_files"),
      i(3, "description"),
    })
  ),
})

ls.add_snippets("yaml", {
  -- TXL review entry.
  s(
    "rev",
    fmt("      reason: {}\n      category: *category-config", {
      i(1, "reason"),
    })
  ),
})
