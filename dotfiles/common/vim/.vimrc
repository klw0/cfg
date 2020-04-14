"
" Originally pillaged from janus and spf13, and evolved from there.
"

" ------------------------------------------------------------------------------
" General
" ------------------------------------------------------------------------------
set nocompatible                " Use vim, no vi defaults
let mapleader="\<Space>"
let maplocalleader="\<Space>"
set number                      " Show line numbers
set ruler                       " Show line and column number in stats line
set history=10000               " Store a ton of history
syntax enable                   " Enable syntax highlighting
set encoding=utf-8
set t_ti= t_te=                 " Don't switch to the terminal when running cli commands
set ttimeoutlen=0               " Shorten key sequence timeouts (eliminates delays after hitting ESC)
set mouse=a                     " Enable mouse support in all modes for pane resizing
set hidden                      " Allow hidden buffers
set noshowmode
set splitright
set diffopt+=algorithm:histogram

if has("nvim")
    set inccommand=nosplit      " Show the effects of an ex command in realtime
endif


" ------------------------------------------------------------------------------
" Formatting
" ------------------------------------------------------------------------------
set nowrap                      " Don't wrap lines
set tabstop=4                   " A tab is X spaces
set shiftwidth=4                " An autoindent (with <<) is X spaces
set expandtab                   " Use spaces, not tabs
set list                        " Show invisible characters
set backspace=indent,eol,start  " Backspace through everything in insert mode

" List chars
set listchars=""                " Reset the listchars
set listchars=tab:\ \           " A tab should display as "  "
set listchars+=trail:.          " Show trailing spaces as periods
set listchars+=extends:>        " The character to show in the last column when wrap is off and the line continues beyond the right of the screen
set listchars+=precedes:<       " The character to show in the last column when wrap is off and the line continues beyond the left of the screen


" ------------------------------------------------------------------------------
" Searching
" ------------------------------------------------------------------------------
set hlsearch    " Highlight matches
set incsearch   " Incremental searching
set ignorecase  " Searches are case insensitive...
set smartcase   " ...unless they contain at least one capital letter


" ------------------------------------------------------------------------------
" UI
" ------------------------------------------------------------------------------
set termguicolors
set background=dark

if has("statusline")
    set laststatus=2  " Always show the status bar
endif

" ------------------------------------------------------------------------------
" Backup and swap files
" ------------------------------------------------------------------------------
set backupdir=~/.vim/_backup//
set directory=~/.vim/_temp//


" ------------------------------------------------------------------------------
" General Mappings
" ------------------------------------------------------------------------------
" Create the directory containing the file in the buffer
nmap <silent> <leader>md :!mkdir -p %:p:h<CR>

" Set text wrapping toggles
nmap <silent> <leader>tw :set invwrap<CR>:set wrap?<CR>

iabbrev TODO: TODO(klw0):
nmap <leader>td <S-o>TODO: <Esc><Plug>Commentary $a

" Clear search highlighting, update the current diff if there is one, and
" clear the screen/redraw.
nnoremap <silent><expr> <C-L> ':nohlsearch' . (&diff ? '\| diffupdate' : '') . '<CR><C-L>'

