return {
    "neovim/nvim-lspconfig",
    enabled = enabled,
    config = function()
        local lspconfig = require("lspconfig")
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        -- Python language server
        lspconfig.pyright.setup({
            capabilities = capabilities,
        })

        -- C++ language server
        lspconfig.clangd.setup({
            cmd = { "clangd" },
            filetypes = { "c", "cpp", "objc", "objcpp" },
            root_dir = lspconfig.util.root_pattern("compile_commands.json", ".git"),
            capabilities = capabilities,
        })

        -- Rust language server
        lspconfig.rust_analyzer.setup({
            cmd = { "rust-analyzer" },
            filetypes = { "rust" },
            root_dir = lspconfig.util.root_pattern("Cargo.toml", ".git"),
            capabilities = capabilities,
            settings = {
                ["rust-analyzer"] = {
                    cargo = { allFeatures = true },
                    checkOnSave = { command = "clippy" },
                },
            },
        })

        -- Cmake language server
        lspconfig.neocmake.setup({
            cmd = { "neocmakelsp", "--stdio" },
            filetypes = { "cmake" },
            root_dir = function(fname)
                return lspconfig.util.find_git_ancestor(fname)
            end,
            single_file_support = true,
            on_attach = on_attach,
            init_options = {
                format = {
                    enable = true
                },
                lint = {
                    enable = true
                },
                scan_cmake_in_package = true
            }
        })
    end,
}
