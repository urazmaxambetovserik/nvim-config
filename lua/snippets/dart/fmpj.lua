local ls = require("luasnip")
local utils = require("snippets.dart.utils")

local s = ls.snippet
local t = ls.text_node
local fn = ls.function_node
local i = ls.insert_node

ls.add_snippets("dart", {
	s("fmpj", {
		t({ "part of 'models.dart';", "", "@freezed", "abstract class " }),
		fn(utils.get_widget_name),
		t(" with _$"),
		fn(utils.get_widget_name),
		t(" {"),
		t({ "", "\tconst factory " }),
		fn(utils.get_widget_name),
		t("({"),
		i(1, "required int id"),
		t("}) = _"),
		fn(utils.get_widget_name),
		t({ ";", "", "\tfactory " }),
		fn(utils.get_widget_name),
		t(".fromJson(Map<String, dynamic> json) => _$"),
		fn(utils.get_widget_name),
		t({ "FromJson(json);", "}" }),
	}),
})
