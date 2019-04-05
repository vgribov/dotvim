set nocompatible
filetype off

" Plugins {{{
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" tabular {{{
Plugin 'godlygeek/tabular'
" }}}

" Bclose {{{
Plugin 'vadimr/bclose.vim'

nnoremap <leader>bd :Bclose<CR>
nnoremap <leader>bc :Bclose!<CR>
" }}}

" Tagbar {{{
Plugin 'majutsushi/tagbar'

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

" Denite {{{
Plugin 'Shougo/denite.nvim'

nnoremap <silent><leader>f :<C-u>Denite -split=no -buffer-name=files file/rec<cr>
nnoremap <silent><leader>l :<C-u>Denite -split=no -mode=normal -buffer-name=buffer buffer<cr>
nnoremap <silent><F3> :<C-u>Denite -split=no -buffer-name=grep grep<cr>
nnoremap <silent><leader>s :<C-u>Denite -split=no -buffer-name=grep grep::-nH:<C-r>=expand("<cword>")<cr><cr>
nnoremap <silent><leader>. :<C-u>Denite -resume<cr>
" }}}

" vim-fugitive {{{
Plugin 'tpope/vim-fugitive'
" }}}

" vim-man {{{
if !has('nvim')
    Plugin 'vim-utils/vim-man'
endif
nnoremap <silent> <localleader>h :Man 3 <c-r>=expand('<cword>')<cr><cr>
" }}}

" scratch {{{
Plugin 'mtth/scratch.vim'
let g:scratch_insert_autohide = 0
" }}}

" lightline {{{
Plugin 'itchyny/lightline.vim'
" }}}

" vim-python-pep8-indent {{{
Plugin 'hynek/vim-python-pep8-indent'
" }}}

" vim-gfm-syntax {{{
Plugin 'rhysd/vim-gfm-syntax'
let g:markdown_fenced_languages = ['c', 'cpp', 'python', 'vim']
" }}}

" vim-cpp-enhanced-highlight {{{
Plugin 'octol/vim-cpp-enhanced-highlight'
let c_no_curly_error=1
" }}}

" vim-rtags {{{
Plugin 'vgribov/vim-rtags'
augroup vim_rtags
    autocmd!
    autocmd FileType c,cpp setlocal completefunc=RtagsCompleteFunc
    nnoremap <leader>rl :<C-u>Unite -no-split -quick-match -buffer-name=projects rtags/project<cr>
augroup END
" }}}

" taboo {{{
Plugin 'gcmt/taboo.vim'
" }}}

" vim-togglecursor {{{
Plugin 'jszakmeister/vim-togglecursor'
" }}}

" vim-qml {{{
Plugin 'peterhoeg/vim-qml'
" }}}

" supertab {{{
Plugin 'ervandew/supertab'
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-n>"
" }}}

" vim-wordmotion {{{
Plugin 'chaoren/vim-wordmotion'
let g:wordmotion_prefix = '<Leader>'
" }}}

Plugin 'tpope/vim-vinegar'

nnoremap <silent> <leader>ex :Explore .<cr>
let g:netrw_banner = 0

autocmd FileType netrw call s:netrw_mappings()
function! s:netrw_mappings() abort
    nmap <silent><buffer> l <cr>
    nmap <silent><buffer> h -
    nmap <silent><buffer> q :Bclose<cr>
    nmap <silent><buffer> <esc> :Bclose<cr>
endfunction

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on   " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
" }}}

set t_Co=256
syntax on
colorscheme Tomorrow-Night

" Enable mouse support
set mouse=a

if !has('nvim')
    set ttymouse=xterm2
endif

set hlsearch
nohlsearch " Don't highlight last search when .vimrc reloaded

set colorcolumn=80

" Keep more info in memory to speed things up
set hidden
set history=100

set nobackup       " no backup files
set nowritebackup  " only in case you don't want a backup file while editing
set noswapfile     " no swap files

" Have some logic when indenting
set nowrap
set tabstop=4
set shiftwidth=4
set expandtab
set smartindent
set autoindent
set showcmd		    " display incomplete commands
set incsearch		" do incremental searching

set diffopt=filler,vertical
set belloff=all     " disable beeping

" Folding options {{{
set foldmethod=marker
set foldcolumn=0
set foldlevel=0
" }}}

" Show matching parenthesis
set showmatch

" Always show the statusline
set laststatus=2

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set backupdir=./.backup,.,/tmp
set directory=.,./.backup,/tmp

" Set the codepages changing order
set ffs=unix,dos,mac
set fencs=utf-8,cp1251,koi8-r,ucs-2,cp866

" Set keymaps
set keymap=russian-jcuken
set iminsert=0
set imsearch=0

set completeopt=menu,longest

let maplocalleader=","

