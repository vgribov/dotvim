local api        = vim.api
local diagnostic = vim.diagnostic
local keymap     = vim.keymap
local lsp        = vim.lsp

-- Denite {{{

vim.fn["denite#custom#option"]('_', { split = 'no' })

local search_cmd = vim.fn.expand('<sfile>:p:h') .. '/bin/search'

-- find

vim.fn["denite#custom#var"]('file/rec', 'command', { search_cmd })

vim.fn["denite#custom#alias"]('source', 'file/rec/git', 'file/rec')

vim.fn["denite#custom#var"]('file/rec/git',
    'command', { 'git', 'ls-files', '-co', '--exclude-standard' })

local function denite_find_src()
    return vim.fn.isdirectory(".git") == 1 and 'file/rec/git' or 'file/rec'
end

-- grep

vim.fn["denite#custom#var"]('grep', {
    command        = { search_cmd },
    default_opts   = {},
    recursive_opts = {},
    pattern_opt    = {},
    separator      = {},
})

vim.fn["denite#custom#alias"]('source', 'grep/git', 'grep')

vim.fn["denite#custom#var"]('grep/git', {
    command        = { 'git', 'grep' },
    default_opts   = { '-ne' },
    recursive_opts = {},
    pattern_opt    = {},
    separator      = {},
})

local function denite_grep_src()
    return vim.fn.isdirectory(".git") == 1 and 'grep/git' or 'grep'
end

-- Denite buffer configuration
api.nvim_create_autocmd("FileType", {
    group   = api.nvim_create_augroup("denite-config", { clear = true }),
    pattern = "denite",

    callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }
        local map  = vim.fn['denite#call_map']
        keymap.set("n", "<cr>",    function() map('do_action') end, opts)
        keymap.set("n", "d",       function() map('do_action', 'delete') end, opts)
        keymap.set("n", "v",       function() map('do_action', 'preview') end, opts)
        keymap.set("n", "q",       function() map('quit') end, opts)
        keymap.set("n", "i",       function() map('open_filter_buffer') end, opts)
        keymap.set("n", "<space>", function() map('toggle_select') end, opts)
    end
})

local function Denite(src)
    vim.fn['denite#helper#call_denite']('Denite', src, 0, 0)
end

keymap.set("n", "<leader>k", function()
    Denite('-start-filter ' .. denite_find_src())
end, { silent = true })

keymap.set("n", "<leader>s", function()
    Denite(denite_grep_src())
end, { silent = true })

keymap.set("n", "<leader>s*", function()
    local lookup = string.format([[\\<%s\\>]], vim.fn.expand('<cword>'))
    Denite(denite_grep_src() .. ':::' .. lookup)
end, { silent = true })

keymap.set("n", "<leader>l", function() Denite('buffer')  end, { silent = true })
keymap.set("n", "<leader>.", function() Denite('-resume') end, { silent = true })

-- }}}

-- Defx {{{

vim.fn["defx#custom#column"]('icon', {
    directory_icon = '▸',
    opened_icon    = '▾',
    root_icon      = ' ',
})

vim.fn["defx#custom#column"]('filename', {
    min_width = 40,
    max_width = 40,
})

vim.fn["defx#custom#column"]('mark', {
    readonly_icon = '✗',
    selected_icon = '✓',
})

api.nvim_create_autocmd("FileType", {
    group   = api.nvim_create_augroup("defx-config", { clear = true }),
    pattern = "defx",

    callback = function(ev)
        local opts      = { buffer = ev.buf, silent = true }
        local opts_expr = { buffer = ev.buf, silent = true, expr = true }

        local defx_do   = vim.fn["defx#do_action"]
        local defx_call = vim.fn["defx#call_action"]
        local line      = vim.fn.line

        keymap.set("n", "<cr>",    function() defx_call("open") end, opts)
        keymap.set("n", "c",       function() defx_call("copy") end, opts)
        keymap.set("n", "m",       function() defx_call("move") end, opts)
        keymap.set("n", "p",       function() defx_call("paste") end, opts)
        keymap.set("n", "l",       function() defx_call("open") end, opts)
        keymap.set("n", "t",       function() defx_call("open_or_close_tree") end, opts)
        -- keymap.set("n", "E",       function() return defx_do("open", "vsplit") end, opts)
        -- keymap.set("n", "P",       function() return defx_do("open", "pedit") end, opts)
        keymap.set("n", "K",       function() defx_call("new_directory") end, opts)
        keymap.set("n", "N",       function() defx_call("new_file") end, opts)
        keymap.set("n", "M",       function() defx_call("new_multiple_files") end, opts)
        keymap.set("n", "C",       function() defx_call("toggle_columns", "mark:filename:type:size:time") end, opts)
        keymap.set("n", "S",       function() defx_call("toggle_sort", "time") end, opts)
        keymap.set("n", "d",       function() defx_call("remove") end, opts)
        keymap.set("n", "r",       function() defx_call("rename") end, opts)
        keymap.set("n", "!",       function() defx_call("execute_command") end, opts)
        keymap.set("n", "x",       function() defx_call("execute_system") end, opts)
        keymap.set("n", "yy",      function() defx_call("yank_path") end, opts)
        keymap.set("n", ".",       function() defx_call("toggle_ignored_files") end, opts)
        keymap.set("n", ";",       function() defx_call("repeat") end, opts)
        keymap.set("n", "h",       function() defx_call("cd", {".."}) end, opts)
        keymap.set("n", "~",       function() defx_call("cd") end, opts)
        keymap.set("n", "q",       function() defx_call("quit") end, opts)
        keymap.set("n", "<esc>",   function() defx_call("quit") end, opts)
        keymap.set("n", "<Space>", function() defx_call("toggle_select") end, opts)
        keymap.set("n", "*",       function() defx_call("toggle_select_all") end, opts)
        keymap.set("n", "j", function()
            return line(".") == line("$") and "ggj" or "j"
        end, opts_expr)
        keymap.set("n", "k", function()
            return line(".") == 2 and "G" or "k"
        end, opts_expr)
        keymap.set("n", "<C-l>",   function() defx_call("redraw") end, opts)
        keymap.set("n", "<C-g>",   function() defx_call("print") end, opts)
        keymap.set("n", "cd",      function() defx_call("change_vim_cwd") end, opts)

        vim.wo.number = false
    end
})

keymap.set("n", "-", ":Defx `expand('%:p:h')` -search=`expand('%:p')`<cr>",
           { silent = true })
keymap.set("n", "<leader>ex", ":Defx<cr>", { silent = true})

-- }}}

