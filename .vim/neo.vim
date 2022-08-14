set nocompatible                " not compatible with Vi
filetype plugin indent on       " mandatory for modern plugins
syntax on                       " enable syntax highlighting
set autoindent                  " copy indent from the previous line
set autoread                    " reload from disk
set backspace=indent,eol,start  " modern backspace behavior
set belloff=all                 " disable the bell
set cscopeverbose               " verbose cscope output
set complete-=i                 " don't scan current on included
" files for completion
" set display=lastline,msgsep     " display more message text
set encoding=utf-8              " set default encoding
" set fillchars=vert:|,fold:      " separator characters
set formatoptions=tcqj          " more intuitive autoformatting
set fsync                       " call fsync() for robust file saving
set history=10000               " longest possible command history
set hlsearch                    " highlight search results
set incsearch                   " move cursor as you type when searching
set langnoremap                 " helps avoid mappings breaking
set laststatus=2                " always display a status line
set listchars=tab:>\ ,trail:-,nbsp:+  " chars for :list
set nrformats=bin,hex           " <c-a> and <c-x> support
set ruler                       " display current line # in a corner
set sessionoptions-=options     " do not carry options across sessions
set shortmess=F                 " less verbose file info
set showcmd                     " show last command in the status line
set sidescroll=1                " smoother sideways scrolling
set smarttab                    " tab setting aware <Tab> key
set tabpagemax=50               " maximum number of tabs open by -p flag
set tags=./tags;,tags           " filenames to look for the tag command
set ttimeoutlen=50              " ms to wait for next key in a sequence
set ttyfast                     " indicates that our connection is fast
set viminfo+=!                  " save global variables across sessions
set wildmenu                    " enhanced command line completion
