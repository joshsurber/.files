" Personal vimrc from Josh Surber http://github.com/joshsurber
"
" Plugins managed by vim-plug, :PlugInstall/:PlugUpdate
"
" Leader is spacebar
"
" Basic setup {{{
set encoding=utf-8
set cindent
set showcmd     " Show last :cmd in statusline
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
filetype plugin indent on   " indenting is adding spaces after all

" }}}
" Sane line numbers{{{
set number relativenumber

augroup numbertoggle
    " Use relative numbers only in the active buffer
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" }}}
" Menus in the console{{{
" This will duplicate the same menus used in gVim, by pressing space,semicolon
source $VIMRUNTIME/menu.vim
set wildmenu
set wildmode=list:longest,full
set cpo-=<
set wcm=<C-Z>
map <leader>; :emenu <C-Z>

set wildignore+=..git                          " Version control
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg " binary images
set wildignore+=*.pyc                          " Python byte code
set wildignore+=*.sw?,.bak                     " Vim swap files

" }}}
" Leader {{{
let mapleader = "\<Space>""
map <leader>w :w<cr>    " write
map <leader>q :q<cr>    " quit
map <leader>z ZZ        " quit and close

noremap <leader>\ :noh<cr>      " remove search highlighting
noremap <leader>l :redraw!<cr>  " recover borked terminal

nnoremap <leader><leader> za " double space to expand/colapse
vnoremap <leader><leader> za " the fold under the cursor
" }}}
" Windows and tabs{{{
" Window navigation
noremap <C-h>  <C-w>h
noremap <C-j>  <C-w>j
noremap <C-k>  <C-w>k
noremap <C-l>  <C-w>l

" Disable arrow movement, resize splits instead.
nnoremap <Up>    :resize +2<CR>
nnoremap <Down>  :resize -2<CR>
nnoremap <Left>  :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>

" Resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="

"}}}
" Text navigaion{{{
" Searching and movement 
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch    " highlight search results, leader\ set elsewhere to remove
set gdefault    " Sub command defaults to whole lines

" Lines wrap. Deal with it.
" (move up and down with visual lines rather than "proper" lines
noremap j gj
noremap k gk

map <tab> % " find matching brace etc with tab

" Open a Quickfix window for the last search.
nnoremap <silent> <leader>/ :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>

"}}}
" Selection{{{
set virtualedit+=block " Rect selections can encompass blank chars

" Fix linewise visual selection of various text objects
nnoremap VV V
nnoremap Vit vitVkoj
nnoremap Vat vatV
nnoremap Vab vabV
nnoremap VaB vaBV

"}}}
" Inserting, editing, and saving {{{
" Move to end of pasted text; easily select same
vnoremap <silent> y y`] " Move to end when yanking
vnoremap <silent> p p`] " Move to end when pasting
nnoremap <silent> p p`]
noremap gV `[v`]        " gV will select all pasted text

cmap w!! w !sudo tee % >/dev/null " No write permission? Fuck you, do it anyway!

"}}}
" Filetype specific{{{
au BufRead $MYVIMRC set fdm=marker " Use folds in this file

"}}}
" Misc{{{
set kp= " K opens vimhelp not manpage

inoremap jk <esc> " Faster Esc

set completeopt=longest,menuone,preview " Better Completion

"}}}
" Plugin install {{{
" Download and install vim-plug (cross platform).
if empty(glob(
    \ '$HOME/' . (has('win32') ? 'vimfiles' : '.vim') . '/autoload/plug.vim'))
  execute '!curl -fLo ' .
    \ (has('win32') ? '\%USERPROFILE\%/vimfiles' : '$HOME/.vim') . 
    \ '/autoload/plug.vim --create-dirs ' .
    \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'honza/vim-snippets'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-liquid'
Plug 'altercation/vim-colors-solarized'
Plug 'NLKNguyen/papercolor-theme'       " colorscheme
" Plug 'ervandew/supertab'                " more powerful Tab
" Plug 'tpope/vim-unimpaired'             " pairs of helpful shortcuts
" Plug 'tpope/vim-vinegar'                " - to open netrw
" Plug 'vim-scripts/Gundo'                " visualize the undo tree
Plug 'kien/ctrlp.vim'
Plug 'terryma/vim-expand-region'
" Plug 'docunext/closetag.vim'
" Plug 'vim-scripts/ScrollColors'
" Plug 'flazz/vim-colorschemes' 
call plug#end()
packadd! matchit
" }}}
" Plugin configuration{{{
" Netrw : emulate NERDtree {{{
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
nmap <silent> <C-e> :Lexplore<CR>
" }}}
" CtrlP{{{
let g:ctrlp_map = '<C-p>' 
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ar'
let g:ctrlp_use_caching = 0
let g:ctrlp_custom_ignore = 'node_modules\|^.git$\|_site'
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
else
    let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
    let g:ctrlp_prompt_mappings = {
                \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
                \ }
endif
"}}}
" Expand region{{{
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)
"}}}
" Color scheme {{{
syntax on
set background=dark
colorscheme solarized
if !has('gui_running')
    set t_Co=256
endif
"}}}
" Airline{{{
" let g:airline_theme='solarized'
" let g:airline_solarized_bg='dark'
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
"}}}
" GitGutter{{{
set signcolumn=yes
"}}}
" }}}
