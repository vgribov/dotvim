set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'godlygeek/tabular'
Plugin 'vadimr/bclose.vim'
Plugin 'majutsushi/tagbar'
Plugin 'Valloric/YouCompleteMe'
Plugin 'Shougo/unite.vim'
Plugin 'Shougo/vimproc.vim'
Plugin 'Shougo/vimfiler.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-utils/vim-man'
Plugin 'mtth/scratch.vim'
Plugin 'itchyny/lightline.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
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

syntax on
colorscheme Tomorrow-Night

" Enable mouse support
set mouse=a
set ttymouse=xterm2

set hlsearch

set colorcolumn=80

" Keep more info in memory to speed things up
set hidden
set history=100

" Have some logic when indenting
filetype indent on
set nowrap
set tabstop=4
set shiftwidth=4
set expandtab
set smartindent
set autoindent
set showcmd		    " display incomplete commands
set incsearch		" do incremental searching

set diffopt=filler,vertical

" no folds closed when a buffer is opened is
set foldmethod=indent " Lines with equal indent form a fold
set foldcolumn=0      " Display column indicating open/closed folds
set foldlevel=99      " Default to no folds closed

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
highlight lCursor guifg=NONE guibg=Cyan

" Buffers navigation
nnoremap <C-^> :b!#<CR>
nnoremap <leader>bd :Bclose<CR>
nnoremap <leader>bc :Bclose!<CR>

" LHS comments
nnoremap <leader># :s/^/#/<CR>:noh<CR>
nnoremap <leader>/ :s/^/\/\//<CR>:noh<CR>
nnoremap <leader>> :s/^/> /<CR>:noh<CR>
nnoremap <leader>" :s/^/\"/<CR>:noh<CR>
nnoremap <leader>% :s/^/%/<CR>:noh<CR>
nnoremap <leader>! :s/^/!/<CR>:noh<CR>
nnoremap <leader>; :s/^/;/<CR>:noh<CR>
nnoremap <leader>- :s/^/--/<CR>:noh<CR>
nnoremap <leader>\ :s/^\/\/\\|^--\\|^> \\|^[#"%!;]//<CR>:noh<CR>

" Wrapping comments
nnoremap <leader>* :s/^\(.*\)$/\/\* \1 \*\//<CR>:noh<CR>
nnoremap <leader>( :s/^\(.*\)$/\(\* \1 \*\)/<CR>:noh<CR>
nnoremap <leader>< :s/^\(.*\)$/<!-- \1 -->/<CR>:noh<CR>
nnoremap <leader>d :s/^\([/(]\*\\|<!--\) \(.*\) \(\*[/)]\\|-->\)$/\2/<CR>:noh<CR>

" Automatically close matching pairs
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

nnoremap <silent><leader>tb :TagbarToggle<CR>

" YouCompleteteMe
nnoremap <silent><leader>gt :YcmCompleter GoTo<cr>
nnoremap <silent><leader>yg :YcmCompleter GoToDefinition<cr>
nnoremap <silent><leader>yd :YcmCompleter GoToDeclaration<cr>
nnoremap <silent><leader>yt :YcmCompleter GetType<cr>
let g:ycm_confirm_extra_conf = 0
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
let g:vimwiki_table_auto_fmt = 0

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
nnoremap <silent><leader>m :wa<cr>:make!<cr>
nnoremap <silent><leader>mc :make! clean<cr>

" Change dir to a current file
nnoremap <leader>cd :cd %:p:h<cr>:pwd<cr>

" Unite
let g:unite_source_history_yank_enable = 1
"call unite#filters#matcher_default#use(['matcher_fuzzy'])
nnoremap <leader>f :<C-u>Unite -no-split -buffer-name=files -start-insert file_rec/async:!<cr>
nnoremap <leader>y :<C-u>Unite -no-split -buffer-name=yank history/yank<cr>
nnoremap <leader>l :<C-u>Unite -no-split -buffer-name=buffer buffer<cr>
nnoremap <leader>. :<C-u>UniteResume<cr>

" Unit find
nnoremap <F3> :<C-u>Unite -no-split -buffer-name=grep grep:.:-iR<cr>
nnoremap <leader>s :<C-u>UniteWithCursorWord -no-split -buffer-name=grep grep:.:-iR<cr>

" VimFiler
let g:vimfiler_as_default_explorer = 1

let g:vimfiler_tree_leaf_icon = ' '
let g:vimfiler_tree_opened_icon = '▾'
let g:vimfiler_tree_closed_icon = '▸'
let g:vimfiler_file_icon = '-'
let g:vimfiler_marked_file_icon = '*'

nnoremap <leader>ex :VimFiler -explorer<cr>

" Bash syntax by default
let g:is_bash=1

" Bash syntax by default
let g:is_bash=1

" Cscope
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

if filereadable(".vim")
    so .vim
endif

hi NonText guifg=bg ctermfg=bg
hi VertSplit guibg=bg ctermbg=bg
