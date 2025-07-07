local lsp = require("lspconfig")

lsp.lua_ls.setup({
	settings = {
		Lua = {
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

--- @param name string
local function find_client_by_name(name)
	for _, client in ipairs(vim.lsp.get_clients()) do
		if client.name == name then
			return client
		end
	end
end

--- @param client vim.lsp.Client?
--- @param callback function
local function reload_if_inactive(client, callback)
	if client and not client.is_stopped() then
		return
	end

	if client and client.stop then
		client.stop()
	end

	callback()
end

-- Prisma
lsp.prismals.setup({})
local function reload_prismals_if_inactive()
	local prismals_client = find_client_by_name("prismals")

	vim.defer_fn(function()
		reload_if_inactive(prismals_client, function()
			lsp.prismals.setup({})
		end)
	end, 2000)
end

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*.prisma",
	callback = reload_prismals_if_inactive,
})

-- Dart
local function reload_dartls_if_inactive()
	local dartls_client = find_client_by_name("dartls")

	vim.defer_fn(function()
		reload_if_inactive(dartls_client, function()
			require("flutter-tools.lsp").attach()
		end)
	end, 2000)
end

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*.dart",
	callback = reload_dartls_if_inactive,
})

-- Pyright
lsp.pyright.setup({
	python = {
		analysis = {
			autoSearchPaths = true,
			diagnosticMode = "openFilesOnly",
			useLibraryCodeForTypes = true,
		},
	},
})

-- Jsonls
lsp.jsonls.setup({
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
			validate = { enable = true },
		},
	},
})

-- Typescript
lsp.vtsls.setup({})

-- Bash
lsp.bashls.setup({})

-- Yaml
lsp.yamlls.setup({
	settings = {
		yaml = {
			schemaStore = {
				enable = false,
				url = "",
			},
			schemas = require("schemastore").yaml.schemas(),
		},
	},
})

-- Docker
lsp.dockerls.setup({})

-- Emmet
lsp.emmet_language_server.setup({})

-- Css
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
lsp.cssls.setup({
	capabilities = capabilities,
})

lsp.tailwindcss.setup({})

lsp.clangd.setup({})

lsp.svelte.setup({})

lsp.gradle_ls.setup({})
