return {
    {
        "mason-org/mason.nvim",
        cmd = { "Mason" },
        opts = {
            ui = {
                border = "rounded",
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        },
    },

    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
            "mason-org/mason.nvim",
            "neovim/nvim-lspconfig",
        },
        opts = {
            ensure_installed = { "lua_ls", "bashls", "clangd" },
            automatic_enable = false,
        },
    },

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            { "folke/lazydev.nvim", ft = "lua", opts = {} },
        },
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            local group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true })

            vim.api.nvim_create_autocmd("LspAttach", {
                group = group,
                callback = function(ev)
                    local map = function(mode, lhs, rhs, desc)
                        vim.keymap.set(mode, lhs, rhs, {
                            buffer = ev.buf,
                            silent = true,
                            desc = desc,
                        })
                    end

                    local function trim_empty_edges(lines)
                        local first, last = 1, #lines
                        while first <= last and lines[first]:match("^%s*$") do first = first + 1 end
                        while last >= first and lines[last]:match("^%s*$") do last = last - 1 end
                        return first > last and {} or vim.list_slice(lines, first, last)
                    end

                    local function hover_top_right()
                        local bufnr = vim.api.nvim_get_current_buf()
                        local params = vim.lsp.util.make_position_params()

                        vim.lsp.buf_request(bufnr, "textDocument/hover", params, function(err, result)
                            if err or not result or not result.contents then return end

                            local lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
                            lines = trim_empty_edges(lines)
                            if vim.tbl_isempty(lines) then return end

                            local buf = vim.api.nvim_create_buf(false, true)
                            vim.bo[buf].bufhidden = "wipe"
                            vim.bo[buf].filetype = "markdown"

                            vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

                            local width = math.min(80, math.floor(vim.o.columns * 0.35))
                            local height = math.min(#lines, math.floor(vim.o.lines * 0.3))

                            local win = vim.api.nvim_open_win(buf, false, {
                                relative = "editor",
                                anchor = "NE",
                                row = 1,
                                col = vim.o.columns - 2,
                                width = width,
                                height = math.max(height, 1),
                                border = "rounded",
                                title = " Hover ",
                                title_pos = "left",
                                style = "minimal",
                                focusable = true,
                                zindex = 60,
                            })

                            vim.wo[win].wrap = true
                            vim.wo[win].conceallevel = 2

                            for _, event in ipairs({ "CursorMoved", "CursorMovedI", "BufHidden", "InsertCharPre" }) do
                                vim.api.nvim_create_autocmd(event, {
                                    buffer = bufnr,
                                    once = true,
                                    callback = function()
                                        if vim.api.nvim_win_is_valid(win) then
                                            vim.api.nvim_win_close(win, true)
                                        end
                                    end,
                                })
                            end
                        end)
                    end

                    map("n", "K", hover_top_right, "LSP Hover")
                    map("n", "gd", vim.lsp.buf.definition)
                    map("n", "gD", vim.lsp.buf.declaration)
                    map("n", "gi", vim.lsp.buf.implementation)
                    map("n", "gr", vim.lsp.buf.references)
                    map("n", "<leader>rn", vim.lsp.buf.rename)
                    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action)

                    map("n", "[d", function()
                        vim.diagnostic.jump({ count = -1, float = true })
                    end)

                    map("n", "]d", function()
                        vim.diagnostic.jump({ count = 1, float = true })
                    end)

                    map("n", "<leader>dd", vim.diagnostic.open_float)
                end,
            })

            local servers = {
                lua_ls = {
                    capabilities = capabilities,
                    settings = {
                        Lua = {
                            completion = { callSnippet = "Replace" },
                            diagnostics = { globals = { "vim" } },
                            workspace = { checkThirdParty = false },
                        },
                    },
                },

                bashls = { capabilities = capabilities },

                clangd = {
                    capabilities = capabilities,
                    cmd = {
                        "clangd",
                        "--background-index",
                        "--clang-tidy",
                        "--header-insertion=iwyu",
                        "--suggest-missing-includes",
                    },
                },
            }

            for name, config in pairs(servers) do
                vim.lsp.config(name, config)
                vim.lsp.enable(name)
            end
        end,
    },
}
