silent call write#Enable()
setlocal textwidth=80

" HACK(klw0): vim-pandoc sets `wrap` to vim's default even when configured to
" use hard wraps, so override.
" Offending line: https://github.com/vim-pandoc/vim-pandoc/blob/6307e78e2f1729e37b82480f97b6e0e421e6e687/autoload/pandoc/formatting.vim#L248
setlocal nowrap

if exists('*pandoc#toc#Show')
    " Always open Pandoc's table of contents to the left.
    nnoremap <buffer><expr><silent> <leader>t &splitright
        \ ? ":setlocal nosplitright \| call pandoc#toc#Show() \| setlocal splitright<CR>"
        \ : ":call pandoc#toc#Show()<CR>"
endif

let b:undo_ftplugin =
    \   '| silent call write#Disable()'
    \ . '| setlocal textwidth<'
    \ . '| setlocal nowrap<'
    \ . '| nunmap <buffer> <leader>t'
