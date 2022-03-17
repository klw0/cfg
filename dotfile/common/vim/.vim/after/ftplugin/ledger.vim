augroup ledger
  autocmd!
  autocmd BufWritePre <buffer> :LedgerAlignBuffer
augroup END

let b:undo_ftplugin = '| autocmd! BufWritePre <buffer>'
