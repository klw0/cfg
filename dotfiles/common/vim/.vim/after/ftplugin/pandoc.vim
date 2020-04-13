" HACK(klw0): vim-pandoc sets `wrap` to vim's default even when configured to
" use hard wraps, so override.
" Offending line: https://github.com/vim-pandoc/vim-pandoc/blob/6307e78e2f1729e37b82480f97b6e0e421e6e687/autoload/pandoc/formatting.vim#L248
setlocal nowrap

setlocal spell
setlocal textwidth=80

" Display spelling suggestions.
nnoremap <buffer> <leader>s ea<C-X><C-S><C-P>

if exists('*pandoc#toc#Show')
    " Always open Pandoc's table of contents to the left.
    nnoremap <buffer><expr><silent> <leader>t &splitright
        \ ? ":setlocal nosplitright \| call pandoc#toc#Show() \| setlocal splitright<CR>"
        \ : ":call pandoc#toc#Show()<CR>"
endif

" Disable coc.nvim's completion support.
let b:coc_suggest_disable = v:true

let b:undo_ftplugin =
    \   '| setlocal nowrap<'
    \ . '| setlocal spell<'
    \ . '| setlocal textwidth<'
    \ . '| nunmap <buffer> <leader>s'
    \ . '| nunmap <buffer> <leader>t'
    \ . '| unlet b:coc_suggest_disable'
