" Add an attention comment on the line indicated by `direction`.
"
" @param attn_string - Attention string
" @param [direction] - One of 'n' (line above), 's' (line below),
"                      or 'w' (current line)
function! attn#Add(attn_string, direction = 'n') abort
  let [l:lhs, l:rhs] = split(&commentstring, '%s', v:true)

  " Ensure at least one space on the inside of comment markers.
  let l:lhs = len(l:lhs) == 0 || l:lhs =~ '^\S\+\s' ? l:lhs : l:lhs . ' '
  let l:rhs = len(l:rhs) == 0 || l:rhs =~ '^\s\S\+' ? l:rhs : ' ' . l:rhs

  let l:comment = printf('%s%s%s', l:lhs, a:attn_string . ' ', l:rhs)
  let l:line = getline('.')
  if a:direction ==# 'n' || a:direction ==# 's'
    let l:indent = matchstr(l:line, '^\s*')
    let l:new_line = l:indent . l:comment
    let l:new_lnum = line('.') + (a:direction ==# 'n' ? -1 : 0)

    call append(l:new_lnum, l:new_line)
    call cursor(l:new_lnum + 1, len(l:new_line) - len(l:rhs))
  elseif a:direction ==# 'w'
    let l:new_line = l:line . "\t" . l:comment

    call setline('.', l:new_line)
    call cursor('.', len(l:new_line) - len(l:rhs))
  endif
endfunction
