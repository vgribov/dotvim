let mapleader      = ' '
let maplocalleader = ','

" Plugins {{{

" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

call dein#begin('~/.cache/dein')

" Shougo
call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
call dein#add('Shougo/defx.nvim')
call dein#add('Shougo/denite.nvim')

" Basic
call dein#add('moll/vim-bbye')
call dein#add('majutsushi/tagbar')
call dein#add('itchyny/lightline.vim')
call dein#add('gcmt/taboo.vim',                     {'on_cmd': 'TabooOpen'})

" Development
call dein#add('neovim/nvim-lspconfig')
call dein#add('tpope/vim-fugitive')
call dein#add('octol/vim-cpp-enhanced-highlight',   {'on_ft': ['cpp']})
call dein#add('hynek/vim-python-pep8-indent',       {'on_ft': ['python']})
call dein#add('ericcurtin/CurtineIncSw.vim',        {'on_ft': ['c', 'cpp']})

" Syntax
call dein#add('aklt/plantuml-syntax',               {'on_ft': ['plantuml']})
call dein#add('peterhoeg/vim-qml',                  {'on_ft': ['qml']})
call dein#add('rhysd/vim-gfm-syntax',               {'on_ft': ['markdown']})
call dein#add('solarnz/thrift.vim',                 {'on_ft': ['thrift']})
call dein#add('kergoth/vim-bitbake',                {'on_ft': ['bitbake']})

call dein#end()
" }}}

filetype plugin indent on
syntax on
colorscheme Tomorrow-Night-Eighties

" Enable mouse support
set mouse=a

set colorcolumn=80

" Keep more info in memory to speed things up
set hidden

set nobackup        " no backup files
set nowritebackup   " only in case you don't want a backup file while editing
set noswapfile      " no swap files

" Have some logic when indenting
set nowrap
set tabstop=4
set shiftwidth=4
set expandtab
set smartindent
set diffopt=filler,vertical

" Folding options {{{
set foldmethod=marker
set foldcolumn=0
set foldlevel=0
" }}}
"
" Show matching parenthesis
set showmatch

" Set keymaps
set keymap=russian-jcuken
set iminsert=0
set imsearch=0

set completeopt=menu,noinsert,noselect

" Close a split window without resizing other windows
set noequalalways

" Show hidden special symbols
set list

" Mappings {{{

" Clear current search highlighting
nnoremap <silent><esc> :nohlsearch<cr>

" Buffers navigation
nnoremap <C-^> :b!#<CR>

" Convenient movements through quickfix window entries
nnoremap <c-n> :cn<cr>
nnoremap <c-p> :cp<cr>

