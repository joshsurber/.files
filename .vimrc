" Pretty much this entire file is stolen from Steve Losh
" Info about this is at http://j.mp/v9JYIO
" Basic setup {{{

set encoding=utf-8
set cindent
set showmode
set showcmd
set hidden
set visualbell
set title
set title
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set number
set relativenumber
set laststatus=2
set history=1000
set undofile
set lazyredraw
set matchtime=3
set showbreak=↪
set splitbelow
set splitright
set fillchars=diff:\
set ttimeout
set notimeout
set nottimeout
set autowrite
set shiftround
set autoread
set dictionary=/usr/share/dict/words
set nobackup " dont need backups with infinite undo
set noswapfile
"}}}
" Wildmenu completion {{{

source $VIMRUNTIME/menu.vim
set wildmenu
set wildmode=list:longest
set cpo-=<
set wcm=<C-Z>
map <F4> :emenu <C-Z>
map <leader>- :emenu <C-Z>

set wildignore+=..git                          " Version control
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg " binary images
set wildignore+=*.pyc                          " Python byte code
set wildignore+=*.sw?,.bak                     " Vim swap files

" }}}
" Tabs, spaces, wrapping {{{

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set wrap
set breakindent
set textwidth=80
set formatoptions=qrn1 " Autoformat code comments
filetype plugin indent on
"packadd! matchit

" }}}
" Leader {{{

let mapleader = "\<Space>""
let maplocalleader = "\\"
map <leader>w :w<cr>
map <leader>q :q<cr>
map <leader>z ZZ

" }}}
" Color scheme {{{

syntax on
set background=dark
colorscheme solarized

" }}}
" Searching and movement {{{

" Use sane regexes.
nnoremap / /\v
vnoremap / /\v

set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
set gdefault " Sub command defaults to whole lines

set virtualedit+=block " Rect selections can encompass blank chars

noremap <leader>. :noh<cr> 
" fixme :call clearmatches()<cr>

map <tab> %

" Open a Quickfix window for the last search.
nnoremap <silent> <leader>/ :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>

" Fix linewise visual selection of various text objects
nnoremap VV V
nnoremap Vit vitVkoj
nnoremap Vat vatV
nnoremap Vab vabV
nnoremap VaB vaBV

" }}}
" Folding {{{

set foldlevelstart=0
set foldcolumn=3
set foldmethod=marker

" Space to toggle folds.
nnoremap <leader><leader> za
vnoremap <leader><leader> za

function! MyFoldText() " {{{
let line = getline(v:foldstart)

let nucolwidth = &fdc + &number * &numberwidth
let windowwidth = winwidth(0) - nucolwidth - 3
let foldedlinecount = v:foldend - v:foldstart

" expand tabs into spaces
let onetab = strpart('          ', 0, &tabstop)
let line = substitute(line, '\t', onetab, 'g')

let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction " }}}
set foldtext=MyFoldText()

" }}}
" Windows and buffers {{{
" Easy buffer navigation
noremap <C-h>  <C-w>h
noremap <C-j>  <C-w>j
noremap <C-k>  <C-w>k
noremap <C-l>  <C-w>l
" Resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="
" }}}
" Destroy infuriating keys {{{
" Fuck you, help key.
noremap  <F1> <nop>
inoremap <F1> <nop>
" Fuck you too, manual key.
nnoremap K <nop>
" Stop it, hash key.
inoremap # X<BS>#
" Fuck off, stupid window
map q: :q
" }}}
" Convenience mappings {{{

" Faster Esc
inoremap jk <esc>

" Better Completion
set completeopt=longest,menuone,preview

" Sudo to write
cmap w!! w !sudo tee % >/dev/null

" Insert Mode Completion
inoremap <c-l> <c-x><c-l>
inoremap <c-f> <c-x><c-f>

" Move to end of pasted text; easily select same
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]
noremap gV `[v`]

" Lines wrap. Deal with it.
noremap j gj
noremap k gk

" }}}
execute pathogen#infect()
set runtimepath^=~/.vim/bundle/ctrlp.vim

