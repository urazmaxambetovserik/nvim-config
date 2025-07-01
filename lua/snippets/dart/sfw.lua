local ls = require("luasnip")
local utils = require("snippets.dart.utils")

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fn = ls.function_node

ls.add_snippets("dart", {
	s("sfw", {
		t({
			"import 'package:flutter/material.dart';",
			"",
			"",
		}),
		t("class "),
		fn(utils.get_widget_name),
		t({ " extends StatefulWidget {", "  const " }),
		fn(utils.get_widget_name),
		t({
			"({super.key});",
			"",
			"  @override",
			"  State<",
		}),
		fn(utils.get_widget_name),
		t({
			"> createState() => _",
		}),
		fn(utils.get_widget_name),
		t({
			"State();",
			"}",
			"",
			"class _",
		}),
		fn(utils.get_widget_name),
		t({
			"State extends State<",
		}),
		fn(utils.get_widget_name),
		t({
			"> {",
			"  @override",
			"  Widget build(BuildContext context) {",
			"    return ",
		}),
		i(1, "Container()"),
		t({ ";", "  }", "}" }),
	}),
})
