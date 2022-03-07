if !has('nvim')
  finish
endif

if exists('g:loaded_diagnostic')
  finish
endif
let g:loaded_diagnostic = v:true

lua vim.diagnostic.config({ virtual_text = false })

augroup diagnostic
  autocmd!
  autocmd DiagnosticChanged * call diagnostic#Changed()

  if has('nvim')
    autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false, scope = "cursor" })
  endif
augroup END

highlight! link DiagnosticError Error
highlight! link DiagnosticWarn WarningMsg
highlight! link DiagnosticInfo WarningMsg
highlight! link DiagnosticHint WarningMsg

highlight! link DiagnosticFloatingError Normal
highlight! link DiagnosticFloatingWarn Normal
highlight! link DiagnosticFloatingInfo Normal
highlight! link DiagnosticFloatingHint Normal
