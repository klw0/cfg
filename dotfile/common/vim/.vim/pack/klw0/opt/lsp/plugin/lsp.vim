if exists('g:loaded_lsp')
  finish
endif
let g:loaded_lsp = v:true

lua require('lsp').init()

augroup lsp
  autocmd!
  autocmd User LspDiagnosticsChanged lua require('lsp').show_buffer_diagnostics()
augroup END

highlight! link LspDiagnosticsDefaultError Error
highlight! link LspDiagnosticsDefaultWarning WarningMsg
highlight! link LspDiagnosticsDefaultInformation WarningMsg
highlight! link LspDiagnosticsDefaultHint WarningMsg

highlight! link LspDiagnosticsUnderlineError SpellBad
highlight! link LspDiagnosticsUnderlineWarning SpellBad
highlight! link LspDiagnosticsUnderlineHint SpellBad
highlight! link LspDiagnosticsUnderlineInformation SpellBad
