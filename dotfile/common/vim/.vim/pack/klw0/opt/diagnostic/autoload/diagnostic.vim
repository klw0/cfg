function! diagnostic#Changed() abort
  if !has('nvim') | return | endif

lua << EOF
vim.diagnostic.setloclist({ open = false })

if #vim.diagnostic.get(0) == 0 then
  vim.api.nvim_command('lclose')
end
EOF
endfunction

function! diagnostic#Errors() abort
  let l:errors = []
  if has('nvim')
    let l:errors = luaeval('vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })')
  endif

  return l:errors
endfunction

function! diagnostic#Warnings() abort
  let l:warnings = []
  if has('nvim')
    let l:warnings = luaeval('vim.diagnostic.get(0, { severity = { max = vim.diagnostic.severity.WARN } })')
  endif

  return l:warnings
endfunction
