local keymap = vim.keymap
local api    = vim.api

-- Terminal window {{{

-- Enter terminal mode automatically
api.nvim_create_autocmd("TermOpen", {
    pattern = "term://*",
    command = ":startinsert",
    group   = api.nvim_create_augroup("term", { clear = true })
})

-- }}}

-- C files {{{

api.nvim_create_autocmd("FileType", {
    group = api.nvim_create_augroup("c-files", { clear = true }),

    pattern = "c",
    callback = function(args)
        local opts = { buffer = args.buf, silent = true }
        keymap.set("n", "<leader>h", vim.fn.CurtineIncSw,         opts)
        keymap.set("n", "<leader>/", "I/*<esc>A*/<esc>",          opts)
        keymap.set("v", "<leader>/", "<esc>`<I/*<esc>`>A*/<esc>", opts)
        keymap.set({"n", "v"},
            "<leader>\\", [[:s/\(\/\*\s\?\|\s\?\*\/\)//g<cr>:noh<cr>]], opts)
        keymap.set("i", "<C-Space>", "<C-x><C-o>", opts)

        vim.b.load_doxygen_syntax = true

        api.nvim_create_autocmd("BufEnter", {
            buffer = args.buf,
            callback = function() vim.wo.number = true end
        })

        -- Remove trailing spaces
        api.nvim_create_autocmd("BufWritePre", {
            buffer = args.buf,
            command = [[:%s/\s\+$//e]]
        })
    end,
})

-- }}}

-- C++ files {{{

function cpp_indent()
    local cline_num = vim.v.lnum
    local cline     = vim.fn.getline(cline_num)
    local pline_num = vim.fn.prevnonblank(cline_num - 1)
    local pline     = vim.fn.getline(pline_num)

    local template_start = [[^%s*template%s+<]]
    local template_end   = [[>%s*$]]

    if string.match(pline, template_end) ~= nil then
        -- Try to find the beginning template keyword and use its indention
        for i = pline, 0, -1 do
            if string.match(vim.fn.getline(i), template_start) then
                return vim.fn.indent(i)
            end
        end

        return vim.fn.cindent(cline_num) - vim.o.shiftwidth
    end

    if string.match(pline, template_start) ~= nil then
        return vim.fn.indent(cline_num)
    end

    return vim.fn.cindent(cline_num)
end

local cxx_files = api.nvim_create_augroup("cxx_files", { clear = true })
api.nvim_create_autocmd("FileType", {
    group = cxx_files,
    pattern = "cpp",

    callback = function(args)
        local opts = { buffer = args.buf, silent = true }
        keymap.set("n", "<leader>h", vim.fn.CurtineIncSw, opts)
        keymap.set({ "n", "v" },
            "<leader>/", [[:s/\(^\s*\)/\1\/\/ /<cr>:noh<cr>]], opts)
        keymap.set({ "n", "v" },
            "<leader>\\", [[:s/\(\s*\)\/\/\s*/\1/<cr>:noh<cr>]], opts)
        keymap.set("i", "<C-Space>", "<C-x><C-o>", opts)

        vim.b.load_doxygen_syntax = true
        vim.bo.cinoptions = "g0,l1,L0,:0,N-s,(0"
        vim.bo.indentexpr = "v:lua.cpp_indent()"

        api.nvim_create_autocmd("BufEnter", {
            buffer   = args.buf,
            callback = function()
                vim.wo.number    = true
                vim.bo.textwidth = 90
            end
        })

        -- Remove trailing spaces
        api.nvim_create_autocmd("BufWritePre", {
            buffer  = args.buf,
            command = [[:%s/\s\+$//e"]]
        })
    end,
})

api.nvim_create_autocmd("BufEnter", {
    group = cxx_files,
    pattern = "*.cppm",
    command = ":set filetype=cpp"
})

-- }}}

-- Go file settings {{{

api.nvim_create_autocmd("FileType", {
    group = api.nvim_create_augroup("go-files", { clear = true }),
    pattern = "go",

    callback = function(args)
        local opts = { buffer = args.buf, silent = true }
        keymap.set("i", "`", "``<left>", opts)
        keymap.set({ "n", "v" },
            "<leader>/", [[:s/\(^\s*\)/\1\/\/ /<cr>:noh<cr>]], opts)
        keymap.set({ "n", "v" },
            "<leader>\\", [[:s/\(\s*\)\/\/\s*/\1/<cr>:noh<cr>]], opts)
        keymap.set("i", "<C-Space>", "<C-x><C-o>", opts)

        api.nvim_create_autocmd("BufEnter", {
            buffer = args.buf,
            callback = function()
                vim.wo.number    = true
                vim.bo.expandtab = false
                vim.bo.textwidth = 90
                vim.bo.formatoptions = "jcroql"
            end
        })

        -- Auto format on exit
        api.nvim_create_autocmd("BufWritePre", {
            buffer   = args.buf,
            callback = function() vim.lsp.buf.format() end
        })
    end,
})

-- }}}

-- Rust file settings {{{

api.nvim_create_autocmd("FileType", {
    group = api.nvim_create_augroup("rust-files", { clear = true }),
    pattern = "rust",

    callback = function(args)
        local opts = { buffer = args.buf, silent = true }
        keymap.set({ "n", "v" },
            "<leader>/", [[:s/\(^\s*\)/\1\/\/ /<cr>:noh<cr>]], opts)
        keymap.set({ "n", "v" },
            "<leader>\\", [[:s/\(\s*\)\/\/\s*/\1/<cr>:noh<cr>]], opts)
        keymap.set("i", "<C-Space>", "<C-x><C-o>", opts)

        api.nvim_create_autocmd("BufEnter", {
            buffer = args.buf,
            callback = function()
                vim.wo.number    = true
                vim.bo.textwidth = 90
            end
        })

        -- Remove trailing spaces
        api.nvim_create_autocmd("BufWritePre", {
            buffer  = args.buf,
            command = [[:%s/\s\+$//e"]]
        })
    end,
})

-- }}}

-- Python file settings {{{

api.nvim_create_autocmd("FileType", {
    group = api.nvim_create_augroup("python-files", { clear = true }),
    pattern = "python",

    callback = function(args)
        local opts = { buffer = args.buf, silent = true }
        keymap.set({ "n", "v" }, "<leader>/",  [[:s/^/#/<cr>:noh<cr>]], opts)
        keymap.set({ "n", "v" }, "<leader>\\", [[:s/^#//<cr>:noh<cr>]], opts)
        keymap.set("i", "<C-Space>", "<C-x><C-o>", opts)

        api.nvim_create_autocmd("BufEnter", {
            buffer = args.buf,
            callback = function()
                vim.wo.spell = true
                vim.wo.number = true
                vim.wo.colorcolumn = "80"
                vim.bo.textwidth = 100
            end
        })

        -- Auto format on exit
        api.nvim_create_autocmd("BufWritePre", {
            buffer   = args.buf,
            callback = function() vim.lsp.buf.format() end
        })
    end
})

-- }}}

-- Files with #-comments {{{

api.nvim_create_autocmd("FileType", {
    group = api.nvim_create_augroup("hash-comments", { clear = true }),
    pattern = {
        "cmake",
        "perl",
        "python",
        "sh",
    },

    callback = function(args)
        local opts = { buffer = args.buf, silent = true }
        keymap.set({ "n", "v" }, "<leader>/",  [[:s/^/#/<cr>:noh<cr>]], opts)
        keymap.set({ "n", "v" }, "<leader>\\", [[:s/^#//<cr>:noh<cr>]], opts)
        keymap.set("i", "<C-Space>", "<C-x><C-o>", opts)
    end
})

-- }}}

-- Vimscript file settings {{{

api.nvim_create_autocmd("FileType", {
    group = api.nvim_create_augroup("vim-files", { clear = true }),
    pattern = "vim",

    callback = function(args)
        local opts = { buffer = args.buf, silent = true }
        keymap.set({ "n", "v" }, "<leader>/",  [[:s/\(^\s*\)/\1" /<cr>:noh<cr>]],  opts)
        keymap.set({ "n", "v" }, "<leader>\\", [[:s/\(\s*\)"\s*/\1/<cr>:noh<cr>]], opts)
        keymap.set("i", '"', '"', opts) -- disable closing "
    end,
})

-- }}}

-- Markdown settings {{{

api.nvim_create_autocmd("FileType", {
    group = api.nvim_create_augroup("md-files", { clear = true }),
    pattern = "markdown",

    callback = function()
        vim.opt.formatoptions:remove{"l"} -- break long lines in insert mode
    end
})

vim.g.markdown_fenced_languages = {
    "bash",
    "c",
    "cmake",
    "cpp",
    "python",
    "qml",
}

-- }}}

-- QML settings {{{

api.nvim_create_autocmd("FileType", {
    group = api.nvim_create_augroup("qml-files", { clear = true }),
    pattern = "qml",

    callback = function(args)
        local opts = { buffer = args.buf, silent = true }
        keymap.set({ "n", "v" },
            "<leader>/",  [[:s/\(^\s*\)/\1\/\/ /<cr>:noh<cr>]],  opts)
        keymap.set({ "n", "v" },
            "<leader>\\", [[:s/\(\s*\)\/\/\s*/\1/<cr>:noh<cr>]], opts)
        keymap.set("i", "<C-Space>", "<C-x><C-o>", opts)

        api.nvim_create_autocmd("BufEnter", {
            buffer   = args.buf,
            callback = function() vim.wo.number = true end
        })
    end
})

-- }}}

-- Lua settings {{{

api.nvim_create_autocmd("FileType", {
    group = api.nvim_create_augroup("lua-files", { clear = true }),
    pattern = "lua",

    callback = function(args)
        local opts = { buffer = args.buf, silent = true }

        -- Line comments
        keymap.set({ "n", "v" }, "<leader>/",  [[:s/\(^\s*\)/\1-- /<cr>:noh<cr>]],  opts)
        keymap.set({ "n", "v" }, "<leader>\\", [[:s/\(\s*\)--\s*/\1/<cr>:noh<cr>]], opts)

        api.nvim_create_autocmd("BufEnter", {
            buffer   = args.buf,
            callback = function() vim.wo.number = true end
        })
    end
})

-- }}}

-- plantuml settings {{{

-- Don't set plantuml as a make program
vim.g.plantuml_set_makeprg = 0

api.nvim_create_autocmd("FileType", {
    group = api.nvim_create_augroup("qml-files", { clear = true }),
    pattern = "qml",

    callback = function(args)
        local opts = { buffer = args.buf, silent = true }
        keymap.set("i", "'", "'", opts) -- disable closing '
        keymap.set("i", '[', '[', opts) -- disable closing [

        local open_cmd = "xdg-open"
        if vim.fn.has("mac") then
            open_cmd = "open"
        end

        keymap.set("n", "<leader>v",
            ":w<cr>:" .. 
            "!plantuml -output /tmp % && " ..
            open_cmd .. " /tmp/%:t:r.png &<cr>",
        opts)
    end
})

-- }}}

-- terminal settings {{{

api.nvim_create_autocmd({"TermOpen"}, {
    group = api.nvim_create_augroup("terminal", { clear = true }),
    pattern = "*",

    callback = function()
        vim.wo.spell = false
    end
})

-- }}}
