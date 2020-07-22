let s:undo_configure_key = 'undo_lsp_configure_buffer'

" Configure the buffer with common LSP options and mappings.
function! lsp#ConfigureBuffer() abort
    setlocal omnifunc=v:lua.vim.lsp.omnifunc
    let b:[s:undo_configure_key] = '| setlocal omnifunc<'

    nnoremap <buffer><silent> gd :lua vim.lsp.buf.declaration()<CR>
    let b:[s:undo_configure_key] .= '| silent! nunmap <buffer> gd'

    nnoremap <buffer><silent> <C-]> :lua vim.lsp.buf.definition()<CR>
    let b:[s:undo_configure_key] .= '| silent! nunmap <buffer> <C-]>'

    nnoremap <buffer><silent> K :lua vim.lsp.buf.hover()<CR>
    let b:[s:undo_configure_key] .= '| silent! nunmap <buffer> K'

    nnoremap <buffer><silent> gD :lua vim.lsp.buf.implementation()<CR>
    let b:[s:undo_configure_key] .= '| silent! nunmap <buffer> gD'

    nnoremap <buffer><silent> <C-K> :lua vim.lsp.buf.signature_help()<CR>
    let b:[s:undo_configure_key] .= '| silent! nunmap <buffer> <C-K>'

    nnoremap <buffer><silent> 1gD :lua vim.lsp.buf.type_definition()<CR>
    let b:[s:undo_configure_key] .= '| silent! nunmap <buffer> 1gD'

    nnoremap <buffer><silent> gr :lua vim.lsp.buf.references()<CR>
    let b:[s:undo_configure_key] .= '| silent! nunmap <buffer> gr'

    nnoremap <buffer><silent> g0 :lua vim.lsp.buf.document_symbol()<CR>
    let b:[s:undo_configure_key] .= '| silent! nunmap <buffer> g0'

    nnoremap <buffer><silent> rn :lua vim.lsp.buf.rename()<CR>
    let b:[s:undo_configure_key] .= '| silent! nunmap <buffer> rn'

    autocmd CursorMoved,CursorHold <buffer> lua vim.lsp.util.show_line_diagnostics()
    let b:[s:undo_configure_key] .= '| autocmd! CursorMoved,CursorHold <buffer>'
endfunction

" Reverses configuration changes made by `lsp#ConfigureBuffer()`.
function! lsp#UnconfigureBuffer() abort
    if !has_key(b:, s:undo_configure_key) | return | endif

    execute b:[s:undo_configure_key]
    call remove(b:, s:undo_configure_key)
endfunction
