set nobuflisted

" Inspired by Ack.vim and qf-vim.
nnoremap <buffer> <silent> t <C-w><CR><C-w>T
nnoremap <buffer> <silent> s <C-w><CR>
nnoremap <buffer> <silent> v <C-w><CR><C-w>L<C-w>p<C-w>J<C-w>p
nnoremap <buffer> <silent> o <CR><C-w>p

let b:undo_ftplugin .=
  \   '| nunmap <buffer> t'
  \ . '| nunmap <buffer> s'
  \ . '| nunmap <buffer> v'
  \ . '| nunmap <buffer> o'
