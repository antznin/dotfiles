local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("text", {
  -- TXL changelog entry.
  s(
    "txl_chlg",
    fmt("- [] \n\n  ", {})
  ),
})

ls.add_snippets("yaml", {
  -- Soup patch entry.
  s(
    "patch",
    fmt([[- names:
  -
  modified_files:
  -
  description: ]], {})
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

-- ls.add_snippets("yaml", {
--   -- SOUP patch
--   s(
--     "patch",
--     fmt([[- names:
--     - {}
--     modified_files:
--     - description: {}
--     ]], {
--       i(1, "reason"),
--     })
--   ),
-- })
