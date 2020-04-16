silent call lsp#ConfigureBuffer()

" TODO(klw0): This doesn't work as desired since LSP interaction is async, so
" an additional write is necessary. Revisit once
" `textDocument/willSaveWaitUntil` is implemented in the built-in LSP.
" Reference: https://github.com/neovim/neovim/blob/6fcab7e758f3826b94ab369452b71d15a67c8b36/runtime/lua/vim/lsp/protocol.lua#L617-L618
" Format on write.
autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting()

let b:undo_ftplugin =
    \   '| silent call lsp#UnconfigureBuffer()'
    \ . '| autocmd! * <buffer>'
