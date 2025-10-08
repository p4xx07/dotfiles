local ls = require("luasnip")
local s  = ls.snippet
local i  = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("html", {
  s("html", fmt([[
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>{}</title>
  <link rel="stylesheet" href="{}">
</head>
<body>
  {}
</body>
</html>
]], { i(1, "Title"), i(2, "styles.css"), i(3, "<!-- content -->") }))
})
