vim.o.number = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.opt.completeopt = { "menuone", "noselect", "fuzzy", "nosort" }
vim.opt.fillchars:append({ eob = " " })

vim.pack.add({
  { src = "https://github.com/kepano/flexoki-neovim" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/nvim-mini/mini.nvim" },
})

require("mini.completion").setup()
require("mini.diff").setup({
  view = {
    style = "sign"
  }
})
require("mini.extra").setup()
require("mini.git").setup()
require("mini.icons").setup()
require("mini.keymap").setup()
require("mini.pairs").setup()
require("mini.pick").setup()

MiniKeymap.map_multistep("i", "<Tab>", { "pmenu_next" })
MiniKeymap.map_multistep("i", "<S-Tab>", { "pmenu_prev" })
MiniKeymap.map_multistep("i", "<CR>", { "pmenu_accept", "minipairs_cr" })
MiniKeymap.map_multistep("i", "<BS>", { "minipairs_bs" })

local escape_modes = { "i", "c", "x", "s" }
MiniKeymap.map_combo(escape_modes, "jk", "<BS><BS><Esc>")
MiniKeymap.map_combo(escape_modes, "kj", "<BS><BS><Esc>")
MiniKeymap.map_combo("t", "jk", "<BS><BS><C-\\><C-n>")
MiniKeymap.map_combo("t", "kj", "<BS><BS><C-\\><C-n>")

vim.cmd.colorscheme("flexoki")

vim.g.mapleader = " "

vim.keymap.set("n", "<leader>f", function()
  MiniPick.builtin.files({ tool = "git" })
end, { desc = "Find files" })

vim.lsp.enable({ "gopls", "ty", "yamlls" })
