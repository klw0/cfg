if !has('nvim')
  finish
endif

if exists('g:loaded_lsp')
  finish
endif
let g:loaded_lsp = v:true
