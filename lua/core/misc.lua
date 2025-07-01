-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

-- Indent
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

-- Color scheme
vim.cmd("colorscheme catppuccin-mocha")

-- CursorLine colors
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	callback = function()
		vim.cmd("highlight CursorLineNr guifg=#fb8500")
		vim.cmd("highlight LineNr guifg=#577590")
	end,
})

-- Python indent
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*.py",
	callback = function()
		vim.opt_local.tabstop = 4
		vim.opt_local.shiftwidth = 4
	end,
})

-- Folds
function _G.custom_fold_text()
	local line = vim.fn.getline(vim.v.foldstart)
	local lines_count = vim.v.foldend - vim.v.foldstart + 1
	return "⯈ " .. line:gsub("^%s*", "") .. "  ⋯ " .. lines_count .. " lines"
end

vim.opt.foldmethod = "indent"
vim.opt.foldlevelstart = 99
vim.o.fillchars = "fold: "

vim.opt.foldtext = "v:lua.custom_fold_text()"

-- Fold save
local save_fold = {
	callback = function()
		if vim.bo.filetype ~= "" and vim.fn.expand("%") ~= "" and not vim.bo.buftype:match("nofile") then
			vim.cmd("mkview")
		end
	end,
}
local load_fold = {
	callback = function()
		if vim.bo.filetype ~= "" and vim.fn.expand("%") ~= "" and not vim.bo.buftype:match("nofile") then
			vim.cmd("silent! loadview")
		end
	end,
}

vim.api.nvim_create_autocmd("BufWinLeave", save_fold)
vim.api.nvim_create_autocmd("BufWritePre", save_fold)
vim.api.nvim_create_autocmd("BufWinEnter", load_fold)
vim.api.nvim_create_autocmd("BufWritePost", load_fold)
