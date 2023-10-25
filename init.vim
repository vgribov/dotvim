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
call dein#add('aklt/plantuml-syntax')
call dein#add('peterhoeg/vim-qml')
call dein#add('rhysd/vim-gfm-syntax')
call dein#add('solarnz/thrift.vim')
call dein#add('kergoth/vim-bitbake')

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
set diffopt=filler,vertical

" Folding options {{{
set foldmethod=marker
set foldcolumn=0
set foldlevel=0
" }}}

" Automatically insert current comment leaders
set formatoptions+=ro

" Show matching parenthesis
set showmatch

" Set keymaps
set keymap=russian-jcuken
set iminsert=0
set imsearch=0

set completeopt=menu,noinsert,noselect

" Close a split window without resizing other windows
set noequalalways

" Show indention guides
set listchars=tab:\|\ 
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
    autocmd FileType go inoremap <buffer> ` ``<left>
    autocmd FileType go noremap <buffer> <leader>/ :s/\(^\s*\)/\1\/\/ /<cr>:noh<cr>
    autocmd FileType go noremap <silent> <buffer> <leader>\ :s/\(\s*\)\/\/\s*/\1/<cr>:noh<cr>
    autocmd FileType go setlocal number
    autocmd FileType go setlocal noexpandtab
    autocmd FileType go setlocal colorcolumn=120

    autocmd BufWritePre *.go lua vim.lsp.buf.format()
augroup END
" }}}

" Files with #-comments {{{
augroup hash_comments
    autocmd!
    autocmd FileType perl,python,sh,cmake noremap <buffer> <leader>/ :s/^/#/<cr>:noh<cr>
    autocmd FileType perl,python,sh,cmake noremap <silent> <buffer> <leader>\ :s/^#//<cr>:noh<cr>
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
let g:plantuml_set_makeprg = 0

augroup plantuml_files
    autocmd!
    autocmd FileType plantuml call s:plantuml_settings()
    autocmd FileType plantuml inoremap <buffer> ' '
    autocmd FileType plantuml inoremap <buffer> [ [
augroup END

function! s:plantuml_settings() abort
    if has("mac")
        let l:open_cmd = "open"
    else
        let l:open_cmd = "xdg-open"
    endif

    exec 'nnoremap <silent><buffer> <leader>v'
        \ . ' :w<cr>:silent'
        \ . ' !plantuml -output /tmp % && '
        \ . l:open_cmd . ' /tmp/%:t:r.png &<cr>'
endfunction
" }}}

" Remove trailing spaces {{{
augroup trailing_spaces
    autocmd!
    autocmd FileType c,cpp,perl,python,sh,make,cmake,plantuml
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
augroup nvim-lspconfig
    autocmd!
    autocmd FileType c,cpp,objc,objcpp,python,go inoremap <buffer> <C-Space> <C-x><C-o>
augroup END

luafile <sfile>:p:h/lsp.lua
" }}}

" }}}

" Load local config {{{
if filereadable("config.vim")
    source config.vim
endif
" }}}
