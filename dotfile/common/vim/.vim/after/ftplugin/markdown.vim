silent call write#Enable()
setlocal textwidth=80
setlocal foldenable

nnoremap <buffer> < zc
nnoremap <buffer> > zO

let b:undo_ftplugin =
  \   '| silent call write#Disable()'
  \ . '| setlocal textwidth<'
  \ . '| setlocal foldenable<'
  \ . '| nunmap <buffer> <'
  \ . '| nunmap <buffer> >'
