silent call lsp#ConfigureBuffer()

" Format on write.
autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()

let b:undo_ftplugin =
    \   '| silent call lsp#UnconfigureBuffer()'
    \ . '| autocmd! * <buffer>'
