"
" Originally pillaged from janus and spf13, and evolved from there.
"

" ------------------------------------------------------------------------------
" General
" ------------------------------------------------------------------------------
set nocompatible                " Use vim, no vi defaults
let mapleader="\<Space>"
set number                      " Show line numbers
set ruler                       " Show line and column number in stats line
set history=10000               " Store a ton of history
syntax enable                   " Enable syntax highlighting
set encoding=utf-8
set t_ti= t_te=                 " Don't switch to the terminal when running cli commands
set ttimeoutlen=0               " Shorten key sequence timeouts (eliminates delays after hitting ESC)
set mouse=a                     " Enable mouse support in all modes for pane resizing


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
    set laststatus=2  " always show the status bar
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

" Underline the current line with "="
nmap <silent> <leader>ul :t.\|s/./=/g\|:nohls<cr>

" set text wrapping toggles
nmap <silent> <leader>tw :set invwrap<CR>:set wrap?<CR>


" ------------------------------------------------------------------------------
" Filetype specific settings
" ------------------------------------------------------------------------------
au BufNewFile,BufRead *.asm set filetype=asm68k
au FileType python setlocal shiftwidth=4 tabstop=4
au FileType brs setlocal shiftwidth=4 tabstop=4
au FileType yaml setlocal shiftwidth=2 tabstop=2
au FileType ruby setlocal shiftwidth=2 tabstop=2
au FileType vimwiki setlocal textwidth=120


" ------------------------------------------------------------------------------
" Functions
" ------------------------------------------------------------------------------
function! ShortenPath(path)
    if empty(a:path) | return | endif

    let num_ignore_segments = 2
    let separator = "/"
    let segments = split(a:path, separator)

    let shortened_path = a:path
    if len(segments) > 1
        let shortened_segments = map(segments[0:-(num_ignore_segments + 1)], "v:val[0]")
        let ignored_segments = segments[-num_ignore_segments:-1]

        let prefix = a:path[0] == separator ? a:path[0] : ""
        let shortened_path = prefix . join(shortened_segments + ignored_segments, separator)
    endif

    return shortened_path
endfunction


" ------------------------------------------------------------------------------
" Plugins
" ------------------------------------------------------------------------------
call plug#begin("~/.vim/plugged")

Plug 'scrooloose/nerdtree'
Plug 'w0rp/ale'
Plug 'ddollar/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'majutsushi/tagbar'
Plug 'mileszs/ack.vim'
Plug 'itchyny/lightline.vim'
Plug 'icymind/NeoSolarized'
Plug 'vimwiki/vimwiki'

Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

if has("nvim")
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'mhartington/nvim-typescript', { 'do': './install.sh' }
endif

Plug 'leafgarland/typescript-vim'
Plug 'juvenn/mustache.vim'
Plug 'jcf/vim-latex'
Plug 'chooh/brightscript.vim'
" Plug 'iamcco/markdown-preview.vim'

call plug#end()


" ------------------------------------------------------------------------------
" Plugins Configuration
" ------------------------------------------------------------------------------
"
" NerdTree
"
autocmd vimenter * if !argc() | NERDTree | endif
map <leader>n :NERDTreeToggle<CR>

let NERDTreeShowBookmarks=1
let NERDTreeIgnore=["\.pyc", "\~$", "\.o$", "\.swo$", "\.swp$", "\.git","\.hg", "\.svn", "\.bzr"]
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=0
let NERDTreeMouseMode=2
let NERDTreeShowHidden=0

""
" deoplete
""
let g:deoplete#enable_at_startup = 1

"
" NerdCommenter
"
map <leader><leader> <plug>NERDCommenterToggle<CR>

"
" TagBar
"
nnoremap <silent> <leader>tt :TagbarToggle<CR>

"
" ack
"
let g:ackprg = "rg --vimgrep --hidden"

"
" lightline
"
set noshowmode
let g:lightline = {}
let g:lightline.colorscheme = "solarized"
let g:lightline.active = {
    \   "left": [["mode", "paste"],
    \            ["readonly", "filename"],
    \            ["gitbranch"]],
    \   "right": [["linter_warnings", "linter_errors", "lineinfo"],
    \             ["percent"],
    \             ["filetype"]]
    \ }
let g:lightline.tabline = {
    \ "left": [["tabs"]],
    \ "right": [[]],
    \ }
let g:lightline.component_function = {
    \   "filename": "LightlineFilename",
    \   "gitbranch": "LightlineGitbranch"
    \ }
let g:lightline.component_expand = {
    \   "linter_warnings": "LightlineLinterWarnings",
    \   "linter_errors": "LightlineLinterErrors"
    \ }
let g:lightline.component_type = {
    \   "linter_warnings": "warning",
    \   "linter_errors": "error"
    \ }

function! LightlineFilename()
    let filename = expand("%:f") !=# "" ? ShortenPath(expand("%:P")) : "[No Name]"
    let modified = &modified ? " [+]" : ""
    return filename . modified
endfunction

function! LightlineGitbranch()
    return winwidth(0) >= 80 ? fugitive#head() : ""
endfunction

" ale + lightline
autocmd User ALELint call lightline#update()

function! LightlineLinterErrors() abort
  let l:counts = ale#statusline#Count(bufnr(""))
  let l:all_errors = l:counts.error + l:counts.style_error
  return l:all_errors == 0 ? "" : printf("%d >>", all_errors)
endfunction

function! LightlineLinterWarnings() abort
  let l:counts = ale#statusline#Count(bufnr(""))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:all_non_errors == 0 ? "" : printf("%d --", all_non_errors)
endfunction


"
" NeoSolarized
"
let g:neosolarized_vertSplitBgTrans = 0
let g:neosolarized_contrast = "high"

"
" fzf
"
nmap <C-p> :Files<CR>

"
" vimwiki
"
let g:vimwiki_list = [{ "path": "~/wiki/", "syntax": "markdown", "ext": ".md" }]


"
" vim-latex
"
let g:tex_flavor="latex"

"
" markdown-preview
"
nmap <silent> <C-m> <Plug>MarkdownPreview

" ------------------------------------------------------------------------------
" Post-bundle Loading Configuration
" ------------------------------------------------------------------------------
filetype plugin indent on  " automatically detect file types
colorscheme NeoSolarized