" C file settings {{{
augroup c_files
    autocmd!
    autocmd FileType c nnoremap <buffer> <localleader>/ I/* <esc>A */<esc>
    autocmd FileType c vnoremap <buffer> <localleader>/ <esc>`<I/* <esc>`>A */<esc>
    autocmd FileType c noremap <silent> <buffer> <localleader>\ :s/\(\/\*\s\?\\|\s\?\*\/\)//g<cr>:noh<cr>
    autocmd FileType c setlocal syntax=c.doxygen
augroup END
" }}}

" Cxx file settings {{{
augroup cxx_files
    autocmd!
    autocmd FileType cpp noremap <buffer> <localleader>/ :s/\(^\s*\)/\1\/\/ /<cr>:noh<cr>
    autocmd FileType cpp noremap <silent> <buffer> <localleader>\ :s/\(\s*\)\/\/\s*/\1/<cr>:noh<cr>
    autocmd FileType cpp setlocal syntax=cpp.doxygen
augroup END
" }}}

" Python file settings {{{
augroup py_files
    autocmd!
    autocmd FileType python noremap <buffer> <localleader>/ :s/\(^\s*\)/\1# /<cr>:noh<cr>
    autocmd FileType python noremap <silent> <buffer> <localleader>\ :s/\(\s*\)#\s*/\1/<cr>:noh<cr>
augroup END
" }}}

" sh file settings {{{
augroup sh_files
    autocmd!
    autocmd FileType sh noremap <buffer> <localleader>/ :s/\(^\s*\)/\1# /<cr>:noh<cr>
    autocmd FileType sh noremap <silent> <buffer> <localleader>\ :s/\(\s*\)#\s*/\1/<cr>:noh<cr>
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
    autocmd FileType markdown setlocal spell spelllang=en,ru,fr
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

" Custom syntax settings {{{
augroup syntax
    autocmd!
    " Consider all .redmine files as Redmine wiki files.
    autocmd BufNewFile,BufRead *.textile,*.redmine setlocal syntax=textile
augroup END
" Bash syntax by default
let g:is_bash=1
" }}}

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

" Change dir to a current file
nnoremap <leader>cd :cd %:p:h<cr>:pwd<cr>

" Make it easier to edit .vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Exit to normal mode in terminal window
tnoremap <Esc> <C-\><C-n>

" Run a terminal
nnoremap <silent><leader>tr :silent terminal ++close bash<cr>

" }}}

" Cscope settings {{{
if has('cscope')
    "" Use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    set cscopetag

    if has('quickfix')
        set cscopequickfix=s-,c-,d-,i-,t-,e-
    endif

    " Check cscope for definition of a symbol before checking ctags: set to 1
    " if you want the reverse search order.
    set csto=0

    " show msg when any other cscope db added
    set cscopeverbose

    " To do the first type of search, hit 'CTRL-\', followed by one of the
    " cscope search types above (s,g,c,t,e,f,i,d).
    "
    nnoremap <C-\>s :lcs find s <C-R>=expand("<cword>")<CR><CR>
    nnoremap <C-\>g :lcs find g <C-R>=expand("<cword>")<CR><CR>
    nnoremap <C-\>c :lcs find c <C-R>=expand("<cword>")<CR><CR>
    nnoremap <C-\>t :lcs find t <C-R>=expand("<cword>")<CR><CR>
    nnoremap <C-\>e :lcs find e <C-R>=expand("<cword>")<CR><CR>
    nnoremap <C-\>f :lcs find f <C-R>=expand("<cfile>")<CR><CR>
    nnoremap <C-\>i :lcs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nnoremap <C-\>d :lcs find d <C-R>=expand("<cword>")<CR><CR>

    function! CScopeSearch()
        call inputsave()
        let keyword = input('Search for: ')
        call inputrestore()
        execute 'cs find g' keyword
    endfunction
    nnoremap <silent><leader>cs :call CScopeSearch()<cr>
endif
" }}}

" Highligting settings {{{
highlight NonText guifg=bg ctermfg=bg
highlight VertSplit guibg=bg ctermbg=bg
highlight YcmErrorSign guibg=bg ctermbg=bg
highlight lCursor guifg=NONE guibg=Cyan
" }}}

" Eliminating delays on ESC in vim and tmux {{{
set timeoutlen=1000 ttimeoutlen=0
" }}}

" Denite settings {{{
call denite#custom#option('_', { 'split': 'no', 'mode': 'normal' })

if executable('fd')
    call denite#custom#var('grep', 'command', ['fd', '', '-L', '-t', 'f', '-x', 'grep'])
    call denite#custom#var('grep', 'default_opts', ['-nH'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'separator', [';'])
endif
" }}}

" Load .vim {{{
if filereadable(".vim")
    source .vim
endif
" }}}
