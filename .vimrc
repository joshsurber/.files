" Pretty much this entire file is stolen from Steve Losh
" Info about this is at http://j.mp/v9JYIO
" Basic setup {{{

set encoding=utf-8
set modelines=0
set autoindent
set cindent
set showmode
set showcmd
set hidden
set visualbell
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set number
set relativenumber
set laststatus=2
set history=1000
set undofile
set undoreload=10000
set cpoptions+=J
set shell=/bin/bash
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
set wildignore+=*.sw?                          " Vim swap files


" }}}
" Tabs, spaces, wrapping {{{

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set wrap
set textwidth=80
set formatoptions=qrn1
set colorcolumn=+1

" }}}
" Leader {{{

let mapleader = "\<Space>""
let maplocalleader = "\\"

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
set gdefault

set scrolloff=3
set sidescroll=1
set sidescrolloff=10

set virtualedit+=block

noremap <leader>. :noh<cr>:call clearmatches()<cr>

runtime macros/matchit.vim
map <tab> %

" Made D behave
nnoremap D d$

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" Don't move on *
nnoremap * *<c-o>

" Same when jumping around
nnoremap g; g;zz
nnoremap g, g,zz

" Easier to type, and I never use the default behavior.
noremap H ^
noremap L $

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
noremap <leader>v <C-w>v
noremap <leader>h <C-w>h
noremap <leader>j <C-w>j
noremap <leader>k <C-w>k
noremap <leader>l <C-w>l
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
" Various filetype-specific stuff {{{
" CSS and LessCSS {{{

augroup ft_css
au!

au BufNewFile,BufRead *.less setlocal filetype=less

au Filetype less,css setlocal foldmethod=marker
au Filetype less,css setlocal foldmarker={,}
au Filetype less,css setlocal omnifunc=csscomplete#CompleteCSS
au Filetype less,css setlocal iskeyword+=-

" Use <leader>S to sort properties.  Turns this:
"
"     p {
"         width: 200px;
"         height: 100px;
"         background: red;
"
"         ...
"     }
"
" into this:

"     p {
"         background: red;
"         height: 100px;
"         width: 200px;
"
"         ...
"     }
au BufNewFile,BufRead *.less,*.css nnoremap <buffer> <localleader>S ?{<CR>jV/\v^\s*\}?$<CR>k:sort<CR>:noh<CR>

" Make {<cr> insert a pair of brackets in such a way that the cursor is correctly
" positioned inside of them AND the following code doesn't get unfolded.
au BufNewFile,BufRead *.less,*.css inoremap <buffer> {<cr> {}<left><cr><space><space><space><space>.<cr><esc>kA<bs>
augroup END

" }}}
" HTML and HTMLDjango {{{

augroup ft_html
au!

au BufNewFile,BufRead *.html setlocal filetype=htmldjango
au FileType html,jinja,htmldjango setlocal foldmethod=manual

" Use <localleader>f to fold the current tag.
au FileType html,jinja,htmldjango nnoremap <buffer> <localleader>f Vatzf

" Use Shift-Return to turn this:
"     <tag>|</tag>
"
" into this:
"     <tag>
"         |
"     </tag>
au FileType html,jinja,htmldjango nnoremap <buffer> <s-cr> vit<esc>a<cr><esc>vito<esc>i<cr><esc>

augroup END

" }}}
" Javascript {{{

augroup ft_javascript
au!

au FileType javascript setlocal foldmethod=marker
au FileType javascript setlocal foldmarker={,}
augroup END

" }}}
" PHP/ {{{
augroup js_php
    au!
    au FileType php setlocal makeprg=php\ -l\ %
augroup END
" }}}
" }}}
" Convenience mappings {{{

" Clean whitespace
map <leader>W  :%s/\s\+$//<cr>:let @/=''<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>z ZZ<CR>

" Substitute
nnoremap <leader>s :%s//<left>

" Faster Esc
inoremap jk <esc>

" Marks and Quotes
noremap ' `
noremap æ '
noremap ` <C-^>

" Better Completion
set completeopt=longest,menuone,preview

" Sudo to write
cmap w!! w !sudo tee % >/dev/null

" I suck at typing.
nnoremap <localleader>= ==

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