" Automatically close matching pairs
inoremap { {}<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap ' ''<left>
inoremap " ""<left>

" Movements while typing
inoremap <c-l> <right>
inoremap <c-h> <left>
inoremap <c-j> <c-o>o
inoremap <c-k> <c-o>O
inoremap <c-e> <c-o>E<right>
inoremap <c-b> <c-o>B

" Center the screen while typing
function! SVCenterScreen()
    let cursorpos = getpos('.')
    return "\<esc>z.:call setpos('.', " . string(cursorpos) . ")\<cr>i"
endfunction
inoremap <c-z> <c-r>=SVCenterScreen()<cr>

" Change/delete paremeters
onoremap p i(

" Make
nnoremap <silent><leader>m :wa<cr>:make!<cr>
nnoremap <silent><leader>mc :make! clean<cr>

" Make it easier to edit .vimrc
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>r :source $MYVIMRC<cr>

" Exit to normal mode in terminal window
tnoremap <Esc> <C-\><C-n>

" Run a terminal
nnoremap <silent><leader>tr :silent terminal ++close bash<cr>

" Resize window in steps of 5
nnoremap <silent> <C-W>> :exe "vertical resize +5"<CR>
nnoremap <silent> <C-W>< :exe "vertical resize -5"<CR>
nnoremap <silent> <C-W>+ :exe "resize +5"<CR>
nnoremap <silent> <C-W>- :exe "resize -5"<CR>

" Maximize window
nnoremap <C-W>z <C-W>\| <C-W>_

" Help
nnoremap <silent> <leader>h :Man 3 <c-r>=expand('<cword>')<cr><cr>

" }}}

" Highligting settings {{{
highlight VertSplit guibg=bg ctermbg=bg
highlight lCursor guifg=NONE guibg=Cyan
" }}}

" File settings {{{

" C file settings {{{
augroup c_files
    autocmd!
    autocmd FileType c nnoremap <buffer> <leader>h :call CurtineIncSw()<cr>
    autocmd FileType c nnoremap <buffer> <leader>/ I/* <esc>A */<esc>
    autocmd FileType c vnoremap <buffer> <leader>/ <esc>`<I/* <esc>`>A */<esc>
    autocmd FileType c noremap <silent> <buffer> <leader>\ :s/\(\/\*\s\?\\|\s\?\*\/\)//g<cr>:noh<cr>
    autocmd FileType c setlocal syntax=c.doxygen
    autocmd FileType c set number
augroup END
" }}}

" Cxx file settings {{{

" Don't indent template
function! CppNoTemplateIndent()
    let l:cline_num = line('.')
    let l:cline = getline(l:cline_num)
    let l:pline_num = prevnonblank(l:cline_num - 1)
    let l:pline = getline(l:pline_num)
    if l:pline =~# '\s*template'
      return indent(l:pline_num)
    endif
    return cindent('.')
endfunction

augroup cxx_files
    autocmd!
    autocmd FileType cpp nnoremap <buffer> <leader>h :call CurtineIncSw()<cr>
    autocmd FileType cpp noremap <buffer> <leader>/ :s/\(^\s*\)/\1\/\/ /<cr>:noh<cr>
    autocmd FileType cpp noremap <silent> <buffer> <leader>\ :s/\(\s*\)\/\/\s*/\1/<cr>:noh<cr>
    autocmd FileType cpp set number
    autocmd FileType cpp setlocal syntax=cpp.doxygen
    autocmd FileType cpp setlocal indentexpr=CppNoTemplateIndent()
augroup END
" }}}

" Go file settings {{{
augroup go_files
    autocmd!
    autocmd FileType go noremap <buffer> <leader>/ :s/\(^\s*\)/\1\/\/ /<cr>:noh<cr>
    autocmd FileType go noremap <silent> <buffer> <leader>\ :s/\(\s*\)\/\/\s*/\1/<cr>:noh<cr>
    autocmd FileType go setlocal number
augroup END
" }}}

" Files with #-comments {{{
augroup hash_comments
    autocmd!
    autocmd FileType python,sh,cmake noremap <buffer> <leader>/ :s/^/#/<cr>:noh<cr>
    autocmd FileType python,sh,cmake noremap <silent> <buffer> <leader>\ :s/^#//<cr>:noh<cr>
augroup END
" }}}

" Vimscript file settings {{{
augroup vim_files
    autocmd!
    autocmd FileType vim noremap <buffer> <leader>/ :s/\(^\s*\)/\1" /<cr>:noh<cr>
    autocmd FileType vim noremap <silent> <buffer> <leader>\ :s/\(\s*\)"\s*/\1/<cr>:noh<cr>
    autocmd FileType vim inoremap <buffer> " "
augroup END
" }}}

" Markdown settings {{{

function! s:markdown_settings() abort
    setlocal textwidth=79
    setlocal formatoptions-=l
endfunction

augroup md_files
    autocmd!
    autocmd FileType markdown call s:markdown_settings()
augroup END

let g:markdown_fenced_languages = ['c', 'cpp', 'python', 'bash', 'qml', 'cmake']
" }}}

" QML settings {{{
augroup qml_files
    autocmd!
    autocmd FileType qml noremap <buffer> <leader>/ :s/\(^\s*\)/\1\/\/ /<cr>:noh<cr>
    autocmd FileType qml noremap <silent> <buffer> <leader>\ :s/\(\s*\)\/\/\s*/\1/<cr>:noh<cr>
    autocmd FileType qml setlocal nosmartindent
    autocmd FileType qml setlocal number
augroup END
" }}}

" plantuml settings {{{
augroup plantuml_files
    autocmd!
    autocmd FileType plantuml call s:plantuml_settings()
    autocmd FileType plantuml inoremap <buffer> ' '
    autocmd FileType plantuml inoremap <buffer> [ [
augroup END

function! s:plantuml_settings() abort
    nnoremap <silent><buffer> <leader>u :w<cr>:silent !plantuml -output /tmp %<cr>
    nnoremap <silent><buffer> <leader>v :silent !xdg-open /tmp/%:r.png &<cr>
endfunction
" }}}

" Remove trailing spaces {{{
augroup trailing_spaces
    autocmd!
    autocmd FileType c,cpp,python,sh,make,cmake,vim,plantuml
                \ autocmd BufWritePre <buffer> %s/\s\+$//e
augroup END
" }}}

" Make
nnoremap <silent><leader>m :wa<cr>:make!<cr>
nnoremap <silent><leader>mc :make! clean<cr>

" }}}

" Defx {{{

call defx#custom#column('icon', {
      \ 'directory_icon': '▸',
      \ 'opened_icon': '▾',
      \ 'root_icon': ' ',
      \ })

call defx#custom#column('filename', {
      \ 'min_width': 40,
      \ 'max_width': 40,
      \ })

