require("lualine").setup({
	options = {
		theme = "nightfly",
		disabled_filetypes = {
			statusline = { "neo-tree" },
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "diagnostics" },
		lualine_c = {},
		lualine_x = { "fileformat", "filetype" },
		lualine_y = { "filesize" },
		lualine_z = { { "datetime", icon = "", style = "%H:%M:%S" } },
	},
	inactive_sections = {
		lualine_c = {},
		lualine_x = {},
	},
})
