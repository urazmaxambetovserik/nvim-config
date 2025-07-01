require("flutter-tools").setup({
	widget_guides = {
		enabled = true,
	},
	closing_tags = {
		highlight = "lineNr",
		prefix = "// ",
	},
	lsp = {
		---@param client vim.lsp.Client
		on_attach = function(client, _)
			local textDocument = client.capabilities.textDocument

			textDocument.formatting.dynamicRegistration = false
			textDocument.rangeFormatting.dynamicRegistration = false
		end,
		color = {
			enabled = true,
			background = true,
		},
	},
})
