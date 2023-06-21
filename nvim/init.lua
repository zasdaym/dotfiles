-- Plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugins
require('lazy').setup({
  {
    "Mofiqul/vscode.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        options = {
          icons_enabled = false,
        }
      })
    end,
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = '0.1.1',
    dependencies = {
      "nvim-lua/plenary.nvim" ,
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope-fzy-native.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
    build = ":TSUpdate",
    config = function()
      require("telescope").load_extension("fzy_native")
      require("telescope").load_extension("ui-select")
    end,
  },
  {
    "sheerun/vim-polyglot",
  },
})

-- Color
vim.opt.termguicolors = true
vim.cmd [[colorscheme vscode]]

-- Case
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Display
vim.opt.number = true
vim.opt.hlsearch = false
vim.opt.showmatch = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.shortmess = "I"

-- System
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "undo"

-- Indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = -1
vim.opt.shiftwidth = 4

-- Keymap
vim.g.mapleader = ","
vim.keymap.set("i", "jj", "<ESC>")
vim.keymap.set("i", "jk", "<ESC>")

local telescope_builtin = require("telescope.builtin")
vim.keymap.set("n", "<Leader>p", telescope_builtin.git_files)
vim.keymap.set("n", "<Leader>t", telescope_builtin.lsp_document_symbols)
vim.keymap.set("n", "<Leader>f", telescope_builtin.live_grep)
