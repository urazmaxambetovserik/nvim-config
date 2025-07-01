local ls = require("luasnip")
local utils = require("snippets.dart.utils")

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fn = ls.function_node

-- Stateless part view
ls.add_snippets("dart", {
	s("slpv", {
		t({
			"part of 'view.dart';",
			"",
			"",
		}),
		t("class "),
		fn(utils.get_widget_name),
		t({ " extends StatelessWidget {", "  const " }),
		fn(utils.get_widget_name),
		t({
			"({super.key});",
			"",
			"  @override",
			"  Widget build(BuildContext context) {",
			"    return ",
		}),
		i(1, "Container()"),
		t({ ";", "  }", "}" }),
	}),
})
