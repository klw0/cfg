" Add a TODO comment above the current line.
function! todo#Add(string = 'TODO:') abort
  let l:indent = matchstr(getline('.'), '^\s*')
  let [l:lhs, l:rhs] = split(&commentstring, '%s', v:true)

  " Ensure at least one space on the inside of comment markers.
  let l:lhs = len(l:lhs) == 0 || l:lhs =~ '^\S\+\s' ? l:lhs : l:lhs . ' '
  let l:rhs = len(l:rhs) == 0 || l:rhs =~ '^\s\S\+' ? l:rhs : ' ' . l:rhs
  let l:comment = printf('%s%s%s%s', indent, l:lhs, a:string . ' ', l:rhs)

  let l:line = line('.') - 1
  call append(l:line, l:comment)
  call cursor(l:line + 1, len(l:comment) - len(l:rhs))
endfunction
