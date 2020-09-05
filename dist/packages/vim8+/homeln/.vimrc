"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SETTINGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if filereadable(expand("~/.vim/local/basic.vim"))
  source ~/.vim/local/basic.vim
endif

set shiftwidth=2
set tabstop=2
set number
color default
set background=dark
set foldcolumn=0
set statusline+=\ \ %P
" set mouse=a
" map <ScrollWheelUp> <C-Y>
" map <ScrollWheelDown> <C-E>

" NERDTree
" open NERDTree automatically when vim starts up
" autocmd vimenter * NERDTree
