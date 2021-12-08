" stabusline: A status and tab line.

if exists('g:loaded_stabusline')
  finish
endif
let g:loaded_stabusline = v:true

augroup stabusline
  autocmd!
  autocmd WinEnter,BufEnter * setlocal statusline=%!stabusline#Statusline(v:true)
  autocmd WinLeave,BufLeave * setlocal statusline=%!stabusline#Statusline(v:false)
  autocmd FileType qf setlocal statusline=%!stabusline#Statusline(v:true)
augroup END

set tabline=%!stabusline#Tabline()
