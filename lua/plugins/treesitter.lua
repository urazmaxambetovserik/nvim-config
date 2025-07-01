require("nvim-treesitter.configs").setup({
	ensure_installed = { "lua", "typescript", "tsx" },

	sync_install = false,
	auto_install = true,
	ignore_install = {},
	highlight = {
		enable = true,
	},
	modules = {},
	indent = { enable = true },
})

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

parser_config.fluent = {
	install_info = {
		url = "https://github.com/tree-sitter/tree-sitter-fluent",
		files = { "src/parser.c" },
		branch = "master",
	},
	filetype = "fluent",
}
