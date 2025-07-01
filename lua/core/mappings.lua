-- Global
vim.g.mapleader = " "

--- @type vim.keymap.set.Opts
local opts = { silent = true, noremap = true }

-- Flutter reload|restart
vim.keymap.set("n", "<leader>r", function()
	vim.fn.system("flutter-reload --reload")
end, opts)
vim.keymap.set("n", "<leader>R", function()
	vim.fn.system("flutter-reload --restart")
end, opts)

-- LspSignature
vim.keymap.set("n", "<leader>k", function()
	require("lsp_signature").toggle_float_win()
end, opts)
vim.keymap.set("i", "<C-k>", function()
	require("lsp_signature").toggle_float_win()
end, opts)

-- Disable mouse
vim.opt.mouse = ""
vim.keymap.set("", "<up>", "<nop>", opts)
vim.keymap.set("", "<down>", "<nop>", opts)
vim.keymap.set("i", "<up>", "<nop>", opts)
vim.keymap.set("i", "<down>", "<nop>", opts)

-- System
vim.keymap.set("n", "<leader>w", ":w<CR>", opts)
vim.keymap.set("n", "<leader>q", ":q<CR>", opts)

-- Terminal
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", opts)
vim.keymap.set("n", "<leader>t", ":ToggleTerm direction=float<CR>", opts)

-- Folder
vim.keymap.set("n", "<leader>e", ":Neotree<CR>", opts)

-- Vsnip jump
-- Переход к следующему плейсхолдеру
vim.api.nvim_set_keymap(
	"i", -- режим вставки
	"<C-Tab>", -- клавиша
	'vsnip#jumpable(1) ? "<Plug>(vsnip-jump-next)" : "<C-Tab>"',
	{ expr = true, noremap = false }
)

vim.api.nvim_set_keymap(
	"s", -- режим выделения
	"<C-Tab>",
	'vsnip#jumpable(1) ? "<Plug>(vsnip-jump-next)" : "<C-Tab>"',
	{ expr = true, noremap = false }
)

-- Переход к предыдущему плейсхолдеру
vim.api.nvim_set_keymap(
	"i",
	"<S-Tab>",
	'vsnip#jumpable(-1) ? "<Plug>(vsnip-jump-prev)" : "<S-Tab>"',
	{ expr = true, noremap = false }
)

vim.api.nvim_set_keymap(
	"s",
	"<S-Tab>",
	'vsnip#jumpable(-1) ? "<Plug>(vsnip-jump-prev)" : "<S-Tab>"',
	{ expr = true, noremap = false }
)

-----------------------------------
local luasnip = require("luasnip")

-- Устанавливаем свои клавиши
vim.keymap.set({ "i", "s" }, "<C-Tab>", function()
	if luasnip.expand_or_jumpable() then
		luasnip.expand_or_jump()
	end
end, opts)

vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
	if luasnip.jumpable(-1) then
		luasnip.jump(-1)
	end
end, opts)

-- Перемещение выделенного блока вверх/вниз (Ctrl+j и Ctrl+k)
vim.keymap.set("x", "<C-j>", ":m '>+1<CR>gv=gv", opts)
vim.keymap.set("x", "<C-k>", ":m '<-2<CR>gv=gv", opts)

-- Сдвиг выделенного блока вправо/влево (Ctrl+h и Ctrl+l)
vim.keymap.set("x", "<C-h>", "<gv", opts)
vim.keymap.set("x", "<C-l>", ">gv", opts)

-- Code actions
vim.keymap.set({ "n", "v" }, "<leader>c", vim.lsp.buf.code_action, opts)

-- Exceptions
vim.keymap.set("n", "<C-w>a", function()
	vim.diagnostic.open_float({ scope = "buffer" })
end, opts)

-- Python venv selector
vim.keymap.set("n", "<leader>v", ":VenvSelect<CR>", opts)

-- Tab регулировка
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

-- Выйти из определения
vim.keymap.set("n", "<C-[>", "<C-t>", opts)

-- Telescope nvim
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

-- Errors
vim.keymap.set("n", "<leader>de", function()
	vim.diagnostic.setqflist() -- Обновить список ошибок
	vim.cmd("cfirst") -- Перейти к первой ошибке
	vim.cmd("cclose") -- Закрыть quickfix окно
end, opts)
