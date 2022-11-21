highlight clear
if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'klw0'

highlight Comment       cterm=none            ctermfg=8     ctermbg=none
highlight Constant      cterm=none            ctermfg=none  ctermbg=none
highlight Debug         cterm=none            ctermfg=1     ctermbg=none
highlight Error         cterm=bold            ctermfg=1     ctermbg=none
highlight Identifier    cterm=none            ctermfg=none  ctermbg=none
highlight Ignore        cterm=none            ctermfg=none  ctermbg=none
highlight PreProc       cterm=none            ctermfg=none  ctermbg=none
highlight Special       cterm=none            ctermfg=none  ctermbg=none
highlight Statement     cterm=none            ctermfg=none  ctermbg=none
highlight Tag           cterm=none            ctermfg=1     ctermbg=none
highlight Todo          cterm=bold            ctermfg=6     ctermbg=none
highlight Type          cterm=none            ctermfg=none  ctermbg=none
highlight Underlined    cterm=none            ctermfg=13    ctermbg=none
highlight link SpecialChar Constant
highlight link SpecialComment Comment

highlight ColorColumn   cterm=none            ctermfg=none  ctermbg=0
highlight Conceal       cterm=none            ctermfg=4     ctermbg=none
highlight Cursor        cterm=reverse         ctermfg=7     ctermbg=none
highlight CursorColumn  cterm=none            ctermfg=none  ctermbg=0
highlight CursorLine    cterm=none            ctermfg=none  ctermbg=0
highlight CursorLineNr  cterm=none            ctermfg=none  ctermbg=0
highlight DiffAdd       cterm=none            ctermfg=2     ctermbg=0
highlight DiffChange    cterm=none            ctermfg=3     ctermbg=0
highlight DiffDelete    cterm=none            ctermfg=1     ctermbg=0
highlight DiffText      cterm=none            ctermfg=4     ctermbg=0
highlight Directory     cterm=none            ctermfg=4     ctermbg=none
highlight ErrorMsg      cterm=reverse         ctermfg=1     ctermbg=none
highlight FoldColumn    cterm=none            ctermfg=none  ctermbg=0
highlight Folded        cterm=bold            ctermfg=none  ctermbg=0
highlight IncSearch     cterm=reverse         ctermfg=9     ctermbg=none
highlight LineNr        cterm=none            ctermfg=8     ctermbg=0
highlight MatchParen    cterm=reverse         ctermfg=8     ctermbg=none
highlight ModeMsg       cterm=none            ctermfg=none  ctermbg=none
highlight MoreMsg       cterm=none            ctermfg=none  ctermbg=none
highlight NonText       cterm=none            ctermfg=none  ctermbg=none
highlight Pmenu         cterm=reverse         ctermfg=none  ctermbg=none
highlight PmenuSbar     cterm=none            ctermfg=none  ctermbg=7
highlight PmenuSel      cterm=reverse         ctermfg=8     ctermbg=none
highlight PmenuThumb    cterm=none            ctermfg=none  ctermbg=8
highlight Question      cterm=bold            ctermfg=none  ctermbg=none
highlight Search        cterm=reverse         ctermfg=3     ctermbg=none
highlight SignColumn    cterm=none            ctermfg=none  ctermbg=none
highlight SpecialKey    cterm=bold            ctermfg=none  ctermbg=none
highlight SpellBad      cterm=underline       ctermfg=none  ctermbg=none
highlight SpellCap      cterm=underline       ctermfg=none  ctermbg=none
highlight SpellLocal    cterm=underline       ctermfg=none  ctermbg=none
highlight SpellRare     cterm=underline       ctermfg=none  ctermbg=none
highlight StatusLine    cterm=none            ctermfg=none  ctermbg=0
highlight StatusLineNC  cterm=none            ctermfg=8     ctermbg=0
highlight TabLine       cterm=none            ctermfg=none  ctermbg=0
highlight TabLineFill   cterm=none            ctermfg=none  ctermbg=0
highlight TabLineSel    cterm=reverse         ctermfg=8     ctermbg=none
highlight Title         cterm=bold            ctermfg=none  ctermbg=none
highlight VertSplit     cterm=none            ctermfg=8     ctermbg=none
highlight Visual        cterm=reverse         ctermfg=7     ctermbg=none
highlight VisualNOS     cterm=bold,underline  ctermfg=none  ctermbg=none
highlight WarningMsg    cterm=bold            ctermfg=3     ctermbg=none
highlight WildMenu      cterm=reverse         ctermfg=8     ctermbg=none
highlight link lCursor Cursor
highlight link CursorIM Cursor

augroup klw0_dev
  autocmd!
  autocmd BufWritePost <buffer> colorscheme klw0
augroup END
