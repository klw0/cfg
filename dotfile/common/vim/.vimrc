" ------------------------------------------------------------------------------
" General
" ------------------------------------------------------------------------------

let mapleader="\<Space>"
let maplocalleader="\<Space>"

filetype plugin indent on
syntax enable

set encoding=utf-8
set hidden
set mouse=a
set ttimeoutlen=0     " Shorten key sequence timeouts (eliminate delays after hitting ESC)
set updatetime=125

if has('nvim')
  set inccommand=nosplit  " Show the effects of an Ex command in realtime
endif

set backspace=indent,eol,start
set expandtab
set formatoptions+=j  " Remove a comment leader when joining lines
set nowrap
set shiftwidth=0
set softtabstop=-1
set tabstop=4
set textwidth=80

set list
set listchars=tab:\ \ ,trail:.,extends:>,precedes:<

set hlsearch
set ignorecase
set incsearch
set smartcase

set background=dark
set laststatus=2
set noshowmode
set number
set ruler
set splitright
set termguicolors

set complete+=kspell
set completeopt+=longest,menuone,noselect
set completeopt-=preview
set shortmess+=c

set backupdir-=.
set history=10000
set undofile

" XXX: Setting context is a kludge to prevent folding in diff mode (how is
" there not a proper option for this!?).
set diffopt+=algorithm:histogram,context:2147483647,foldcolumn:1

" ------------------------------------------------------------------------------
" Mappings
" ------------------------------------------------------------------------------

" Create the directory containing the file in the buffer
nmap <silent> <leader>md :!mkdir -p %:p:h<CR>

" Set text wrapping toggles
nmap <silent> <leader>tw :set invwrap<CR>:set wrap?<CR>

let g:todo_string = 'TODO(klw0):'
iabbrev <expr> TODO: get(g:, 'todo_string')
nnoremap <silent> <leader>td :call todo#Add(g:todo_string)<CR>a

" Clear search highlighting, update the current diff if there is one, and
" clear the screen/redraw.
nnoremap <silent><expr> <C-L> ':nohlsearch' . (&diff ? '\| diffupdate' : '') . '<CR><C-L>'

inoremap <expr> <Tab> pumvisible() ? "\<C-N>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-P>" : "\<S-Tab>"
inoremap <expr> <CR> pumvisible() ? "\<C-Y>" : "\<C-G>u\<CR>"

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
" Packages
" ------------------------------------------------------------------------------

" Personal
packadd stabusline
packadd lsp
packadd write
packadd minsolarized
packadd todo

" Vendor
packadd vim-plug

" ------------------------------------------------------------------------------
" Plugins
" ------------------------------------------------------------------------------

call plug#begin('~/.vim/plugged')

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

if has('nvim')
  Plug 'neovim/nvim-lspconfig'
endif

Plug 'lervag/vimtex'
Plug 'chooh/brightscript.vim'
Plug 'chrisbra/csv.vim'
Plug 'sebdah/vim-delve'

Plug 'robertmeta/nofrils'

call plug#end()

" ------------------------------------------------------------------------------
" Plugin Configuration
" ------------------------------------------------------------------------------

let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

" nvim-lspconfig
lua << EOF
lspconfig = require'lspconfig'

lspconfig.efm.setup{
  filetypes = { 'pandoc', 'sh' }
}
lspconfig.bashls.setup{}
lspconfig.gopls.setup{}
lspconfig.jsonls.setup{}
lspconfig.sumneko_lua.setup{}
lspconfig.vimls.setup{}
EOF

" NERDTree
map <leader>n :NERDTreeToggle<CR>
let NERDTreeShowBookmarks = 1
let NERDTreeMouseMode = 2

" vim-commentary
xmap <leader><leader> <Plug>Commentary<CR>
nmap <leader><leader> <Plug>Commentary<CR>
omap <leader><leader> <Plug>Commentary
nmap <leader><leader> <Plug>CommentaryLine<CR>

" fzf
nmap <leader>e :Files<CR>
nmap <leader>b :Buffers<CR>

let g:fzf_layout = { 'down': '40%' }
let g:fzf_preview_window = ''

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit',
  \ }

let g:fzf_colors = {
  \ 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'],
  \ }

" vimwiki
let g:vimwiki_list = [{ 'path': '~/wiki/', 'syntax': 'markdown', 'ext': '.md' }]
let g:vimwiki_global_ext = 0

" vim-gitgutter
let g:gitgutter_map_keys = 0

nmap <leader>hp <Plug>(GitGutterPreviewHunk)
nmap [c <Plug>(GitGutterPrevHunk)
nmap ]c <Plug>(GitGutterNextHunk)

" vim-pandoc
let g:pandoc#modules#disabled = ['folding']
let g:pandoc#formatting#mode = 'h'
let g:pandoc#toc#close_after_navigating = 0
let g:pandoc#keyboard#use_default_mappings = 0

" vimtex
let g:tex_flavor = 'latex'

" csv.vim
let g:csv_autocmd_arrange = 1
let g:csv_no_conceal = 1

" ------------------------------------------------------------------------------
" Post-plugin configuration
" ------------------------------------------------------------------------------

colorscheme minsolarized
