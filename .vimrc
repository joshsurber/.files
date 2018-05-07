" Basic setup 
set encoding=utf-8
set cindent
"set showcmd
set hidden
set visualbell
set title
set ttyfast
set ruler
set backspace=indent,eol,start
set undofile
set lazyredraw
set showbreak=↪
set splitbelow
set splitright
set autowrite
set shiftround
set autoread
set dictionary=/usr/share/dict/words

" Sane line numbers
set number relativenumber
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Menus in the console
source $VIMRUNTIME/menu.vim
set wildmenu
set cpo-=<
set wcm=<C-Z>
map ;; :emenu <C-Z>

set wildignore+=..git                          " Version control
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg " binary images
set wildignore+=*.pyc                          " Python byte code
set wildignore+=*.sw?,.bak                     " Vim swap files

" Tabs, spaces, wrapping 
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set wrap
set breakindent
set textwidth=80
set formatoptions=qrn1 " Autoformat code comments
filetype plugin indent on

" Leader 
let mapleader = "\<Space>""
map <leader>w :w<cr>
map <leader>q :q<cr>
map <leader>z ZZ
" Folding 
nnoremap <leader><leader> za
vnoremap <leader><leader> za
noremap <leader>/ :noh<cr> 
noremap <leader>l :redraw!<cr> 

" Color scheme 
syntax on
set background=dark
colorscheme solarized

" Searching and movement 
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
set gdefault " Sub command defaults to whole lines

set virtualedit+=block " Rect selections can encompass blank chars

map <tab> %

" Open a Quickfix window for the last search.
nnoremap <silent> <leader>/ :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>

" Fix linewise visual selection of various text objects
nnoremap VV V
nnoremap Vit vitVkoj
nnoremap Vat vatV
nnoremap Vab vabV
nnoremap VaB vaBV

" Easy window navigation
noremap <C-h>  <C-w>h
noremap <C-j>  <C-w>j
noremap <C-k>  <C-w>k
noremap <C-l>  <C-w>l

" Resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="

" K opens vimhelp not manpage
set kp= 

" Faster Esc
inoremap jk <esc>

" Better Completion
set completeopt=longest,menuone,preview 

" Sudo to write
cmap w!! w !sudo tee % >/dev/null 

" Move to end of pasted text; easily select same
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]
noremap gV `[v`]

" Lines wrap. Deal with it.
noremap j gj
noremap k gk

execute pathogen#infect()

" Plugin config below
" CtrlP via http://snow-dev.com/the-power-of-vim-plugins-ctrlp/
let g:ctrlp_map = '<C-p>' 
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ar'
let g:ctrlp_use_caching = 0
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor

    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
else
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
    \ }
endif

" Expand region plugin
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

