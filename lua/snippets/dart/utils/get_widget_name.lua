local get_file_name = require("snippets.dart.utils.get_file_name")
local to_pascal_case = require("snippets.dart.utils.to_pascal_case")

--- @return string
local function get_widget_name()
	return to_pascal_case(get_file_name())
end

return get_widget_name
