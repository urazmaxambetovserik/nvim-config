local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
	},
	{ "windwp/nvim-autopairs" },
	{ "neovim/nvim-lspconfig" },
	{ "williamboman/mason.nvim" },
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp", -- LSP completion source for nvim-cmp
			"hrsh7th/cmp-buffer", -- Buffer completion source for nvim-cmp
			"hrsh7th/cmp-path", -- Path completion source for nvim-cmp
			"saadparwaiz1/cmp_luasnip", -- Snippet completion source for nvim-cmp
			"L3MON4D3/LuaSnip", -- Snippet engine
		},
	},
	{ "nvimtools/none-ls.nvim", dependencies = { "nvimtools/none-ls-extras.nvim" } },
	{ "nvim-treesitter/nvim-treesitter" },
	{ "akinsho/toggleterm.nvim" },
	{ "nvim-lualine/lualine.nvim" },
	{
		"nvim-flutter/flutter-tools.nvim",
		dependencies = { "stevearc/dressing.nvim", "nvim-lua/plenary.nvim" },
		config = true,
	},
	{
		"urazmaxambetovserik/flutter-hot.nvim",
		config = function()
			require("flutter_hot").setup()
		end,
	},
	{ "ray-x/lsp_signature.nvim" },
	{ "hrsh7th/vim-vsnip" },
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
	},
	{ "wa11breaker/flutter-bloc.nvim" },
	{
		"linux-cultist/venv-selector.nvim",
		branch = "regexp",
		dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
	},
	{ "catppuccin/nvim" },
	{ "b0o/schemastore.nvim" },
	{ "windwp/nvim-ts-autotag" },
	{ "kylechui/nvim-surround" },
	{ "projectfluent/fluent.vim" },
})
