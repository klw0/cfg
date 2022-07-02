" fuzzy: Fuzzy matching utils.

if exists('g:loaded_fuzzy')
  finish
endif
let g:loaded_fuzzy = v:true

command! -nargs=1 -bar -complete=customlist,fuzzy#EditCompleter FuzzyEdit execute 'edit ' . expand(<q-args>)
command! -nargs=1 -bar -complete=customlist,fuzzy#EditCompleter FuzzyTabEdit execute 'tabedit ' . expand(<q-args>)
