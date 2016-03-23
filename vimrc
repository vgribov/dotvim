set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'tomasr/molokai'
Plugin 'godlygeek/tabular'
Plugin 'vadimr/bclose.vim'
Plugin 'majutsushi/tagbar'
Plugin 'Valloric/YouCompleteMe'
Plugin 'will133/vim-dirdiff'
Plugin 'lambdalisue/vim-fullscreen'
Plugin 'vimwiki/vimwiki.git'
Plugin 'Shougo/unite.vim'
Plugin 'Shougo/vimproc.vim'
Plugin 'Shougo/vimfiler.vim'
Plugin 'tpope/vim-fugitive'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
filetype plugin on

set history=50		" keep 50 lines of command line history
set ruler		    " show the cursor position all the time
set showcmd		    " display incomplete commands
set incsearch		" do incremental searching
set nonumber
set nowrap
set smartindent
set expandtab
set hidden

" no folds closed when a buffer is opened is
set foldmethod=indent " Lines with equal indent form a fold
set foldcolumn=0      " Display column indicating open/closed folds
set foldlevel=99      " Default to no folds closed

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set backupdir=./.backup,.,/tmp
set directory=.,./.backup,/tmp

" Setup colorscheme
"set term=xterm-256color
set t_Co=256
let g:molokai_original = 1
colo molokai

" Always show the statusline
set laststatus=2

" Lazy screen redrawing when executing a script
set lz

" Set the codepages changing order
set ffs=unix,dos,mac
set fencs=utf-8,cp1251,koi8-r,ucs-2,cp866

" Set keymaps
set keymap=russian-jcuken
set iminsert=0
set imsearch=0
highlight lCursor guifg=NONE guibg=Cyan

" Use mouse where it's posible
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Convert file encoding
set wildmenu
set wcm=<TAB>
menu Encoding.utf-8 :e ++enc=utf8 <CR>
menu Encoding.windows-1251 :e ++enc=cp1251<CR>
menu Encoding.koi8-r :e ++enc=koi8-r<CR>
menu Encoding.cp866 :e ++enc=cp866<CR>
nmap <S-F8> :emenu Encoding.<TAB>

" Tabstops
set shiftwidth=4
set softtabstop=4
set tabstop=4

" File types
au FileType markdown,textile setlocal spell spelllang=ru_ru,en_us|setlocal linebreak
au BufRead,BufNewFile *.txt setlocal linebreak

let xml_use_xhtml = 1

" Buffers navigation
nmap <C-^> :b!#<CR>
nmap <leader>bd :Bclose<CR>
nmap <leader>bc :Bclose!<CR>
"nmap <C-h> :bp!<CR>
"nmap <C-l> :bn!<CR>

" Switching between source and header file
map <leader>oc :e %<.c<CR>
map <leader>oC :e %<.cpp<CR>
map <leader>oh :e %<.h<CR>

