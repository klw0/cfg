let s:help_max_width = 76
autocmd BufWinEnter <buffer> if &columns >= (80 + s:help_max_width) | wincmd L | endif
