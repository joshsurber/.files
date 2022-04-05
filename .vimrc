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
set scrolloff=5 " Keep context on screen
set updatetime=300  " update twice a second
set dictionary=/usr/share/dict/words

" Time out on key codes but not mappings.
" Basically this makes terminal Vim work sanely.
set notimeout
set ttimeout
set ttimeoutlen=100

set noswapfile  " How often does Vim crash anyway?
set nobackup
set nowritebackup
set nowb

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

" highlight trailing whitespace
match ErrorMsg '\s\+$'
" " remove trailing whitespaces automatically
autocmd BufWritePre * :%s/\s\+$//e

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

" Simple write and quit
noremap <leader>w :w<cr>
noremap <leader>qq :q<cr>
noremap <leader>z ZZ

" recover borked terminal
noremap <leader>l :redraw!<cr>

" Toggle folds easily
nnoremap <leader><leader> za
vnoremap <leader><leader> za

" Edit and source .vimrc simply
nnoremap <leader>ve :edit $MYVIMRC<cr>
nnoremap <leader>vs :source $MYVIMRC<cr>

" }}}
" Windows and tabs{{{
" Control+HJKL navigates windows
noremap <C-h>  <C-w>h
noremap <C-j>  <C-w>j
noremap <C-k>  <C-w>k
noremap <C-l>  <C-w>l

" Resize splits with arrows. They don't serve any other purpose, right?
" Commented to see if it is why I have trouble with COC lists
" nnoremap <Up>    :resize +2<CR>
" nnoremap <Down>  :resize -2<CR>
" nnoremap <Left>  :vertical resize +2<CR>
" nnoremap <Right> :vertical resize -2<CR>

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

" Move visual selection
vnoremap <c-j> :m '>+1<CR>gv=gv
vnoremap <c-k> :m '<-2<CR>gv=gv
"
"}}}
" Inserting, editing, and saving {{{
" Move to end of pasted text; easily select same
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]
noremap gV `[v`]

" System clipboard commands
set clipboard=unnamed       " Use system clipboard to yank and put
" vmap <Leader>y "+y        " None of the rest matters because of the above
" vmap <Leader>d "+d        " Will delete if no issues arrive from using system cb
" nmap <Leader>p "+p
" nmap <Leader>P "+P
" vmap <Leader>p "+p
" vmap <Leader>P "+P

"}}}
" Filetype specific{{{
au BufRead $MYVIMRC set fdm=marker " Use folds in this file

" Simplify navigaion of vim help
autocmd FileType help nnoremap <buffer> <CR> <C-]>
autocmd FileType help nnoremap <buffer> <BS> <C-T>
autocmd FileType help nnoremap <buffer> o /'\l\{2,\}'<CR>
autocmd FileType help nnoremap <buffer> O ?'\l\{2,\}'<CR>
autocmd FileType help nnoremap <buffer> s /\|\zs\S\+\ze\|<CR>
autocmd FileType help nnoremap <buffer> S ?\|\zs\S\+\ze\|<CR>

" Make sure all markdown files have the correct filetype set and setup wrapping
" au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} setf markdown | call s:setupWrapping()

" Treat JSON files like JavaScript
au BufNewFile,BufRead *.json setf javascript

" magic markers: enable using `H/S/J/C to jump back to
" last HTML, stylesheet, JS or Ruby code buffer
au BufLeave *.{erb,html}      exe "normal! mH"
au BufLeave *.{css,scss,sass} exe "normal! mS"
au BufLeave *.{js,coffee}     exe "normal! mJ"
au BufLeave *.{rb}            exe "normal! mC"
"}}}
" Misc{{{
set kp= " K opens vimhelp not manpage

inoremap jk <esc> " Faster Esc

set completeopt=longest,menuone,preview " Better Completion

cmap w!! w !sudo tee % >/dev/null " No write permission? Fuck you, do it anyway!

" expand %% to current directory in command-line mode
cnoremap %% <C-R>=expand('%:h').'/'<cr>
"}}}
" Plugin install {{{
" Setup for Vim Plug .{{{
" Download and install vim-plug (cross platform)
if empty(glob(
            \ '$HOME/' . (has('win32') ? 'vimfiles' : '.vim') . '/autoload/plug.vim'))
    execute '!curl -fLo ' .
                \ (has('win32') ? '\%USERPROFILE\%/vimfiles' : '$HOME/.vim') .
                \ '/autoload/plug.vim --create-dirs ' .
                \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
            \| PlugInstall --sync | source $MYVIMRC
            \| endif

"}}}

packadd! matchit    " Install matchit
let g:ale_completion_enabled = 1
call plug#begin()

" Plug 'NLKNguyen/papercolor-theme'       " colorscheme
" Plug 'altercation/vim-colors-solarized'
" Plug 'dense-analysis/ale'
" Plug 'docunext/closetag.vim'
" Plug 'ervandew/supertab'                " more powerful Tab
" Plug 'honza/vim-snippets'
" Plug 'mattn/emmet-vim'                  " Expand CSS selector to HTML with CtrlY, avail in coc
" Plug 'tpope/vim-unimpaired'             " pairs of helpful shortcuts
" Plug 'vim-scripts/Gundo'                " visualize the undo tree
" Plug 'vim-scripts/ScrollColors'
Plug 'AndrewRadev/tagalong.vim'         " Modify HTML tags in pairs
Plug 'Yggdroot/indentLine'              " Make indents easier to follow
Plug 'airblade/vim-gitgutter'           " Keep track of changes in git
Plug 'flazz/vim-colorschemes'
Plug 'frazrepo/vim-rainbow'
Plug 'jiangmiao/auto-pairs'             " Automatically close braces
Plug 'junegunn/vim-plug'                " Obviously installed already, but this provides docs
Plug 'kien/ctrlp.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'terryma/vim-expand-region'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-liquid'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'          " Updated statusline
Plug 'vim-airline/vim-airline-themes'   " Just like it sounds

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
" augroup ProjectDrawer
"   autocmd!
"   autocmd VimEnter * :Vexplore
" augroup END
" }}}
" CtrlP{{{
let g:ctrlp_map = '<C-p>'
let g:ctrlp_cmd = 'CtrlP'
" let g:ctrlp_working_path_mode = 'ar'
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
colorscheme gruvbox "solarized8_dark
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
" Vim rainbow{{{
let g:rainbow_active = 1
"}}}
"" Ale {{{
"let g:ale_completion_enabled = 1
"set omnifunc=ale#completion#OmniFunc
""}}}
" Tagalong {{{
let g:tagalong_verbose = 1
"}}}
"" Emmet {{{
""enable all function in all mode.
"let g:user_emmet_mode='a'
"" enable just for html/css
"let g:user_emmet_install_global = 0
"autocmd filetype html,css
""}}}
" Indent line {{{
let g:indentLine_fileTypeExclude = ['help']
"}}}
" CoC{{{

" Install my preferred subset of extensions
abbr CocInstallall CocInstall coc-css coc-emmet coc-eslint coc-highlight coc-html coc-marketplace coc-prettier coc-sh coc-sql coc-tslint coc-tsserver;

" Use prettier to format a file, possibly superfluous to Format
" command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument

" EVERYTHING BELOW IS COPIED DIRECTLY FROM THE COC README FILE

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
" if has("nvim-0.5.0") || has("patch-8.1.1564")
"     " Recently vim can merge signcolumn and number column into one
"     set signcolumn=number
" else
"     set signcolumn=yes
" endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
else
    inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . " " . expand('<cword>')
    endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
    nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
    inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
    vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
" nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
"}}}
" }}}
