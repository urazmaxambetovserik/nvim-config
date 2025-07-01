local ls = require("luasnip")
local utils = require("snippets.dart.utils")

local s = ls.snippet
local t = ls.text_node
local fn = ls.function_node
local i = ls.insert_node

ls.add_snippets("dart", {
	s("bb", {
		t("BlocBuilder<"),
		fn(utils.get_bloc_provider_name),
		t("Bloc, "),
		fn(utils.get_bloc_provider_name),
		t({ "State>(", "\tbuilder: (context, state) {", "\t\treturn " }),
		i(1, "Container()"),
		t({ ";", "\t},", ");" }),
	}),
})
