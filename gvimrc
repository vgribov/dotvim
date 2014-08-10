if has('gui_gtk2')
  set guifont=Inconsolata\ LGC\ 9
elseif has('win32') || has('win64')
  set guifont=Consolas:h9
else
  set guifont=Menlo:h11
endif

set guioptions-=T 
set guioptions-=m 
set guioptions-=L 
set guioptions-=r 
set lines=999 columns=150
