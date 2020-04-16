silent call lsp#ConfigureBuffer()

" Remove mappings that are better handled by vim than vim-language-server.
nunmap <buffer> K
nunmap <buffer> gD
nunmap <buffer> 1gD

let b:undo_ftplugin = '| silent call lsp#UnconfigureBuffer()'
