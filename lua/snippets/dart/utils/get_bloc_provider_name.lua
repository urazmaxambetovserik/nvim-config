local get_file_name = require("snippets.dart.utils.get_file_name")
local to_pascal_case = require("snippets.dart.utils.to_pascal_case")

--- @return string
local function get_bloc_provider_name()
	local bloc_provider_name = string.gsub(get_file_name(), "_page", "")
	bloc_provider_name = string.gsub(bloc_provider_name, "_view", "")
	return to_pascal_case(bloc_provider_name)
end

return get_bloc_provider_name
