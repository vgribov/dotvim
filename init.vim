set nocompatible
filetype off
syntax on

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

" YouCompleteteMe {{{
if filereadable(".ycm_extra_conf.py")
    Plugin 'Valloric/YouCompleteMe'
    nnoremap <silent> <localleader>yg :YcmCompleter GoToDefinition<cr>
    nnoremap <silent> <localleader>yd :YcmCompleter GoToDeclaration<cr>
    nnoremap <silent> <localleader>yt :YcmCompleter GetType<cr>
    let g:ycm_confirm_extra_conf = 0
    let g:ycm_min_num_of_chars_for_completion = 99
    let g:ycm_auto_trigger = 0
    let g:ycm_error_symbol = '✘'
    let g:ycm_warning_symbol = '✗'
    let g:ycm_key_invoke_completion = '<C-N>'
endif
" }}}

" Gtags {{{
Plugin 'vim-scripts/gtags.vim'
let g:Gtags_OpenQuickfixWindow = 0
nnoremap <silent> <localleader>gt :Gtags <C-R>=expand("<cword>")<cr><cr>
nnoremap <silent> <localleader>gr :Gtags -r <C-R>=expand("<cword>")<cr><cr>
" }}}

" vimporc {{{
Plugin 'Shougo/vimproc.vim'
" }}}

" Unite {{{
Plugin 'Shougo/unite.vim'

let g:unite_source_history_yank_enable = 1
"call unite#filters#matcher_default#use(['matcher_fuzzy'])
nnoremap <leader>f :<C-u>Unite -no-split -buffer-name=files -start-insert file_rec/async:!<cr>
nnoremap <leader>y :<C-u>Unite -no-split -buffer-name=yank history/yank<cr>
nnoremap <leader>l :<C-u>Unite -no-split -quick-match -buffer-name=buffer buffer<cr>
nnoremap <leader>. :<C-u>UniteResume<cr>
nnoremap <F3> :<C-u>Unite -no-split -buffer-name=grep grep:.:-iR<cr>
nnoremap <leader>s :<C-u>UniteWithCursorWord -no-split -buffer-name=grep grep:.:-iR<cr>
" }}}

" VimFiler {{{
Plugin 'Shougo/vimfiler.vim'

let g:vimfiler_as_default_explorer = 1

let g:vimfiler_tree_leaf_icon = ' '
let g:vimfiler_tree_opened_icon = '▾'
let g:vimfiler_tree_closed_icon = '▸'
let g:vimfiler_file_icon = '-'
let g:vimfiler_marked_file_icon = '*'

nnoremap <leader>ex :VimFiler<cr>
" }}}

" vim-fugitive {{{
Plugin 'tpope/vim-fugitive'
" }}}

" vim-man {{{
Plugin 'vim-utils/vim-man'
" }}}

" scratch {{{
Plugin 'mtth/scratch.vim'
" }}}

" lightline {{{
Plugin 'itchyny/lightline.vim'
" }}}

" vim-python-pep8-indent {{{
Plugin 'hynek/vim-python-pep8-indent'
" }}}

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

colorscheme Tomorrow-Night

" Enable mouse support
set mouse=a
set ttymouse=xterm2

set hlsearch
nohlsearch " Don't highlight last search when .vimrc reloaded

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

" C file settings {{{
augroup c_files
    autocmd!
    autocmd FileType c nnoremap <buffer> <localleader>/ I/* <esc>A */<esc>
    autocmd FileType c vnoremap <buffer> <localleader>/ <esc>`<I/* <esc>`>A */<esc>
    autocmd FileType c noremap <silent> <buffer> <localleader>\ :s/\(\/\*\s\?\\|\s\?\*\/\)//g<cr>:noh<cr>
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

" Misc functions {{{
function! EatSpace()
    let c = nr2char(getchar(0))
    return (c =~ '\s') ? '' : c
endfunc

function! InsertCode(abbr,str)
    let syn = synIDattr(synIDtrans(synID(line('.'), col('.') - 1, 1)), 'name')
    if syn ==? 'comment' || syn ==? 'string'
        return a:abbr
    else
        return a:str . "=EatSpace()"
    endif
endfunction
" }}}

if filereadable(".vim")
    so .vim
endif