nnoremap ]b :bnext<CR>
nnoremap [b :bprev<CR>
nnoremap ]B :blast<CR>
nnoremap [B :bfirst<CR>

nnoremap ]l :lnext<CR>
nnoremap [l :lprev<CR>
nnoremap ]L :llast<CR>
nnoremap [L :lfirst<CR>

nnoremap ]q :cnext<CR>
nnoremap [q :cprev<CR>
nnoremap ]Q :clast<CR>
nnoremap [Q :cfirst<CR>

" ------------------------------------------------------------------------------
" Custom Functionality
" ------------------------------------------------------------------------------
if executable('rg')
    set grepprg=rg\ --vimgrep
endif

command! -nargs=+ -complete=file_in_path -bar Grep silent! grep! <args>
command! -nargs=+ -complete=file_in_path -bar LGrep silent! lgrep! <args>

augroup quickfix
    autocmd!
    autocmd QuickFixCmdPost grep botright cwindow
    autocmd QuickFixCmdPost lgrep botright lwindow
augroup END

nnoremap <leader>g :Grep<Space>

" ------------------------------------------------------------------------------
" Plugins
" ------------------------------------------------------------------------------
call plug#begin("~/.vim/plugged")

Plug 'preservim/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'vimwiki/vimwiki'
Plug 'airblade/vim-gitgutter'
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

if has("nvim")
    Plug 'neoclide/coc.nvim', { 'do': 'yarn install --frozen-lockfile' }
    Plug 'neoclide/coc-tsserver', { 'do': 'yarn install --frozen-lockfile' }
    Plug 'neoclide/coc-tslint-plugin', { 'do': 'yarn install --frozen-lockfile' }
    Plug 'iamcco/coc-diagnostic', { 'do': 'yarn install --frozen-lockfile && yarn build' }
endif

Plug 'HerringtonDarkholme/yats.vim'
Plug 'lervag/vimtex'
Plug 'chooh/brightscript.vim'
Plug 'LnL7/vim-nix'
Plug 'neovimhaskell/haskell-vim'
Plug 'chrisbra/csv.vim'
Plug 'sebdah/vim-delve'

Plug 'icymind/NeoSolarized'
Plug 'robertmeta/nofrils'

call plug#end()


" ------------------------------------------------------------------------------
" Plugin Configuration
" ------------------------------------------------------------------------------

let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

"
" NERDTree
"
map <leader>n :NERDTreeToggle<CR>

let NERDTreeShowBookmarks = 1
let NERDTreeMouseMode = 2

"
" vim-commentary
"
xmap <leader><leader> <Plug>Commentary<CR>
nmap <leader><leader> <Plug>Commentary<CR>
omap <leader><leader> <Plug>Commentary
nmap <leader><leader> <Plug>CommentaryLine<CR>

"
" NeoSolarized
"
let g:neosolarized_contrast = "high"

"
" fzf
"
nmap <C-p> :Files<CR>
nmap <leader>b :Buffers<CR>

let g:fzf_action = {
  \ "ctrl-t": "tab split",
  \ "ctrl-s": "split",
  \ "ctrl-v": "vsplit" }

let g:fzf_colors = {
  \ "fg":      ["fg", "Normal"],
  \ "bg":      ["bg", "Normal"],
  \ "hl":      ["fg", "Comment"],
  \ "fg+":     ["fg", "CursorLine", "CursorColumn", "Normal"],
  \ "bg+":     ["bg", "CursorLine", "CursorColumn"],
  \ "hl+":     ["fg", "Statement"],
  \ "info":    ["fg", "PreProc"],
  \ "border":  ["fg", "Ignore"],
  \ "prompt":  ["fg", "Conditional"],
  \ "pointer": ["fg", "Exception"],
  \ "marker":  ["fg", "Keyword"],
  \ "spinner": ["fg", "Label"],
  \ "header":  ["fg", "Comment"],
  \ }

"
" vimwiki
"
let g:vimwiki_list = [{ "path": "~/wiki/", "syntax": "markdown", "ext": ".md" }]
let g:vimwiki_global_ext = 0

"
" vim-gitgutter
"
let g:gitgutter_map_keys = 0

nmap <leader>hp <Plug>(GitGutterPreviewHunk)
nmap [c <Plug>(GitGutterPrevHunk)
nmap ]c <Plug>(GitGutterNextHunk)

"
" coc.nvim
"

" Use tab to navigate completion lists.
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Use enter to confirm completion.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

nmap <leader>rr <Plug>(coc-rename)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

vmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)

nmap <leader>ac <Plug>(coc-codeaction)
nmap <leader>qf <Plug>(coc-fix-current)

" Perform code action for a selected region.
vmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>CocShowDocumentation()<CR>

" Use `[c` and `]c` to navigate diagnostics.
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

augroup CocGroup
  autocmd!
  " Setup formatexpr specified filetypes.
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')

  " Update signature help on jump to placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" CocList

" Show all diagnostics.
nnoremap <silent> <space>a :<C-u>CocList diagnostics<cr>

" Show commands.
nnoremap <silent> <space>c :<C-u>CocList commands<cr>

" Show document outline.
nnoremap <silent> <space>o :<C-u>CocList outline<cr>

" Do default action for next item.
nnoremap <silent> <space>j :<C-u>CocNext<CR>

" Do default action for previous item.
nnoremap <silent> <space>k :<C-u>CocPrev<CR>

" Resume latest CocList.
nnoremap <silent> <space>p :<C-u>CocListResume<CR>

function! s:CocShowDocumentation()
  if &filetype == "vim"
    execute "h ".expand("<cword>")
  else
    call CocAction("doHover")
  endif
endfunction

"
" vim-pandoc
"
let g:pandoc#modules#disabled = ["folding"]
let g:pandoc#formatting#mode = "h"
let g:pandoc#toc#close_after_navigating = 0
let g:pandoc#keyboard#use_default_mappings = 0

"
" csv.vim
"
let g:csv_autocmd_arrange = 1
let g:csv_no_conceal = 1

" ------------------------------------------------------------------------------
" Post-bundle Loading Configuration
" ------------------------------------------------------------------------------
filetype plugin indent on  " automatically detect file types
colorscheme NeoSolarized
