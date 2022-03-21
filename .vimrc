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
set hidden      " Allow unsaved buffers in background
set visualbell  " Flash instead of beep
set title       " Automatically set term title to filename
set ttyfast     " Update screen faster
set ruler       " Display location in file
set backspace=indent,eol,start " Make BS key normal
set undofile    " Save undos
set lazyredraw  " Don't redraw screen while executing macros
set showbreak=↪ " Indicator at the start of wrapped lines
set splitbelow  " New split will be under current one
set splitright  " New vsplit will be to right of current one
set autowrite   " Write when moving buffer to background
set autoread    " When an unedited file is modified outside Vim, reload it
set cursorline  " Highlight current line
set spell       " Spellcheck by default
set dictionary=/usr/share/dict/words

" }}}
" Tabs, spaces, wrapping {{{
set tabstop=4       " Number of spaces a tab counts for
set shiftwidth=4    " Number of spaces to expand tab to during autoindent
set softtabstop=4   " Insert spaces instead of tabs when typing
set expandtab       " Insert spaces instead of tabs during indents
set wrap            " Wrap long lines
set linebreak       " ... but not in the middle of a word
set breakindent     " wrapped lines will maintain indent level
set textwidth=80    " Stay within 80 columns wide. Obsolete? You be the judge!
set formatoptions=qrn1 " Autoformat code comments
set shiftround      " Round indent to multiple of shiftwidth
filetype plugin indent on   " indenting is adding spaces after all

" }}}
" Sane line numbers{{{
set number relativenumber " Current line actual line number, other relative to cursor

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
set wildmenu        " Use menus for CLI completion
set wildmode=list:longest,full " Expand as much as possible, then show the list
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
noremap <leader>w :w<cr>
noremap <leader>q :q<cr>
noremap <leader>z ZZ

noremap <leader>l :redraw!<cr>  " recover borked terminal

nnoremap <leader><leader> za " double space to expand/colapse
vnoremap <leader><leader> za " the fold under the cursor
" }}}
" Windows and tabs{{{
" Control+HJKL navigates windows
noremap <C-h>  <C-w>h
noremap <C-j>  <C-w>j
noremap <C-k>  <C-w>k
noremap <C-l>  <C-w>l

" Resize splits with arrows. They don't serve any other purpose, right?
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
set ignorecase  " Case insensitive searching
set smartcase   " ... unless search includes uppercase letters
set incsearch   " Show matches as you type
set showmatch   " Highlight matching brackets as you type
set hlsearch    " highlight search results, leader\ set elsewhere to remove
set gdefault    " Sub command defaults to whole lines

noremap ,/ :noh<cr>      " remove search highlighting

" " Lines wrap. Deal with it...
noremap j gj
noremap k gk

" find matching brace etc with tab
map <tab> %

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
vnnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]
noremap gV `[v`]

cmap w!! w !sudo tee % >/dev/null " No write permission? Fuck you, do it anyway!

"}}}
" Filetype specific{{{
au BufRead $MYVIMRC set fdm=marker " Use folds in this file

"}}}
" Misc{{{
set kp= " K opens vimhelp not manpage

inoremap jk <esc> " Faster Esc

set completeopt=longest,menuone,preview " Better Completion

cmap w!! w !sudo tee % >/dev/null " No write permission? Fuck you, do it anyway!

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

packadd! matchit    " Install matchit
call plug#begin()
" Plug 'docunext/closetag.vim'
Plug 'kien/ctrlp.vim'
" Plug 'vim-scripts/Gundo'                " visualize the undo tree
Plug 'NLKNguyen/papercolor-theme'       " colorscheme
" Plug 'vim-scripts/ScrollColors'
" Plug 'ervandew/supertab'                " more powerful Tab
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'altercation/vim-colors-solarized'
Plug 'flazz/vim-colorschemes'
Plug 'tpope/vim-commentary'
Plug 'terryma/vim-expand-region'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-liquid'
Plug 'tpope/vim-repeat'
" Plug 'honza/vim-snippets'
Plug 'tpope/vim-surround'
" Plug 'tpope/vim-unimpaired'             " pairs of helpful shortcuts
" Plug 'tpope/vim-vinegar'                " - to open netrw
call plug#end()

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
colorscheme solarized8_dark
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
" set signcolumn=yes
set updatetime=500  " update twice a second
"}}}
" }}}
