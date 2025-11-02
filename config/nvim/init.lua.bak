-- bootstrap lazy.nvim plugin manager
vim.opt.runtimepath:prepend("~/.config/nvim/lazy/lazy.nvim")

require("lazy").setup({
    {
        "Mofiqul/vscode.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.o.termguicolors = true
            vim.cmd("colorscheme vscode")
        end,
    },

    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

    "neovim/nvim-lspconfig",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-nvim-lsp-signature-help",

    "windwp/nvim-autopairs",

    "onsails/lspkind.nvim",
})

-- treesitter config
require("nvim-treesitter.configs").setup ({
  ensure_installed = { "cpp", "c", "lua", "cmake", "xml", "bash" },
  highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
  },
})

require("nvim-autopairs").setup()

-- LSP config for C++
vim.lsp.config('clangd', {
    cmd = { "clangd", "--function-arg-placeholders=0", "--header-insertion=never"},
    handlers = {
        ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded"}),
        ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
    },
})

vim.lsp.enable('clangd')

-- LSP config for CMake
vim.lsp.config('cmake', {
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
    on_attach = function(client, bufnr)
        local opts = { noremap=true, silent=true, buffer=bufnr }
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    end,
})

vim.lsp.enable('cmake')

vim.lsp.config('gopls', {})
vim.lsp.enable('gopls')

local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup {
  snippet = {
    expand = function(args) luasnip.lsp_expand(args.body) end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<Tab>'] = cmp.mapping.confirm({
        select = true,
    }),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
  },
}

cmp.setup.filetype("cmake", {
  formatting = {
    format = function(entry, vim_item)
      vim_item.abbr = vim_item.abbr:gsub("%b()", "()")
      vim_item.abbr = vim_item.abbr:gsub("%b<>", "")
      return vim_item
    end,
  },
})

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help, { noremap = true, silent = true })

vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "#000000" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "#000000" })

vim.api.nvim_set_hl(0, "Pmenu", { bg = "#000000", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "#000000"})

vim.keymap.set("i", "<C-v>", '<Esc>"+pa', { desc = "Paste text" })
