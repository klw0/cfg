setlocal commentstring='%s

nmap <buffer> <leader>a :e %:r.xml<CR>

let b:undo_ftplugin =
  \   '| setlocal commentstring<'
  \ . '| nunmap <buffer> <leader>a'
