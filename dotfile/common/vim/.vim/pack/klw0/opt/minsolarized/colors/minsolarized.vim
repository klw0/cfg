" minsolarized: A Solarized color scheme with minimal syntax highlighting.
"
" Color assignments loosely based on vim-colors-solarized [1] and NeoSolarized [2].
"
" [1] https://github.com/altercation/vim-colors-solarized
" [2] https://github.com/overcache/NeoSolarized
"

highlight clear
if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'minsolarized'
let g:minsolarized_highcontrast = get(g:, 'minsolarized_highcontrast', v:false)

let s:colors = {
  \ 'base03': { 'gui': '#002b36', 'cterm': '8' },
  \ 'base02': { 'gui': '#073642', 'cterm': '0' },
  \ 'base01': { 'gui': '#586e75', 'cterm': '10' },
  \ 'base00': { 'gui': '#657b83', 'cterm': '11' },
  \ 'base0': { 'gui': '#839496', 'cterm': '12' },
  \ 'base1': { 'gui': '#93a1a1', 'cterm': '14' },
  \ 'base2': { 'gui': '#eee8d5', 'cterm': '7' },
  \ 'base3': { 'gui': '#fdf6e3', 'cterm': '15' },
  \ 'yellow': { 'gui': '#b58900', 'cterm': '3' },
  \ 'orange': { 'gui': '#cb4b16', 'cterm': '9' },
  \ 'red': { 'gui': '#dc322f', 'cterm': '1' },
  \ 'magenta': { 'gui': '#d33682', 'cterm': '5' },
  \ 'violet': { 'gui': '#6c71c4', 'cterm': '13' },
  \ 'blue': { 'gui': '#268bd2', 'cterm': '4' },
  \ 'cyan': { 'gui': '#2aa198', 'cterm': '6' },
  \ 'green': { 'gui': '#859900', 'cterm': '2' },
  \ 'none': { 'gui': 'NONE', 'cterm': 'NONE' },
  \ }

