silent call lsp#ConfigureBuffer()
let b:undo_ftplugin = '| silent call lsp#UnconfigureBuffer()'

" Remove mappings that are better handled by vim than vim-language-server.
nunmap <buffer> K
nunmap <buffer> gD
nunmap <buffer> 1gD

setlocal formatoptions-=o
let b:undo_ftplugin .= '| setlocal formatoptions<'
