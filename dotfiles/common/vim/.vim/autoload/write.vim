let s:undo_key = 'undo_write_enable'

" Enables write mode.
function! write#Enable() abort
    setlocal spell
    let b:[s:undo_key] = '| setlocal spell<'

    nnoremap <buffer> <leader>s ea<C-X><C-S><C-P>
    let b:[s:undo_key] .= '| nunmap <buffer> <leader>s'

    " Disable coc.nvim's completion support.
    let b:coc_suggest_disable = v:true
    let b:[s:undo_key] .= '| unlet b:coc_suggest_disable'
endfunction

" Disables write mode.
function! write#Disable() abort
    if !has_key(b:, s:undo_key) | return | endif

    execute b:[s:undo_key]
    call remove(b:, s:undo_key)
endfunction
