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
  if a:direction ==# 'n' || a:direction ==# 's'
    let l:offsets = {
      \ 'n': { 'indent': 0, 'append': -1, 'cursor': -1 },
      \ 's': { 'indent': 1, 'append':  0, 'cursor':  1 },
      \ }[a:direction]

    let l:indent = matchstr(getline(line('.') + l:offsets['indent']), '^\s*')
    let l:line = l:indent . l:comment

    call append(line('.') + l:offsets['append'], l:line)
    call cursor(line('.') + l:offsets['cursor'], len(l:line) - len(l:rhs))
  elseif a:direction ==# 'w'
    let l:line = getline('.') . "\t" . l:comment

    call setline('.', l:line)
    call cursor('.', len(l:line) - len(l:rhs))
  endif
endfunction
