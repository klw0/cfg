let s:escape_chars = '.~^\'

" Returns a list of possible matches to the query.
"
" Intended to be used if vim's matchfuzzy() isn't available. Results and
" performance are similar:
"   Total items: 2272
"   matchfuzzy(): 16 matches, 0.019368 seconds
"   fuzzy#CheapMatchFuzzy(): 16 matches, 0.019146 seconds
function! fuzzy#CheapMatchFuzzy(items, query) abort
  let l:pat = ''
  let l:qchars = split(a:query, '\zs')
  for l:c in l:qchars[0:-2]
    let l:c = escape(l:c, s:escape_chars)
    let l:pat .= printf('%s[^%s]\{-}', l:c, l:c)      " \{-} is vim's ungreedy *
  endfor
  let l:pat .= escape(l:qchars[-1], s:escape_chars)
  let l:pat .= '\C'

  " Match, score, and sort online.
  let l:matches = []
  let l:scores = []
  for l:item in a:items
    let [l:match, l:match_start, l:match_end] = matchstrpos(l:item, l:pat)
    if l:match ==# '' | continue | endif
    let l:score = l:match_end - l:match_start

    let l:i = len(l:scores)
    while l:i > 0 && l:scores[l:i - 1] > l:score
      let l:i -= 1
    endwhile

    call insert(l:matches, l:item, l:i)
    call insert(l:scores, l:score, l:i)
  endfor

  return l:matches
endfunction

function! fuzzy#EditCompleter(argLead, cmdLine, cursorPos) abort
  let l:cmd = 'find . -type f'
  for l:p in split(&wildignore, ',')
    let l:cmd .= printf(' -not -path "./%s"', l:p)
  endfor
  let l:files = systemlist(l:cmd)

  if len(a:argLead) > 0
    let l:Matcher = exists('*matchfuzzy') ? function('matchfuzzy') : function('fuzzy#CheapMatchFuzzy')
    return l:Matcher(l:files, a:argLead)
  else
    return l:files
  endif
endfunction
