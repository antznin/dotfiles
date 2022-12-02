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