if (&background ==# 'light')
  let s:colors = extend(s:colors, {
    \ 'base03': get(s:colors, 'base3'),
    \ 'base02': get(s:colors, 'base2'),
    \ 'base01': get(s:colors, 'base1'),
    \ 'base00': get(s:colors, 'base0'),
    \ 'base0': get(s:colors, 'base00'),
    \ 'base1': get(s:colors, 'base01'),
    \ 'base2': get(s:colors, 'base02'),
    \ 'base3': get(s:colors, 'base03'),
    \ })
endif

if (g:minsolarized_highcontrast == v:true)
  let s:colors = extend(s:colors, {
    \ 'base01': get(s:colors, 'base00'),
    \ 'base00': get(s:colors, 'base0'),
    \ 'base0': get(s:colors, 'base1'),
    \ 'base1': get(s:colors, 'base2'),
    \ 'base2': get(s:colors, 'base3'),
    \ })
endif

""
" Set highlight group.
"
" @param {string} name - Highlight group name.
" @param {string} fg_color - Foreground color name.
" @param {string} bg_color - Background color name.
" @param {string} [attr_list] - Comma separated list of highlight group attributes.
" @param {string} [sp_color] - Special color name.
""
function! minsolarized#SetHighlightGroup(name, fg_color, bg_color, ...) abort
  let l:broken_color = { 'gui': '#ff00ff', 'cterm': '13' }    " Pepto-bismol
  let l:fg_color = get(s:colors, a:fg_color, l:broken_color)
  let l:bg_color = get(s:colors, a:bg_color, l:broken_color)
  let l:attr_list = a:0 > 0 ? a:1 : 'NONE'
  let l:sp_color = get(s:colors, a:0 > 1 ? a:2 : 'none', l:broken_color)

  execute printf(
    \ 'highlight %s cterm=%s ctermfg=%s ctermbg=%s gui=%s guifg=%s guibg=%s guisp=%s',
    \ a:name,
    \ l:attr_list,
    \ get(l:fg_color, 'cterm'),
    \ get(l:bg_color, 'cterm'),
    \ l:attr_list,
    \ get(l:fg_color, 'gui'),
    \ get(l:bg_color, 'gui'),
    \ get(l:sp_color, 'gui'),
    \ )
endfunction

" ----------------------------------------------------------------------------
" Highlight Groups
" ----------------------------------------------------------------------------

call minsolarized#SetHighlightGroup('Normal', 'base0', 'base03')

" Syntax
call minsolarized#SetHighlightGroup('Comment', 'base01', 'none', 'italic')
call minsolarized#SetHighlightGroup('Constant', 'cyan', 'none')
call minsolarized#SetHighlightGroup('Debug', 'red', 'none')
call minsolarized#SetHighlightGroup('Error', 'red', 'none', 'bold')
call minsolarized#SetHighlightGroup('Identifier', 'none', 'none')
call minsolarized#SetHighlightGroup('Ignore', 'none', 'none')
call minsolarized#SetHighlightGroup('PreProc', 'none', 'none')
call minsolarized#SetHighlightGroup('Special', 'none', 'none')
call minsolarized#SetHighlightGroup('Statement', 'none', 'none')
call minsolarized#SetHighlightGroup('Tag', 'red', 'none')
call minsolarized#SetHighlightGroup('Todo', 'magenta', 'none', 'bold')
call minsolarized#SetHighlightGroup('Type', 'none', 'none')
call minsolarized#SetHighlightGroup('Underlined', 'violet', 'none')
highlight link SpecialChar Constant
highlight link SpecialComment Comment

" Other
call minsolarized#SetHighlightGroup('ColorColumn', 'none', 'base02')
call minsolarized#SetHighlightGroup('Conceal', 'blue', 'none')
call minsolarized#SetHighlightGroup('Cursor', 'base03', 'base0')
call minsolarized#SetHighlightGroup('CursorColumn', 'none', 'base02')
call minsolarized#SetHighlightGroup('CursorLine', 'none', 'base02')
call minsolarized#SetHighlightGroup('CursorLineNr', 'none', 'base02')
call minsolarized#SetHighlightGroup('DiffAdd', 'green', 'base02', 'bold')
call minsolarized#SetHighlightGroup('DiffChange', 'yellow', 'base02', 'bold')
call minsolarized#SetHighlightGroup('DiffDelete', 'red', 'base02', 'bold')
call minsolarized#SetHighlightGroup('DiffText', 'blue', 'base02', 'bold')
call minsolarized#SetHighlightGroup('Directory', 'blue', 'none')
call minsolarized#SetHighlightGroup('ErrorMsg', 'red', 'none', 'reverse')
call minsolarized#SetHighlightGroup('FoldColumn', 'base0', 'base02')
call minsolarized#SetHighlightGroup('Folded', 'base0', 'base02', 'bold', 'base03')
call minsolarized#SetHighlightGroup('IncSearch', 'base03', 'base0')
call minsolarized#SetHighlightGroup('LineNr', 'base01', 'base02')
call minsolarized#SetHighlightGroup('MatchParen', 'red', 'base01', 'bold')
call minsolarized#SetHighlightGroup('ModeMsg', 'blue', 'none')
call minsolarized#SetHighlightGroup('MoreMsg', 'blue', 'none')
call minsolarized#SetHighlightGroup('NonText', 'base00', 'none', 'bold')
call minsolarized#SetHighlightGroup('Pmenu', 'base0', 'base02', 'reverse')
call minsolarized#SetHighlightGroup('PmenuSbar', 'base2', 'base0', 'reverse')
call minsolarized#SetHighlightGroup('PmenuSel', 'base01', 'base2', 'reverse')
call minsolarized#SetHighlightGroup('PmenuThumb', 'base0', 'base03', 'reverse')
call minsolarized#SetHighlightGroup('Question', 'cyan', 'none', 'bold')
call minsolarized#SetHighlightGroup('Search', 'yellow', 'none', 'reverse')
call minsolarized#SetHighlightGroup('SignColumn', 'base0', 'none')
call minsolarized#SetHighlightGroup('SpecialKey', 'base00', 'base02', 'bold')
call minsolarized#SetHighlightGroup('SpellBad', 'none', 'none', 'underline', 'red')
call minsolarized#SetHighlightGroup('SpellCap', 'none', 'none', 'underline', 'violet')
call minsolarized#SetHighlightGroup('SpellLocal', 'none', 'none', 'underline', 'yellow')
call minsolarized#SetHighlightGroup('SpellRare', 'none', 'none', 'underline', 'cyan')
call minsolarized#SetHighlightGroup('StatusLine', 'base1', 'base02', 'reverse')
call minsolarized#SetHighlightGroup('StatusLineNC', 'base00', 'base02', 'reverse')
call minsolarized#SetHighlightGroup('TabLine', 'base0', 'base02')
call minsolarized#SetHighlightGroup('TabLineFill', 'base0', 'base02')
call minsolarized#SetHighlightGroup('TabLineSel', 'base01', 'base2', 'reverse')
call minsolarized#SetHighlightGroup('Title', 'orange', 'none', 'bold')
call minsolarized#SetHighlightGroup('VertSplit', 'base00', 'none')
call minsolarized#SetHighlightGroup('Visual', 'base01', 'base03', 'reverse')
call minsolarized#SetHighlightGroup('VisualNOS', 'none', 'base02', 'standout')
call minsolarized#SetHighlightGroup('WarningMsg', 'orange', 'none', 'bold')
call minsolarized#SetHighlightGroup('WildMenu', 'base2', 'base02', 'reverse')
highlight link lCursor Cursor
highlight link CursorIM Cursor

augroup minsolarized_dev
  autocmd!

  " Automatically apply the color scheme after writing.
  autocmd BufWritePost minsolarized.vim colorscheme minsolarized
augroup END