" lhs comments
map <leader># :s/^/#/<CR>:noh<CR>
map <leader>/ :s/^/\/\//<CR>:noh<CR>
map <leader>> :s/^/> /<CR>:noh<CR>
map <leader>" :s/^/\"/<CR>:noh<CR>
map <leader>% :s/^/%/<CR>:noh<CR>
map <leader>! :s/^/!/<CR>:noh<CR>
map <leader>; :s/^/;/<CR>:noh<CR>
map <leader>- :s/^/--/<CR>:noh<CR>
map <leader>c :s/^\/\/\\|^--\\|^> \\|^[#"%!;]//<CR>:noh<CR>

" wrapping comments
map <leader>* :s/^\(.*\)$/\/\* \1 \*\//<CR>:noh<CR>
map <leader>( :s/^\(.*\)$/\(\* \1 \*\)/<CR>:noh<CR>
map <leader>< :s/^\(.*\)$/<!-- \1 -->/<CR>:noh<CR>
map <leader>d :s/^\([/(]\*\\|<!--\) \(.*\) \(\*[/)]\\|-->\)$/\2/<CR>:noh<CR>

" automatically close matching pairs
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap ' ''<Left>
inoremap " ""<Left>

" Tagbar settings
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

nmap <silent><leader>tb :TagbarToggle<CR>

" Open NERDTree when vim starts up if no files were specified
"nmap <silent><leader>ex :NERDTreeToggle<CR>
"au StdinReadPre * let s:std_in=1
"au VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Close vim if the only window left open is a NERDTree
"au BufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

"let g:clang_library_path = "/usr/local/llvm/bin/cygclang.dll"
"let g:clang_snippets = 1
"let g:clang_snippets_engine = 'clang_complete'

" YouCompleteteMe
nmap <silent><leader>gt :YcmCompleter GoTo<cr>
nmap <silent><leader>gdf :YcmCompleter GoToDefinition<cr>
nmap <silent><leader>gdc :YcmCompleter GoToDeclaration<cr>
nmap <silent><leader>ty :YcmCompleter GetType<cr>
let g:ycm_min_num_of_chars_for_completion = 99
let g:ycm_auto_trigger = 0
let g:ycm_error_symbol = '✘'
let g:ycm_warning_symbol = '✗'
hi YcmErrorSign guibg=bg ctermbg=bg

set completeopt=menu,longest

" Consider all .redmine files as Redmine wiki files.
au BufNewFile,BufRead *.textile,*.redmine setlocal syntax=textile

" VimWiki configuration
let g:vimwiki_dir_link = 'index'

let vimwiki_path='$HOME/seva.grbv@gmail.com/vimwiki/'
let vimwiki_export_path='$HOME/seva.grbv@gmail.com/vimwiki/html/'
let wiki_settings={
    \ 'template_path': vimwiki_export_path.'vimwiki-assets/',
    \ 'template_default': 'default',
    \ 'template_ext': '.html',
    \ 'auto_export': 0,
    \ 'nested_syntaxes': { 'c': 'c', 'c++': 'cpp', 'sh': 'sh' }
\ }

let wikis=["personal"]
let g:vimwiki_list = []
for wiki_name in wikis
    let wiki=copy(wiki_settings)
    let wiki.path = vimwiki_path.wiki_name.'/'
    let wiki.path_html = vimwiki_export_path.wiki_name.'/'
    let wiki.diary_index = 'index'
    let wiki.diary_rel_path = 'diary/'
    call add(g:vimwiki_list, wiki)
endfor

" Make
nmap <silent><leader>m :wa<cr>:lmake!<cr>
nmap <silent><leader>mc :lmake! clean<cr>

" CtrlP
"let g:ctrlp_map = '<leader>f'
"nmap <leader>r :CtrlPRoot<CR>
"nmap <leader>l :CtrlPBuffer<CR>

" Find
"nmap <silent><leader>s :execute "Ack! ".expand("<cword>") <cr>

"set grepprg=~/.vim/pgrep\ -snw\ $*
"nmap <silent><leader>f :execute "lgrep! ".expand("<cword>")." '*.".expand("%:e")."'" <bar> lw<cr>

" Unite
let g:unite_source_history_yank_enable = 1
"call unite#filters#matcher_default#use(['matcher_fuzzy'])
nnoremap <leader>t :<C-u>Unite -no-split -buffer-name=files -start-insert file_rec/async:!<cr>
nnoremap <leader>f :<C-u>Unite -no-split -buffer-name=files -start-insert file<cr>
nnoremap <leader>y :<C-u>Unite -no-split -buffer-name=yank history/yank<cr>
nnoremap <leader>l :<C-u>Unite -no-split -buffer-name=buffer -quick-match buffer<cr>
nnoremap <leader>. :<C-u>UniteResume<cr>

" Unit find
nnoremap <leader>s :<C-u>UniteWithCursorWord -no-split -buffer-name=grep grep:.<cr>

" VimFiler
let g:vimfiler_as_default_explorer = 1

let g:vimfiler_tree_leaf_icon = ' '
let g:vimfiler_tree_opened_icon = '▾'
let g:vimfiler_tree_closed_icon = '▸'
let g:vimfiler_file_icon = '-'
let g:vimfiler_marked_file_icon = '*'

nmap <leader>ex :VimFiler -explorer<cr>

" Open a vimfiler buffer automatically when Vim starts up if no files were
" specified
autocmd VimEnter * if !argc() | VimFiler -explorer | endif

" Open NERDTree when vim starts up if no files were specified
"nmap <silent><leader>ex :NERDTreeToggle<CR>
"au StdinReadPre * let s:std_in=1
"au VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Close vim if the only window left open is a NERDTree
"au BufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

if filereadable(".vim.custom")
    so .vim.custom
endif

hi NonText guifg=bg ctermfg=bg
hi VertSplit guibg=bg ctermbg=bg

runtime! ftplugin/man.vim
