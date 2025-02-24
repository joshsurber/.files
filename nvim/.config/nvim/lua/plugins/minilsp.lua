-- local add = MiniDeps.add
local add = require('mini.deps').add

add({ source = "neovim/nvim-lspconfig" })

add("rafamadriz/friendly-snippets")

add({
    source = "williamboman/mason.nvim",
    depends = { "williamboman/mason-lspconfig.nvim" },
})
require("mason").setup({})
require("mason-lspconfig").setup({

    -- Replace the language servers listed here
    -- with the ones you want to install
    ensure_installed = {},
    automatic_installation = true,
    handlers = {
        function(server_name)
            require("lspconfig")[server_name].setup({})
        end,
        lua_ls = function()
            require('lspconfig').lua_ls.setup({
                settings = {
                    Lua = {
                        runtime = {
                            version = 'LuaJIT'
                        },
                        diagnostics = {
                            globals = { 'vim' },
                        },
                        workspace = {
                            library = {
                                vim.env.VIMRUNTIME,
                            }
                        }
                    }
                }
            })
        end,
    },
})

-- Reserve a space in the gutter
vim.opt.signcolumn = "yes"

-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP actions",
    callback = function(event)
        local map = vim.keymap.set
        local opts = { buffer = event.buf }
        local buf = vim.lsp.buf

        -- LSP mappings
        map("n", "gh", buf.hover, { desc = "Floating information window" })
        map("n", "gH", buf.signature_help, { desc = "Signature information floating window" })
        map("n", "<leader>ld", buf.definition, { desc = "Go to definition" })
        map("n", "<leader>lD", buf.declaration, { desc = "Go to declaration" })
        map("n", "<leader>li", buf.implementation, { desc = "List implementations in quickfix window" })
        map("n", "<leader>lo", buf.type_definition, { desc = "Go to type definition" })
        map("n", "<leader>lR", buf.references, { desc = "List referencess in quickfix window" })
        map("n", "<leader>lr", buf.rename, { desc = "Rename symbol under cursor" })
        map("n", "<leader>la", buf.code_action, { desc = "Select a code action" })
        map("n", "<leader>lf", buf.format, { desc = "Format buffer" })
        -- map('n', '<leader>lF', '<cmd>%!prettier --stdin-filepath %<cr>', { desc = 'Format with prettier' })
        map("n", "<leader>ll", vim.diagnostic.open_float, { desc = "Show diagnostics in floating window" })

        vim.diagnostic.config({ virtual_text = true })
        vim.cmd([[ command! Format :lua vim.lsp.buf.format() ]])
    end,
})
