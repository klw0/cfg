" TODO(klw0): Non-script local functions should have docblocks. Use vimdoc?

let s:modes = {
  \ 'n': ['NORMAL', 'normal'],
  \ 'i': ['INSERT', 'insert'],
  \ 'R': ['REPLACE', 'replace'],
  \ 'v': ['VISUAL', 'visual'],
  \ 'V': ['V-LINE', 'visual'],
  \ "\<C-v>": ['V-BLOCK', 'visual'],
  \ 'c': ['COMMAND', 'command'],
  \ 's': ['SELECT', 'select'],
  \ 'S': ['S-LINE', 'select'],
  \ "\<C-s>": ['S-BLOCK', 'select'],
  \ 'r': ['PROMPT', 'prompt'],
  \ 't': ['TERMINAL', 'terminal'],
  \ }

let s:mode_category_colors = {
  \ 'normal': 'blue',
  \ 'insert': 'green',
  \ 'replace': 'red',
  \ 'visual': 'magenta',
  \ 'command': 'blue',
  \ 'select': 'magenta',
  \ 'prompt': 'base3',
  \ 'terminal': 'cyan',
  \ }

function! s:SetHighlightGroup(...) abort
  if exists('*minsolarized#SetHighlightGroup')
    call call('minsolarized#SetHighlightGroup', a:000)
  endif
endfunction

function! stabusline#Statusline(is_active) abort
  let l:statusline = '%#StabuslineDefault#'

  if (a:is_active)
    let [l:mode_name, l:mode_category] = get(s:modes, mode(), ['UNKNOWN', 'unknown'])

    let l:statusline .= '%#StabuslineMode_' . l:mode_category . '# ' . l:mode_name . '%( | %{&paste ? "PASTE" : ""}%) '
    let l:statusline .= '%#StabuslinePrimary# %(%R | %)%{stabusline#BufferName(bufnr())}%( %m%) '
    let l:statusline .= '%#StabuslineDefault# %<%{stabusline#Truncate(stabusline#GitBranch())} '
    let l:statusline .= '%='
    let l:statusline .= ' %{&ft !=# "" ? &ft : "no ft"} '
    let l:statusline .= '%#StabuslinePrimary# %3p%% '
    let l:statusline .= '%#StabuslineSecondary# %3l:%-2v '
    let l:statusline .= '%#StabuslineWarning#%( %{stabusline#DiagnosticWarnings()} %)'
    let l:statusline .= '%#StabuslineError#%( %{stabusline#DiagnosticErrors()} %)'
  else
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
    let l:tabline .= (l:is_tab_active ? '%#StabuslinePrimary#' : '%#StabuslineDefault#') . ' ' . l:tab . ' '
    let l:tabline .= stabusline#BufferName(l:active_buffer)
    let l:tabline .= getbufvar(l:active_buffer, '&modified') ? ' [+]' : ''

    if len(l:buffers) > 1
      " TODO(klw0): This is intended to filter out floating windows, but
      " it may filter out buffers that should be included.  Find a
      " better way to do this.
      let l:valid_buffers = filter(l:buffers, { _, b -> getbufvar(b, '&bufhidden') !=# 'hide' })
      let l:tabline .= (l:is_tab_active ? '%#StabuslinePrimaryInfo#' : '%#StabuslineDefaultInfo#') . ' ' . len(l:valid_buffers)

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

    let l:tabline .= ' %#StabuslineTabSeparator# '
  endfor

  " End the tab page label.
  let l:tabline .= '%#StabuslineDefault#%T'

  return l:tabline
endfunction

function! stabusline#UpdateHighlightGroups() abort
  call s:SetHighlightGroup('StabuslineDefault', 'base0', 'base02')
  call s:SetHighlightGroup('StabuslineDefaultInfo', 'base00', 'base02')
  call s:SetHighlightGroup('StabuslinePrimary', 'base03', 'base00')
  call s:SetHighlightGroup('StabuslinePrimaryInfo', 'base2', 'base00')
  call s:SetHighlightGroup('StabuslineSecondary', 'base03', 'base01')
  call s:SetHighlightGroup('StabuslineError', 'base03', 'red')
  call s:SetHighlightGroup('StabuslineWarning', 'base03', 'yellow')
  call s:SetHighlightGroup('StabuslineTabSeparator', 'base03', 'base03')

  for [l:mode_category, l:mode_category_color] in items(s:mode_category_colors)
    call s:SetHighlightGroup('StabuslineMode_' . l:mode_category, 'base03', l:mode_category_color)
  endfor

  call s:SetHighlightGroup('StabuslineMode_unknown', 'base03', 'yellow')
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

function! stabusline#GitBranch()
  return exists('*FugitiveHead') ? FugitiveHead() : ''
endfunction

function! stabusline#DiagnosticErrors() abort
  let l:errors = luaeval('vim.lsp.diagnostic.get_count(vim.fn.bufnr(), "Error")')

  return l:errors ? 'E' . l:errors : ''
endfunction

function! stabusline#DiagnosticWarnings() abort
  let l:warnings = luaeval('vim.lsp.diagnostic.get_count(vim.fn.bufnr(), "Warning")')

  return l:warnings ? 'W' . l:warnings : ''
endfunction

function! stabusline#Truncate(string) abort
  return winwidth(0) >= 80 ? a:string : ''
endfunction

augroup stabusline_dev
  autocmd!

  " Automatically apply color changes after writing this file.
  autocmd BufWritePost stabusline.vim so <sfile> | call stabusline#UpdateHighlightGroups()
augroup END
