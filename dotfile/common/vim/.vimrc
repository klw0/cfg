" ------------------------------------------------------------------------------
" General
" ------------------------------------------------------------------------------

let mapleader="\<Space>"
let maplocalleader="\<Space>"

filetype plugin indent on
syntax enable

set autoread
set encoding=utf-8
set hidden
set mouse=a
set ttimeoutlen=0     " Shorten key sequence timeouts (eliminate delays after hitting ESC)
set ttyfast
set updatetime=125

if has('nvim')
  set inccommand=nosplit  " Show the effects of an Ex command in realtime
endif

set autoindent
set backspace=indent,eol,start
set expandtab
set formatoptions+=j  " Remove a comment leader when joining lines
set nostartofline
set nowrap
set shiftwidth=0
set smarttab
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
set fillchars+=vert:│
set laststatus=2
set nofoldenable
set noshowmode
set number
set ruler
set showcmd
set splitright
set wildmenu
set wildmode=longest:full,full
set wildoptions=pum
set wildignore+=.git/*

set complete+=kspell
set completeopt=menuone,noselect,noinsert
set shortmess+=cF
set shortmess-=S

" thanks arp242
set backupdir=~/.local/share/vim/backup | call mkdir(&backupdir, 'p', 0700)
set directory=~/.local/share/vim/swap | call mkdir(&directory, 'p', 0700)
set undodir=~/.local/share/vim/undo | call mkdir(&undodir, 'p', 0700)
set viewdir=~/.local/share/vim/view | call mkdir(&viewdir, 'p', 0700)
set history=10000
set undofile

set diffopt+=algorithm:histogram,vertical

" XXX: Setting context is a kludge to prevent folding in diff mode (how is
" there not a proper option for this!?).
set diffopt+=context:2147483647,foldcolumn:1

colorscheme klw0

" ------------------------------------------------------------------------------
" Mappings
" ------------------------------------------------------------------------------

" Create the directory containing the file in the buffer
nmap <silent> <leader>md :!mkdir -p %:p:h<CR>

nnoremap <C-L> <Cmd>nohlsearch<Bar>diffupdate<CR><C-L>

inoremap <expr> <Tab> pumvisible() ? "\<C-N>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-P>" : "\<S-Tab>"
inoremap <expr> <CR> pumvisible() ? "\<C-Y>" : "\<C-G>u\<CR>"

nnoremap <leader>e :FuzzyEdit<Space>
nnoremap <leader>b :buffer <C-Z>

nnoremap ]b :bnext<CR>
nnoremap [b :bprev<CR>
nnoremap ]B :blast<CR>
nnoremap [B :bfirst<CR>

nnoremap <leader>d :lwindow<CR><C-W>p
nnoremap ]d :lafter<CR>
nnoremap [d :lbefore<CR>
nnoremap ]D :llast<CR>
nnoremap [D :lfirst<CR>

nnoremap ]l :lafter<CR>
nnoremap [l :lbefore<CR>
nnoremap ]L :llast<CR>
nnoremap [L :lfirst<CR>

nnoremap ]q :cafter<CR>
nnoremap [q :cbefore<CR>
nnoremap ]Q :clast<CR>
nnoremap [Q :cfirst<CR>

noremap <leader>dg :diffget<CR>
noremap <leader>dp :diffput<CR>

nnoremap <leader>n :Lexplore<CR>

let g:attn_strings = {
  \ 'TODO': 'td',
  \ 'FIXME': 'fm',
  \ 'XXX': 'xx',
  \ }

for [g:attn_string, g:attn_map_seq] in items(g:attn_strings)
  let g:attn_id_string = g:attn_string . '(klw0):'

  execute printf('iabbrev %s: %s', g:attn_string, g:attn_id_string)
  execute printf('nnoremap <silent> <leader>%s :call attn#Add("%s", "n")<CR>a',
    \ g:attn_map_seq,
    \ g:attn_id_string,
    \ )
  execute printf('nnoremap <silent> <leader>%s :call attn#Add("%s", "s")<CR>a',
    \ strpart(g:attn_map_seq, 0, 1) . toupper(strpart(g:attn_map_seq, 1)),
    \ g:attn_id_string,
    \ )
  execute printf('nnoremap <silent> <leader>%s :call attn#Add("%s", "w")<CR>a',
    \ toupper(g:attn_map_seq),
    \ g:attn_id_string,
    \ )
endfor

unlet g:attn_strings g:attn_string g:attn_map_seq g:attn_id_string

cnoremap <expr> <C-N> wildmenumode() ? "\<C-N>" : "\<Down>"
cnoremap <expr> <C-P> wildmenumode() ? "\<C-P>" : "\<Up>"

nnoremap <silent> <leader>m :silent make<CR>

" ------------------------------------------------------------------------------
" Custom Functionality
" ------------------------------------------------------------------------------

if executable('rg')
  set grepprg=rg\ --vimgrep
endif

function! s:AbbreviateCommand(cmd, abbrev) abort
  execute printf(
    \ 'cnoreabbrev <expr> %s (getcmdtype() ==# ":" && getcmdline() =~# "^%s")  ? "%s" : "%s"',
    \ a:cmd,
    \ a:cmd,
    \ a:abbrev,
    \ a:cmd)
endfunction

call s:AbbreviateCommand('grep', 'silent! grep!')
nnoremap <leader>g :grep<C-]><Space>
call s:AbbreviateCommand('lgrep', 'silent! lgrep!')
nnoremap <leader>lg :lgrep<C-]><Space>

augroup quickfix
  autocmd!
  autocmd QuickFixCmdPost grep,make botright cwindow
  autocmd QuickFixCmdPost lgrep,lmake botright lwindow
augroup END

augroup autocomplete
  autocmd!
  autocmd InsertCharPre * call s:AutoComplete()
augroup END

function! s:AutoComplete() abort
  if pumvisible() | return | endif
  if &omnifunc ==# '' | return | endif

  if match(v:char, '[A-z]') != -1
    call feedkeys("\<C-X>\<C-O>", 'nti')
  endif
endfunction

" ------------------------------------------------------------------------------
" Packages
" ------------------------------------------------------------------------------

" Personal
packadd stabusline
packadd lsp
packadd diagnostic
packadd write
packadd colors
packadd attn
packadd fuzzy

" Vendor
packadd vim-plug

" ------------------------------------------------------------------------------
" Plugins
" ------------------------------------------------------------------------------

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'vimwiki/vimwiki'
Plug 'airblade/vim-gitgutter'
Plug 'editorconfig/editorconfig-vim'

Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

if has('nvim')
  Plug 'neovim/nvim-lspconfig'
endif

Plug 'lervag/vimtex'
Plug 'chooh/brightscript.vim'
Plug 'chrisbra/csv.vim'
Plug 'sebdah/vim-delve'
Plug 'ledger/vim-ledger'

call plug#end()

" ------------------------------------------------------------------------------
" Plugin Configuration
" ------------------------------------------------------------------------------

let g:netrw_altv = 1
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_liststyle = 3
let g:netrw_winsize = -24

if has('nvim')
" nvim-lspconfig
lua << EOF
local lspconfig = require('lspconfig')

local on_attach = function(client)
  vim.fn["lsp#ConfigureBuffer"](client.resolved_capabilities)
end

local servers = {
  clangd = {},
  efm = {
    filetypes = { "pandoc", "sh" },
  },
  gopls = {},
  jsonls = {},
  sumneko_lua = {},
  sourcekit = {
    filetypes = { "swift", "objective-c" },
  },
  tsserver = {},
  vimls = {
    on_attach = function(client, bufnr)
      on_attach(client)

      -- Remove mappings that are better handled by vim than vim-language-server.
      vim.api.nvim_buf_del_keymap(bufnr, "n", "K")
      vim.api.nvim_buf_del_keymap(bufnr, "n", "gd")
      vim.api.nvim_buf_del_keymap(bufnr, "n", "gD")
      vim.api.nvim_buf_del_keymap(bufnr, "n", "1gD")
    end
  },
}

for server, config in pairs(servers) do
  lspconfig[server].setup(vim.tbl_extend("keep", config, {
    on_attach = on_attach,
    on_exit = vim.call("lsp#UnconfigureBuffer"),
  }))
end
EOF
endif

" vim-commentary
xmap <leader><leader> <Plug>Commentary<CR>
nmap <leader><leader> <Plug>Commentary<CR>
omap <leader><leader> <Plug>Commentary
nmap <leader><leader> <Plug>CommentaryLine<CR>

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
