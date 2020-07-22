if exists('g:loaded_lsp')
    finish
endif
let g:loaded_lsp = v:true

" TODO(klw0): Hacky, but currently there is no option to disable virtual text.
lua vim.lsp.util.buf_diagnostics_virtual_text = function() end

augroup lsp
  autocmd!
  autocmd User LspDiagnosticsChanged lua require('lsp').show_buffer_diagnostics()
augroup END

highlight! link LspDiagnosticsError Error
highlight! link LspDiagnosticsWarning WarningMsg
highlight! link LspDiagnosticsInformation WarningMsg
highlight! link LspDiagnosticsHint WarningMsg

highlight! link LspDiagnosticsUnderlineError SpellBad
highlight! link LspDiagnosticsUnderlineWarning SpellBad
highlight! link LspDiagnosticsUnderlineHint SpellBad
highlight! link LspDiagnosticsUnderlineInformation SpellBad
