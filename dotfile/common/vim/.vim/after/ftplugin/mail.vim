silent call write#Enable()
setlocal textwidth=72
setlocal formatoptions+=aw
setlocal listchars-=trail:.

let b:undo_ftplugin =
  \   '| silent call write#Disable()'
  \ . '| setlocal formatoptions<'
  \ . '| setlocal textwidth<'
  \ . '| setlocal listchars<'
