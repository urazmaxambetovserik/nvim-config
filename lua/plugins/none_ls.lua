local null_ls = require("null-ls")

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
	sources = {
		-- Formatting
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.prettierd.with({
			filetypes = {
				"prisma",
				"json",
				"jsonc",
				"typescript",
				"css",
				"scss",
				"javascript",
				"yaml",
				"typescriptreact",
				"javascriptreact",
			},
		}),
		null_ls.builtins.formatting.isort,
		null_ls.builtins.formatting.dart_format.with({
			generator_opts = {
				command = "/opt/old-dart-sdk/bin/dart",
				args = { "format" },
				to_stdin = true,
			},
		}),
		null_ls.builtins.formatting.clang_format,
		require("none-ls.formatting.ruff_format"),
		require("none-ls.formatting.ruff"),
		require("none-ls.formatting.beautysh"),

		-- Diagnostics
		require("none-ls.diagnostics.ruff"),
		require("none-ls.diagnostics.cpplint"),
		require("none-ls.diagnostics.eslint_d"),
	},

	--- @param client vim.lsp.Client
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					local filename = vim.api.nvim_buf_get_name(bufnr)

					if filename:match("%.([tj]sx?)$") then
						-- vim.lsp.buf.code_action({
						-- 	context = { only = { "source.organizeImports" } },
						-- 	apply = true,
						-- })
						local params = {
							command = "typescript.organizeImports",
							arguments = { vim.api.nvim_buf_get_name(bufnr) },
							title = "",
						}
						vim.lsp.buf_request_sync(bufnr, "workspace/executeCommand", params, 500)
					end

					vim.lsp.buf.format({
						bufnr = bufnr,
						async = false,
					})

					if filename:match("%.dart$") then
						vim.lsp.buf.code_action({
							context = { only = { "source.organizeImports" } },
							apply = true,
						})
					end
				end,
			})
		end
	end,
})
