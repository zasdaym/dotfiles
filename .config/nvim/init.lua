-- Options ---------------------------------------------------------------

vim.loader.enable()

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.number = true
vim.opt.updatetime = 300
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Plugins ---------------------------------------------------------------

vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		if ev.data.spec.name == "nvim-treesitter" and ev.data.kind == "update" then
			vim.cmd("TSUpdate")
		end
	end,
})

vim.pack.add({
	{
		src = "https://github.com/kepano/flexoki-neovim",
		name = "flexoki-neovim",
	},
	{
		src = "https://github.com/rose-pine/neovim",
		name = "rose-pine",
	},
	{
		src = "https://github.com/asiryk/auto-hlsearch.nvim",
		version = "1.1.0",
	},
	{
		src = "https://github.com/neovim/nvim-lspconfig",
	},
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter",
	},
	{
		src = "https://github.com/nvim-mini/mini.nvim",
		name = "mini.nvim",
	},
})

require("nvim-treesitter").setup({})
require("nvim-treesitter").install({ "go", "lua", "bash", "yaml", "markdown", "markdown_inline" })

vim.lsp.enable({ "gopls", "yamlls", "bashls" })

require("auto-hlsearch").setup()

require("mini.icons").setup({})
require("mini.pairs").setup({})

local completion_process_items = function(items, base)
	return MiniCompletion.default_process_items(items, base, { filtersort = "fuzzy" })
end
require("mini.completion").setup({
	lsp_completion = { process_items = completion_process_items },
})
require("mini.pick").setup({})
require("mini.extra").setup({})
require("mini.diff").setup({})
require("mini.git").setup({})
require("mini.statusline").setup({})

-- Keymaps ---------------------------------------------------------------

vim.keymap.set("n", "<leader>f", "<cmd>Pick files<cr>", { desc = "Find files" })
vim.keymap.set("n", "<leader>g", "<cmd>Pick grep_live<cr>", { desc = "Live grep" })
vim.keymap.set("n", "<leader>b", "<cmd>Pick buffers<cr>", { desc = "Find buffers" })
vim.keymap.set("n", "<leader>d", function()
	MiniExtra.pickers.diagnostic()
end, { desc = "Show all diagnostics" })

vim.keymap.set("i", "<Tab>", [[pumvisible() ? "<C-n>" : "<Tab>"]], { expr = true })
vim.keymap.set("i", "<S-Tab>", [[pumvisible() ? "<C-p>" : "<S-Tab>"]], { expr = true })

-- Autocmds ---------------------------------------------------------------

vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		if vim.treesitter.get_parser(args.buf, nil, { error = false }) then
			pcall(vim.treesitter.start, args.buf)
		end
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = args.buf, desc = "Go to definition" })
	end,
})

vim.api.nvim_create_autocmd("CursorHold", {
	callback = function()
		vim.diagnostic.open_float(nil, { focus = false })
	end,
})

-- Diagnostics -------------------------------------------------------------

vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "●",
			[vim.diagnostic.severity.WARN] = "●",
			[vim.diagnostic.severity.INFO] = "●",
			[vim.diagnostic.severity.HINT] = "●",
		},
	},
})

-- Theme -----------------------------------------------------------------

require("rose-pine").setup({
	variant = "auto",
	dark_variant = "moon",
	styles = {
		italic = false,
	},
})

vim.cmd("colorscheme flexoki-light")
