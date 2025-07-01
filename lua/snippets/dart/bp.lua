local ls = require("luasnip")
local utils = require("snippets.dart.utils")

local s = ls.snippet
local t = ls.text_node
local fn = ls.function_node

ls.add_snippets("dart", {
	s("bp", {
		t({ "BlocProvider(", "\tcreate: (_) => " }),
		fn(utils.get_bloc_provider_name),
		t({ "Bloc(),", "\tchild: " }),
		fn(utils.get_bloc_provider_name),
		t({ "View(),", ");" }),
	}),
})
