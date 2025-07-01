--- @return string
local function to_pascal_case(text)
	return text:gsub("(%a)([%w]*)", function(first, rest)
		return first:upper() .. rest:lower()
	end):gsub("%W", "")
end

return to_pascal_case
