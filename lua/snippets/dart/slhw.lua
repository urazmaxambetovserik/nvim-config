local ls = require("luasnip")
local utils = require("snippets.dart.utils")

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fn = ls.function_node

ls.add_snippets("dart", {
	s("slhw", {
		t({
			"import 'package:flutter_hooks/flutter_hooks.dart';",
			"import 'package:flutter/material.dart';",
			"",
			"",
		}),
		t("class "),
		fn(utils.get_widget_name),
		t({ " extends HookWidget {", "  const " }),
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
