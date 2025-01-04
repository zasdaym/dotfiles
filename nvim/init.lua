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
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        contrast = "hard",
        italic = {
          strings = false,
          emphasis = false,
          comments = false,
          operators = false,
          folds = false,
        },
      })
    end,
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
    tag = '0.1.2',
    dependencies = {
      "nvim-lua/plenary.nvim" ,
      "nvim-telescope/telescope-fzy-native.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
      require("telescope").load_extension("fzy_native")
      require("telescope").load_extension("ui-select")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "pfeiferj/nvim-hurl",
    },
    build = ":TSUpdate",
    config = function()
      require("hurl").setup()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash",
          "dockerfile",
          "elixir",
          "fish",
          "git_config",
          "git_rebase",
          "gitattributes",
          "gitcommit",
          "gitignore",
          "go",
          "gomod",
          "hcl",
          "hurl",
          "javascript",
          "json",
          "lua",
          "markdown",
          "markdown_inline",
          "make",
          "proto",
          "puppet",
          "python",
          "scheme",
          "sql",
          "terraform",
          "toml",
          "yaml",
        },
        incremental_selection = {
          enable = true,
        },
        indent = {
          enable = false,
        },
        highlight = {
          enable = true,
          disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
        },
      })
    end,
  },
})

-- Color
vim.opt.termguicolors = true
vim.cmd [[colorscheme gruvbox]]

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
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

vim.api.nvim_create_autocmd('Filetype', {
  group = vim.api.nvim_create_augroup('setIndent', {}),
  pattern = { 'javascript', 'puppet', 'typescript', 'hcl' },
  command = 'setlocal tabstop=2 shiftwidth=2 expandtab'
})

vim.filetype.add({
  extension = {
    sls = "yaml"
  }
})

-- Keymap
vim.g.mapleader = ","

local telescope_builtin = require("telescope.builtin")
vim.keymap.set("n", "<Leader>p", telescope_builtin.git_files)
vim.keymap.set("n", "<Leader>t", telescope_builtin.lsp_document_symbols)
vim.keymap.set("n", "<Leader>f", telescope_builtin.live_grep)
