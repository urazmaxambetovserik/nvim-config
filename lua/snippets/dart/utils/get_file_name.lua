--- @return string
local function get_file_name()
	return vim.fn.expand("%:t:r")
end

return get_file_name
