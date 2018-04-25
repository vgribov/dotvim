if has('gui_gtk2') || has('gui_gtk3')
  set guifont=Monospace\ 9
elseif has('win32') || has('win64')
  set guifont=Consolas:h9
else
  set guifont=Menlo:h11
endif

set guioptions-=T 
set guioptions-=m 
set guioptions-=L 
set guioptions-=r 
set guioptions-=e 
set lines=80 columns=150

set guicursor=n-v-c:block-blinkon0
set guicursor+=i:ver10-blinkon0