call defx#custom#column('mark', {
      \ 'readonly_icon': '✗',
      \ 'selected_icon': '✓',
      \ })

function! s:defx_my_settings() abort
    " Define mappings
    nnoremap <silent><buffer><expr> <CR>      defx#do_action('open')
    nnoremap <silent><buffer><expr> c         defx#do_action('copy')
    nnoremap <silent><buffer><expr> m         defx#do_action('move')
    nnoremap <silent><buffer><expr> p         defx#do_action('paste')
    nnoremap <silent><buffer><expr> l         defx#do_action('open')
    nnoremap <silent><buffer><expr> t         defx#do_action('open_or_close_tree')
    "nnoremap <silent><buffer><expr> E         defx#do_action('open', 'vsplit')
    "nnoremap <silent><buffer><expr> P         defx#do_action('open', 'pedit')
    nnoremap <silent><buffer><expr> K         defx#do_action('new_directory')
    nnoremap <silent><buffer><expr> N         defx#do_action('new_file')
    nnoremap <silent><buffer><expr> M         defx#do_action('new_multiple_files')
    nnoremap <silent><buffer><expr> C         defx#do_action('toggle_columns', 'mark:filename:type:size:time')
    nnoremap <silent><buffer><expr> S         defx#do_action('toggle_sort', 'time')
    nnoremap <silent><buffer><expr> d         defx#do_action('remove')
    nnoremap <silent><buffer><expr> r         defx#do_action('rename')
    nnoremap <silent><buffer><expr> !         defx#do_action('execute_command')
    nnoremap <silent><buffer><expr> x         defx#do_action('execute_system')
    nnoremap <silent><buffer><expr> yy        defx#do_action('yank_path')
    nnoremap <silent><buffer><expr> .         defx#do_action('toggle_ignored_files')
    nnoremap <silent><buffer><expr> ;         defx#do_action('repeat')
    nnoremap <silent><buffer><expr> h         defx#do_action('cd', ['..'])
    nnoremap <silent><buffer><expr> ~         defx#do_action('cd')
    nnoremap <silent><buffer><expr> q         defx#do_action('quit')
    nnoremap <silent><buffer><expr> <Esc>     defx#do_action('quit')
    nnoremap <silent><buffer><expr> <Space>   defx#do_action('toggle_select') . 'j'
    nnoremap <silent><buffer><expr> *         defx#do_action('toggle_select_all')
    nnoremap <silent><buffer><expr> j         line('.') == line('$') ? 'gg' : 'j'
    nnoremap <silent><buffer><expr> k         line('.') == 1 ? 'G' : 'k'
    nnoremap <silent><buffer><expr> <C-l>     defx#do_action('redraw')
    nnoremap <silent><buffer><expr> <C-g>     defx#do_action('print')
    nnoremap <silent><buffer><expr> cd        defx#do_action('change_vim_cwd')
endfunction

augroup defx_config
    autocmd!
    autocmd FileType defx call s:defx_my_settings()
augroup END

nnoremap <silent> - :Defx `expand('%:p:h')` -search=`expand('%:p')`<cr>
nnoremap <silent> <leader>ex :Defx<cr>

" }}}

" Denite {{{
call denite#custom#option('_', { 'split': 'no' })

let search_cmd = $HOME . '/.config/nvim/bin/search'

" find
call denite#custom#var('file/rec', 'command', [ search_cmd ])

call denite#custom#alias('source', 'file/rec/git', 'file/rec')
call denite#custom#var('file/rec/git', 'command',
            \ ['git', 'ls-files', '-co', '--exclude-standard'])

" grep
call denite#custom#var('grep', {
            \ 'command': [ search_cmd ],
            \ 'default_opts': [],
            \ 'recursive_opts': [],
            \ 'pattern_opt': [],
            \ 'separator': [],
            \ })

