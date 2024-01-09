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

luafile <sfile>:p:h/config.lua
luafile <sfile>:p:h/mappings.lua
luafile <sfile>:p:h/autocmds.lua
luafile <sfile>:p:h/plugins.lua

" Load local config {{{
if filereadable("config.vim")
    source config.vim
endif
" }}}
