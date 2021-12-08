" TODO(klw0): Non-script local functions should have docblocks. Use vimdoc?

let s:modes = {
  \ 'n': 'N',
  \ 'i': 'I',
  \ 'R': 'R',
  \ 'v': 'V',
  \ 'V': 'V-L',
  \ "\<C-v>": 'V-B',
  \ 'c': 'C',
  \ 's': 'S',
  \ 'S': 'S-L',
  \ "\<C-s>": 'S-B',
  \ 'r': 'P',
  \ 't': 'T',
  \ }

function! stabusline#Statusline(is_active) abort
  if (a:is_active)
    let l:statusline = '%#StatusLine#'
    let l:statusline .= ' %-3(' . get(s:modes, mode(), '?') . '%)%( | %{&paste ? "PASTE" : ""}%)'
    let l:statusline .= ' %(%R | %)%{stabusline#BufferName(bufnr())}%( %m%) '
    let l:statusline .= '%='
    let l:statusline .= ' %<%{&ft !=# "" ? &ft : "no ft"} '
    let l:statusline .= ' %3p%% '
    let l:statusline .= ' %3l:%-2v '
    let l:statusline .= '%#WarningMsg#%( %{stabusline#DiagnosticWarnings()} %)'
    let l:statusline .= '%#ErrorMsg#%( %{stabusline#DiagnosticErrors()} %)'
  else
    let l:statusline = '%#StatusLineNC#'
    let l:statusline .= ' %(%R | %)%{stabusline#BufferName(bufnr())}%( %m%)'
    let l:statusline .= '%='
    let l:statusline .= ' %{&ft !=# "" ? &ft : "no ft"} '
    let l:statusline .= ' %<%3p%% '
    let l:statusline .= ' %3l:%-2v '
  endif

  return l:statusline
endfunction

function! stabusline#Tabline() abort
  let l:tabline = ''

  for i in range(tabpagenr('$'))
    let l:tab = i + 1
    let l:is_tab_active = l:tab == tabpagenr()
    let l:buffers = tabpagebuflist(l:tab)
    let l:active_buffer = l:buffers[tabpagewinnr(l:tab) - 1]

    " Start the tab page label, for mouse click support.
    let l:tabline .= '%' . l:tab . 'T'
    let l:tabline .= (l:is_tab_active ? '%#TabLineSel#' : '%#TabLine#') . ' ' . l:tab . ' '
    let l:tabline .= stabusline#BufferName(l:active_buffer)
    let l:tabline .= getbufvar(l:active_buffer, '&modified') ? ' [+]' : ''

    if len(l:buffers) > 1
      " TODO(klw0): This is intended to filter out floating windows, but
      " it may filter out buffers that should be included.  Find a
      " better way to do this.
      let l:valid_buffers = filter(l:buffers, { _, b -> getbufvar(b, '&bufhidden') !=# 'hide' })
      let l:tabline .= (l:is_tab_active ? '%#TabLineSel#' : '%#TabLine#') . ' ' . len(l:valid_buffers)

      let l:has_inactive_modified_buffers = v:false
      for l:valid_buffer in l:valid_buffers
        if l:valid_buffer == l:active_buffer | continue | endif

        if getbufvar(l:valid_buffer, '&modified')
          let l:has_inactive_modified_buffers = v:true
          break
        endif
      endfor

      let l:tabline .= l:has_inactive_modified_buffers ? '+' : ''
    endif

    let l:tabline .= ' %#Normal# '
  endfor

  " End the tab page label.
  let l:tabline .= '%#TabLine#%T'

  return l:tabline
endfunction

" ----------------------------------------------------------------------------
" Status and tab line items
" ----------------------------------------------------------------------------

" Returns a context-aware buffer name for {bufnr}.
function! stabusline#BufferName(bufnr) abort
  let l:filename = bufname(a:bufnr)
  " Works across tab pages, unlike bufwinid(), which operates in the
  " context of the current tab page.
  let l:winid = get(win_findbuf(a:bufnr), 0, -1)

  if getbufvar(a:bufnr, '&filetype') ==# 'help'
    return fnamemodify(l:filename, ':t')
  elseif l:filename !=# ''
    return pathshorten(l:filename)
  elseif get(get(getwininfo(l:winid), 0, {}), 'loclist')
    return '[Location List] ' . getloclist(l:winid, {'title': 0}).title
  elseif get(get(getwininfo(l:winid), 0, {}), 'quickfix')
    return '[Quickfix List] ' . getqflist({'title': 0}).title
  else
    return '[No Name]'
  endif
endfunction

function! stabusline#DiagnosticErrors() abort
  let l:errors = luaeval('vim.lsp.diagnostic.get_count(vim.fn.bufnr(), "Error")')

  return l:errors ? 'E' . l:errors : ''
endfunction

function! stabusline#DiagnosticWarnings() abort
  let l:warnings = luaeval('vim.lsp.diagnostic.get_count(vim.fn.bufnr(), "Warning")')

  return l:warnings ? 'W' . l:warnings : ''
endfunction

augroup stabusline_dev
  autocmd!

  " Automatically apply color changes after writing this file.
  autocmd BufWritePost stabusline.vim so <sfile>
augroup END
