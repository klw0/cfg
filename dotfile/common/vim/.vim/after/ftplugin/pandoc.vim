silent call write#Enable()
let b:undo_ftplugin = '| silent call write#Disable()'

setlocal textwidth=80
let b:undo_ftplugin .= '| setlocal textwidth<'

" HACK(klw0): vim-pandoc sets `wrap` to vim's default even when configured to
" use hard wraps, so override.
" Offending line: https://github.com/vim-pandoc/vim-pandoc/blob/6307e78e2f1729e37b82480f97b6e0e421e6e687/autoload/pandoc/formatting.vim#L248
setlocal nowrap
let b:undo_ftplugin .= '| setlocal nowrap<'

if exists('*pandoc#toc#Show')
  nnoremap <buffer> <leader>t :TOC<CR>
  let b:undo_ftplugin .= '| nunmap <buffer> <leader>t'
endif

if exists('*pandoc#keyboard#sections#ForwardHeader')
  nnoremap <buffer> ]] :<C-U>call pandoc#keyboard#sections#ForwardHeader(v:count1)<CR>
  let b:undo_ftplugin .= '| nunmap <buffer> ]]'
endif

if exists('*pandoc#keyboard#sections#BackwardHeader')
  nnoremap <buffer> [[ :<C-U>call pandoc#keyboard#sections#BackwardHeader(v:count1)<CR>
  let b:undo_ftplugin .= '| nunmap <buffer> [['
endif

if exists('*pandoc#keyboard#sections#SelectSection')
  vnoremap <buffer> aS :<C-U>call pandoc#keyboard#sections#SelectSection('inclusive')<CR>
  let b:undo_ftplugin .= '| vunmap <buffer> aS'

  onoremap <buffer> aS :normal VaS<CR>
  let b:undo_ftplugin .= '| ounmap <buffer> aS'

  vnoremap <buffer> iS :<C-U>call pandoc#keyboard#sections#SelectSection('exclusive')<CR>
  let b:undo_ftplugin .= '| vunmap <buffer> iS'

  onoremap <buffer> iS :normal ViS<CR>
  let b:undo_ftplugin .= '| ounmap <buffer> iS'
endif
