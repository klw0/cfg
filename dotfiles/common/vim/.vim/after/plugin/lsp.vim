if exists('g:loaded_lsp')
    finish
endif
let g:loaded_lsp = v:true


highlight! link LspDiagnosticsError Error
highlight! link LspDiagnosticsWarning WarningMsg
highlight! link LspDiagnosticsInformation WarningMsg
highlight! link LspDiagnosticsHint WarningMsg

highlight! link LspDiagnosticsUnderlineError SpellBad
highlight! link LspDiagnosticsUnderlineWarning SpellBad
highlight! link LspDiagnosticsUnderlineHint SpellBad
highlight! link LspDiagnosticsUnderlineInformation SpellBad
