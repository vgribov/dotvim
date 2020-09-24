let mapleader      = ' '
let maplocalleader = ','

" Plugins {{{

" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
    call dein#begin('~/.cache/dein')

    " Shougo
    call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
    call dein#add('Shougo/defx.nvim')
    call dein#add('Shougo/denite.nvim')
    call dein#add('Shougo/deoplete.nvim')
    call dein#add('deoplete-plugins/deoplete-jedi',     {'on_ft': ['python']})

    " Basic
    call dein#add('vadimr/bclose.vim',                  {'on_cmd': 'BClose'})
    call dein#add('majutsushi/tagbar')
    call dein#add('itchyny/lightline.vim')
    call dein#add('gcmt/taboo.vim',                     {'on_cmd': 'TabooOpen'})

    " Development
    call dein#add('tpope/vim-fugitive')
    call dein#add('octol/vim-cpp-enhanced-highlight',   {'on_ft': ['cpp']})
    call dein#add('vgribov/vim-rtags',                  {'on_ft': ['c', 'cpp']})
    call dein#add('hynek/vim-python-pep8-indent',       {'on_ft': ['python']})
    call dein#add('rhysd/vim-gfm-syntax',               {'on_ft': ['markdown']})
    call dein#add('peterhoeg/vim-qml',                  {'on_ft': ['qml']})
    call dein#add('solarnz/thrift.vim',                 {'on_ft': ['thrift']})
    call dein#add('aklt/plantuml-syntax',               {'on_ft': ['plantuml']})

    call dein#end()
    call dein#save_state()
endif
" }}}

filetype plugin indent on
syntax on
colorscheme Tomorrow-Night

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

" Mappings {{{

" Clear current search highlighting
nnoremap <silent><c-l> :nohlsearch<cr>

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
nnoremap <leader>sv :source $MYVIMRC<cr>

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
nnoremap <silent> <localleader>h :Man 3 <c-r>=expand('<cword>')<cr><cr>

" }}}

" Highligting settings {{{
highlight NonText guifg=bg ctermfg=bg
highlight VertSplit guibg=bg ctermbg=bg
highlight YcmErrorSign guibg=bg ctermbg=bg
highlight lCursor guifg=NONE guibg=Cyan
" }}}

" File settings {{{

" C file settings {{{
augroup c_files
    autocmd!
    autocmd FileType c nnoremap <buffer> <localleader>/ I/* <esc>A */<esc>
    autocmd FileType c vnoremap <buffer> <localleader>/ <esc>`<I/* <esc>`>A */<esc>
    autocmd FileType c noremap <silent> <buffer> <localleader>\ :s/\(\/\*\s\?\\|\s\?\*\/\)//g<cr>:noh<cr>
    autocmd FileType c setlocal syntax=c.doxygen
    autocmd FileType c setlocal number
augroup END
" }}}

" Cxx file settings {{{
augroup cxx_files
    autocmd!
    autocmd FileType cpp noremap <buffer> <localleader>/ :s/\(^\s*\)/\1\/\/ /<cr>:noh<cr>
    autocmd FileType cpp noremap <silent> <buffer> <localleader>\ :s/\(\s*\)\/\/\s*/\1/<cr>:noh<cr>
    autocmd FileType cpp setlocal syntax=cpp.doxygen
    autocmd FileType cpp setlocal number
augroup END
" }}}

" Files with #-comments {{{
augroup hash_comments
    autocmd!
    autocmd FileType python,sh,cmake noremap <buffer> <localleader>/ :s/^/#/<cr>:noh<cr>
    autocmd FileType python,sh,cmake noremap <silent> <buffer> <localleader>\ :s/^#//<cr>:noh<cr>
augroup END
" }}}

" Vimscript file settings {{{
augroup vim_files
    autocmd!
    autocmd FileType vim noremap <buffer> <localleader>/ :s/\(^\s*\)/\1" /<cr>:noh<cr>
    autocmd FileType vim noremap <silent> <buffer> <localleader>\ :s/\(\s*\)"\s*/\1/<cr>:noh<cr>
    autocmd FileType vim inoremap <buffer> " "
augroup END
" }}}

" Markdown settings {{{
augroup md_files
    autocmd!
    autocmd FileType markdown setlocal textwidth=79
    autocmd FileType markdown setlocal formatoptions-=l
augroup END
" }}}

" QML settings {{{
augroup qml_files
    autocmd!
    autocmd FileType qml noremap <buffer> <localleader>/ :s/\(^\s*\)/\1\/\/ /<cr>:noh<cr>
    autocmd FileType qml noremap <silent> <buffer> <localleader>\ :s/\(\s*\)\/\/\s*/\1/<cr>:noh<cr>
    autocmd FileType qml setlocal nosmartindent
    autocmd FileType qml setlocal number
augroup END
" }}}

" plantuml settings {{{
augroup qml_files
    autocmd!
    autocmd FileType plantuml call s:plantuml_settings()
    autocmd FileType plantuml inoremap <buffer> ' '
    autocmd FileType plantuml inoremap <buffer> [ [
augroup END

function! s:plantuml_settings() abort
    nnoremap <silent><buffer> <leader>u :w<cr>:silent !plantuml -output /tmp %<cr>
    nnoremap <silent><buffer> <leader>v :silent !xdg-open /tmp/%:r.png &<cr>
endfunction

" Make
nnoremap <silent><leader>m :wa<cr>:make!<cr>
nnoremap <silent><leader>mc :make! clean<cr>

" }}}

" }}}

" Plugins settings {{{

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
call denite#custom#option('_', { 'split': 'no', 'mode': 'normal' })

if executable('fd')
    call denite#custom#var('grep', 'command', ['fd', '', '-H', '-L', '-t', 'f', '-x', 'grep'])
    call denite#custom#var('grep', 'default_opts', ['-nH'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'separator', [';'])
endif

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

nnoremap <silent><leader>f :<C-u>Denite -split=no -buffer-name=files file/rec<cr>
nnoremap <silent><leader>l :<C-u>Denite -split=no -buffer-name=buffer buffer<cr>
nnoremap <silent><F3> :<C-u>Denite -split=no -buffer-name=grep grep<cr>
nnoremap <silent><leader>s :<C-u>Denite -split=no -buffer-name=grep grep::-nH:<C-r>=expand("<cword>")<cr><cr>
nnoremap <silent><leader>. :<C-u>Denite -resume<cr>
" }}}

" Deoplete {{{

" Enable on startup
call deoplete#enable()

" Set a single option
call deoplete#custom#option('auto_complete_delay', 200)

" Pass a dictionary to set multiple options
call deoplete#custom#option({
    \ 'auto_complete': v:true,
    \ 'auto_complete_delay': 500,
    \ 'smart_case': v:true,
    \ })
" }}}

" Bclose {{{
nnoremap <leader>bd :Bclose<CR>
nnoremap <leader>bc :Bclose!<CR>
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

" vim-gfm-syntax {{{
let g:markdown_fenced_languages = ['c', 'cpp', 'python', 'vim']
" }}}

" vim-cpp-enhanced-highlight {{{
let c_no_curly_error=1
" }}}

" vim-rtags {{{
augroup vim_rtags
    autocmd!
    autocmd FileType c,cpp setlocal completefunc=RtagsCompleteFunc
    autocmd FileType c,cpp inoremap <buffer> <C-Space> <C-x><C-u>
augroup END
" }}}

" plantuml {{{
let g:plantuml_set_makeprg = 0
" }}}

" }}}

" Load .vim {{{
if filereadable("vimrc")
    source vimrc
endif
" }}}
