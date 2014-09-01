" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

set history=50		" keep 50 lines of command line history
set ruler		    " show the cursor position all the time
set showcmd		    " display incomplete commands
set incsearch		" do incremental searching
set nocompatible
set number
set nowrap
set smartindent
set expandtab
set hidden

" no folds closed when a buffer is opened is
set foldlevelstart=99

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif

" Setup colorscheme
" let g:molokai_original = 1
colo molokai
hi NonText guifg=bg

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
filetype plugin on

" Buffers navigation
nmap <C-^> :b!#<CR>
nmap <C-h> :bp!<CR>
nmap <C-l> :bn!<CR>
nmap <leader>bd :bp<bar>sp<bar>bn<bar>bd<CR>

" Quickfix navigation
nmap <leader>cn :cnext<CR>
nmap <leader>cp :cprevious<CR>
"set makeprg=makepp

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

" Mappings
nmap <silent><leader>ex :NERDTreeToggle<CR>
nmap <silent><leader>tb :TagbarToggle<CR>

" Open NERDTree when vim starts up if no files were specified
au StdinReadPre * let s:std_in=1
au VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Close vim if the only window left open is a NERDTree
au BufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Building the Ctags database
map <silent><leader>tg :wa<CR>:!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q --languages=C,C++,ObjectiveC<CR>

" Make
map <silent><leader>m :wa<CR>:make!<CR>
map <silent><leader>mc :make! clean<CR>

if filereadable(".vim.custom")
    so .vim.custom
endif