-- bbye {{{

keymap.set("n", "<leader>bd", ":Bwipeout<cr>")
keymap.set("n", "<leader>bc", ":Bdelete<cr>")

-- }}}

-- Tagbar {{{

vim.g.tagbar_compact   = 1
vim.g.tagbar_autoclose = 1
vim.g.tagbar_type_objc = {
    ctagstype = 'ObjectiveC',
    kinds = {
        'M:macros',
        't:types',
        's:structures',
        'e:enumerations',
        'i:interface',
        'I:implementation',
        'p:properties',
        'm:methods',
        'c:class methods',
        'F:object fields',
        'f:functions'
    }
}

keymap.set("n", "<leader>tb", ":TagbarToggle<cr>")

-- }}}

-- nvim-lspconfig {{{

local lspconfig = require "lspconfig"

-- Setup language servers.
lspconfig.clangd.setup{}
lspconfig.gopls.setup{}
lspconfig.perlls.setup{}
lspconfig.qmlls.setup{}
lspconfig.rust_analyzer.setup{}

lspconfig.ruff.setup{}
lspconfig.pyright.setup{}

-- Global mappings.
keymap.set("n", "<leader>e", diagnostic.open_float)
keymap.set("n", "[d",        diagnostic.goto_prev)
keymap.set("n", "]d",        diagnostic.goto_next)
keymap.set("n", "<leader>q", diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
api.nvim_create_autocmd("LspAttach", {
    group = api.nvim_create_augroup("lsp-config", { clear = true }),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

        -- Buffer local mappings.
        local opts = { buffer = ev.buf }
        keymap.set("n", "gD",         lsp.buf.declaration, opts)
        keymap.set("n", "gd",         lsp.buf.definition, opts)
        keymap.set("n", "K",          lsp.buf.hover, opts)
        keymap.set("n", "gi",         lsp.buf.implementation, opts)
        keymap.set("n", "<C-k>",      lsp.buf.signature_help, opts)
        keymap.set("n", "<leader>wa", lsp.buf.add_workspace_folder, opts)
        keymap.set("n", "<leader>wr", lsp.buf.remove_workspace_folder, opts)
        keymap.set("n", "<leader>wl", function()
            print(vim.inspect(lsp.buf.list_workspace_folders()))
        end, opts)
        keymap.set("n", "<leader>ws", lsp.buf.workspace_symbol, opts)
        keymap.set("n", "<leader>D",  lsp.buf.type_definition, opts)
        keymap.set("n", "<leader>rn", lsp.buf.rename, opts)
        keymap.set({ "n", "v" }, "<leader>ca", lsp.buf.code_action, opts)
        keymap.set("n", "gr",         lsp.buf.references, opts)
        keymap.set("n", "<leader>f", function()
            lsp.buf.format{ async = true }
        end, opts)
    end,
})

-- }}}

-- Tabularize {{{
keymap.set({"v", "n"}, "<leader>a=", ":Tabularize /=<cr>",            { silent = true })
keymap.set({"v", "n"}, "<leader>a:", ":Tabularize /:\zs<cr>",         { silent = true })
keymap.set({"v", "n"}, "<leader>aa", ":Tabularize / [A-Za-z]/l0<cr>", { silent = true })
-- }}}
