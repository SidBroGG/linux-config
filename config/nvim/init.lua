-- Bootstrap lazy.nvim plugin manager
vim.opt.runtimepath:prepend("~/.config/nvim/lazy/lazy.nvim")

-- Plugins (lazy.nvim)
require("lazy").setup({
    {
        "Mofiqul/vscode.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.o.termguicolors = true
            vim.cmd.colorscheme("vscode")
        end,
    },

    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

    -- Core LSP & completion stack
    "neovim/nvim-lspconfig", -- optional fallback
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-nvim-lsp-signature-help",

    -- Utilities
    "windwp/nvim-autopairs",
    "onsails/lspkind.nvim",
})

-- Treesitter setup
require("nvim-treesitter.configs").setup({
    ensure_installed = { "cpp", "c", "go", "lua", "cmake", "xml", "bash" },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
})


-- nvim-autopairs setup
require("nvim-autopairs").setup()

-- LSP configurations (modern API)

local rounded_handlers = {
    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
    ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
}

-- C/C++ via clangd
vim.lsp.config("clangd", {
    cmd = { "clangd", "--function-arg-placeholders=0", "--header-insertion=never" },
    handlers = rounded_handlers,
})
vim.lsp.enable("clangd")

-- CMake
vim.lsp.config("cmake", {
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
    on_attach = function(_, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    end,
})
vim.lsp.enable("cmake")

-- Go
vim.lsp.config("gopls", {})
vim.lsp.enable("gopls")

-- Lspkind
local lspkind = require("lspkind")
lspkind.init({
    preset = "default",
    symbol_map = {
      Text = "󰉿",
      Method = "󰆧",
      Function = "󰊕",
      Constructor = "",
      Field = "󰜢",
      Variable = "󰀫",
      Class = "󰠱",
      Interface = "",
      Module = "",
      Property = "󰜢",
      Unit = "󰑭",
      Value = "󰎠",
      Enum = "",
      Keyword = "󰌋",
      Snippet = "",
      Color = "󰏘",
      File = "󰈙",
      Reference = "󰈇",
      Folder = "󰉋",
      EnumMember = "",
      Constant = "󰏿",
      Struct = "󰙅",
      Event = "",
      Operator = "󰆕",
      TypeParameter = "",
    },
})

-- nvim-cmp setup (completion)
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
    snippet = {
        expand = function(args) luasnip.lsp_expand(args.body) end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<Tab>"] = cmp.mapping.confirm({ select = true }),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
    }),
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
    },
    formatting = {
        format = require("lspkind").cmp_format({
            with_text = false,
            maxwidth = 50,
        }),
    },
})

-- CMake files
cmp.setup.filetype("cmake", {
    formatting = {
        format = function(_, vim_item)
            vim_item.abbr = vim_item.abbr:gsub("%b()", "()")
            vim_item.abbr = vim_item.abbr:gsub("%b<>", "")
            return vim_item
        end,
    },
})

-- Editor settings
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Signature help (Insert mode)
vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help, { noremap = true, silent = true, desc = "LSP signature help" })

-- Paste from system clipboard (Insert mode)
vim.keymap.set("i", "<C-v>", '<C-r>+', { noremap = true, silent = true, desc = "Paste text" })

-- UI / Highlight tweaks
local black = "#000000"
vim.api.nvim_set_hl(0, "Normal", { bg = black })
vim.api.nvim_set_hl(0, "NormalNC", { bg = black })
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = black })
vim.api.nvim_set_hl(0, "Pmenu", { bg = black, fg = "#ffffff" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = black })

