setlocal cindent
setlocal foldmethod=syntax
setlocal foldcolumn=0
setlocal syntax=c.doxygen
setlocal number
setlocal shiftround

inoreabbrev <buffer> <expr> if 
            \InsertCode("if", "if () {<cr>} <esc>-f(a") 

inoreabbrev <buffer> <expr> elsif 
            \InsertCode("elsif", "else if () {<cr>} <esc>-f(a") 

inoreabbrev <buffer> <expr> else 
            \InsertCode("else", "else {<cr>} <esc>O") 

inoreabbrev <buffer> <expr> for 
            \InsertCode("for", "for () {<cr>} <esc>-f(a") 

inoreabbrev <buffer> <expr> while 
            \InsertCode("while", "while () {<cr>} <esc>-f(a") 

inoreabbrev <buffer> <expr> switch 
            \InsertCode("switch", "switch () {<cr>} <esc>-f(a") 
