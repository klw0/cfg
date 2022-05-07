let s:undo_configure_key = 'undo_lsp_configure_buffer'

" Configure the buffer with common LSP options and mappings.
function! lsp#ConfigureBuffer(client_capabilities) abort
  nnoremap <buffer><silent> gd :lua vim.lsp.buf.declaration()<CR>
  let b:[s:undo_configure_key] = '| silent! nunmap <buffer> gd'

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

  nnoremap <buffer><silent> <leader>rn :lua vim.lsp.buf.rename()<CR>
  let b:[s:undo_configure_key] .= '| silent! nunmap <buffer> <leader>rn'

  " autocmd CompleteChanged <buffer> call lsp#ShowCompleteSignature()

  setlocal tagfunc=v:lua.vim.lsp.tagfunc
  let b:[s:undo_configure_key] .= '| setlocal tagfunc<'

  if a:client_capabilities.completion
    setlocal omnifunc=v:lua.vim.lsp.omnifunc
    let b:[s:undo_configure_key] .= '| setlocal omnifunc<'
  endif

  if a:client_capabilities.document_formatting
    " Format on write.
    autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
    let b:[s:undo_configure_key] .= '| autocmd! BufWritePre <buffer>'
  endif

  let l:code_actions = []
  if type(a:client_capabilities.code_action) == v:t_dict
    let l:code_actions = get(a:client_capabilities.code_action, 'codeActionKinds', [])
  endif

  if match(l:code_actions, 'source.organizeImports') != -1
    autocmd BufWritePre <buffer> lua require('lsp').do_code_action_sync('source.organizeImports')
    let b:[s:undo_configure_key] .= '| autocmd! BufWritePre <buffer>'
  endif
endfunction

" Reverses configuration changes made by `lsp#ConfigureBuffer()`.
function! lsp#UnconfigureBuffer() abort
  if !has_key(b:, s:undo_configure_key) | return | endif

  execute b:[s:undo_configure_key]
  call remove(b:, s:undo_configure_key)
endfunction