call denite#custom#alias('source', 'grep/git', 'grep')
call denite#custom#var('grep/git', {
            \ 'command': [ 'git', 'grep' ],
            \ 'default_opts': [ '-ne' ],
            \ 'recursive_opts': [],
            \ 'pattern_opt': [],
            \ 'separator': [],
            \ })

augroup denite_config
    autocmd!
    autocmd FileType denite call s:denite_my_settings()
augroup END

function! s:denite_my_settings() abort
    " Define mappings
    nnoremap <silent><buffer><expr> <CR>    denite#do_map('do_action')
    nnoremap <silent><buffer><expr> d       denite#do_map('do_action', 'delete')
    nnoremap <silent><buffer><expr> p       denite#do_map('do_action', 'preview')
    nnoremap <silent><buffer><expr> q       denite#do_map('quit')
    nnoremap <silent><buffer><expr> i       denite#do_map('open_filter_buffer')
    nnoremap <silent><buffer><expr> <Space> denite#do_map('toggle_select').'j'
endfunction

if isdirectory(".git")
    nnoremap <silent><leader>f  : <C-u>Denite -buffer-name=files file/rec/git<cr>
    nnoremap <silent><leader>s  : <C-u>Denite -buffer-name=grep grep/git<cr>
    nnoremap <silent><leader>s* : <C-u>Denite -buffer-name=grep grep/git:::<C-r>=expand("<cword>").'\\W'<cr><cr>
else
    nnoremap <silent><leader>f  : <C-u>Denite -buffer-name=files file/rec<cr>
    nnoremap <silent><leader>s  : <C-u>Denite -buffer-name=grep grep<cr>
    nnoremap <silent><leader>s* : <C-u>Denite -buffer-name=grep grep:::<C-r>=expand("<cword>").'\\W'<cr><cr>
endif

nnoremap <silent><leader>l : <C-u>Denite -buffer-name=buffer buffer<cr>
nnoremap <silent><leader>. : <C-u>Denite -resume<cr>

" }}}

" bbye {{{
nnoremap <leader>bd :Bwipeout<CR>
nnoremap <leader>bc :Bdelete<CR>
" }}}

" Tagbar {{{
let tagbar_compact = 1
let tagbar_autoclose = 1
let tagbar_type_objc = {
    \ 'ctagstype': 'ObjectiveC',
    \ 'kinds' : [
        \'M:macros',
        \'t:types',
        \'s:structures',
        \'e:enumerations',
        \'i:interface',
        \'I:implementation',
        \'p:properties',
        \'m:methods',
        \'c:class methods',
        \'F:object fields',
        \'f:functions'
    \]
    \}

nnoremap <silent><leader>tb :TagbarToggle<CR>
" }}}

" vim-cpp-enhanced-highlight {{{
let c_no_curly_error=1
" }}}

" nvim-lspconfig {{{
lua << EOF

local nvim_lsp = require('lspconfig')

local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap=true, silent=true }
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<leader>ws', "<cmd>lua vim.ui.input({ prompt = 'Symbol: ' }, function(input) vim.lsp.buf.workspace_symbol(input) end)<CR>", opts)
    buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.get()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

    -- Set some keybinds conditional on server capabilities
    --if client.resolved_capabilities.document_formatting then
    --    buf_set_keymap('n', '<leader>i', "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    --elseif client.resolved_capabilities.document_range_formatting then
    --    b_uf_set_keymap('n', '<leader>i', "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
    --end

    -- Set autocommands conditional on server_capabilities
    if client.server_capabilities.document_highlight then
        vim.api.nvim_exec([[
        hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
        hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
        hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
        augroup lsp_document_highlight
            autocmd! * <buffer>
            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
        ]], false)
    end
end

-- Use a loop to conveniently both setup defined servers
-- and map buffer local keybindings when the language server attaches
local servers = { "clangd", "pyright", "gopls" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end

EOF

augroup nvim-lspconfig
    autocmd!
    autocmd FileType c,cpp,objc,objcpp,python,go inoremap <buffer> <C-Space> <C-x><C-o>
augroup END

" }}}

" plantuml {{{
let g:plantuml_set_makeprg = 0
" }}}

" }}}

" Load local config {{{
if filereadable("config.vim")
    source config.vim
endif
" }}}
