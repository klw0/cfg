let s:man_max_width = 78
autocmd BufWinEnter <buffer> if &columns >= (80 + s:man_max_width) | wincmd L | endif
