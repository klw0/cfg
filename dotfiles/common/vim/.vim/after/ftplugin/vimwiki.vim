silent call write#Enable()
setlocal textwidth=80

let b:undo_ftplugin =
    \   '| silent call write#Disable()'
    \ . '| setlocal textwidth<'
