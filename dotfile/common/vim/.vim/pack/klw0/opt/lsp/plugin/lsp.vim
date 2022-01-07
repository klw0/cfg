if !has('nvim')
  finish
endif

if exists('g:loaded_lsp')
  finish
endif
let g:loaded_lsp = v:true

lua vim.diagnostic.config({ virtual_text = false })

augroup lsp
  autocmd!
  autocmd DiagnosticChanged * call s:DiagnosticChanged()
augroup END

function! s:DiagnosticChanged() abort
lua << EOF
vim.diagnostic.setloclist({ open = false })

if #vim.diagnostic.get(0) == 0 then
  vim.api.nvim_command('lclose')
end
EOF
endfunction

highlight! link DiagnosticError Error
highlight! link DiagnosticWarn WarningMsg
highlight! link DiagnosticInfo WarningMsg
highlight! link DiagnosticHint WarningMsg

highlight! link DiagnosticFloatingError Normal
highlight! link DiagnosticFloatingWarn Normal
highlight! link DiagnosticFloatingInfo Normal
highlight! link DiagnosticFloatingHint Normal
