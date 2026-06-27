local ls = require("luasnip")
local utils = require("snippets.dart.utils")

local s = ls.snippet
local t = ls.text_node
local fn = ls.function_node
local i = ls.insert_node

ls.add_snippets("dart", {
	s("csp", {
		t({ "part of '../api.dart';", "", "@ChopperApi(baseUrl: '/" }),
		fn(utils.get_file_name),
		t({ "')", "abstract class " }),
		fn(utils.get_widget_name),
		t({ " extends ChopperService {", "\tstatic " }),
		fn(utils.get_widget_name),
		t(" create([ChopperClient? client]) => _$"),
		fn(utils.get_widget_name),
		t({ "(client);", "", "\t" }),
		i(1),
		t({ "", "}" }),
	}),
})
