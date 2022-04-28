# ALIASES
alias vi=vim
alias cls="clear;ls"
alias ducks='du -cks *|sort -rn|head -11' # Best named command ever
alias fuck='sudo $(history -p \!\!)' # As in "fuck, I forgot to sudo that command!"
alias fucking=sudo # Make me a sandwich. * No * Fucking make me a sandwich * OK
alias shit='sudo apt install $(history -p \!\!);$(history -p \!\!)' # Command not found? Find it!
alias more='less' # less is more
alias up='cd ..'
alias l='ls -CF' # Some ls aliases
alias la='ls -A'
alias ll='ls -alF'

# ENVIROMENT
export PATH=$PATH
export CDPATH=.:~
export EDITOR=vim
export PAGER=less
export VISUAL=$EDITOR
export HISTIGNORE="&:[ \t]*:ls:[bf]g:exit"
set -o vi
set -o noclobber
shopt -s cdspell
shopt -s histappend
shopt -s extglob
PROMPT_COMMAND='history -a'

# Use fzf
source /usr/share/doc/fzf/examples/key-bindings.bash
source /usr/share/doc/fzf/examples/completion.bash

# FUNCTIONS
cdls() { cd $1; clear; ls;} # Change and list directory after clearing screen
grepdir() { exec "grep -R \"$@\" *"; }
calc(){ awk "BEGIN{ print $* }" ;}
mkcd() { mkdir -p "$*"; cd "$*"; }
lt() { ls -ltrsa "$@" | tail; }
psgrep() { ps axuf | grep -v grep | grep "$@" -i --color=auto; }
fname() { find . -iname "*$@*"; }

# Copy and paste files
ccopy() { for i in $*; do cp -a $i /tmp/ccopy.$i; done }
alias cpaste="ls -d /tmp/ccopy* | sed 's|[^\.]*.\.||' | xargs -I % mv /tmp/ccopy.% ./%"

hist() { # Quick and dirty case-insensitive filtered history command. #{{{
    # "hist" ==> "history"
    # "hist foo" ==> "history | grep -i foo"
    # "hist foo bar" ==> "history | grep -i foo | grep -i bar"
    # etc.
    # Note that quotes are ignored, e.g.
    #   <<<hist "foo bar">>> is equivalent to <<<hist foo bar>>>
    HISTORYCMD="history $@"             # "foo bar" ==> "history foo bar"
    HISTORYCMD="${HISTORYCMD% }"        # "history " ==> "history" (no trailing space)
    eval "${HISTORYCMD// / | grep -i }" # "history foo bar" ==>
    #   "history | grep -i foo | grep -i bar"
} #}}}
cb() { # A shortcut function that simplifies usage of xclip. #{{{
    # - Accepts input from either stdin (pipe), or params.
    # - If the input is a filename that exists, then it
    #   uses the contents of that file.
    # ------------------------------------------------
    local _scs_col="\e[0;32m"; local _wrn_col='\e[1;31m'; local _trn_col='\e[0;33m'
    # Check that xclip is installed.
    if ! type xclip > /dev/null 2>&1; then
        echo -e "$_wrn_col""You must have the 'xclip' program installed.\e[0m"
        # Check user is not root (root doesn't have access to user xorg server)
    elif [[ "$USER" == "root" ]]; then
        echo -e "$_wrn_col""Must be regular user (not root) to copy a file to the clipboard.\e[0m"
    else
        # If no tty, data should be available on stdin
        if ! [[ "$( tty )" == /dev/* ]]; then
            input="$(< /dev/stdin)"
            # Else, fetch input from params
        else
            input="$*"
        fi
        if [ -z "$input" ]; then  # If no input, print usage message.
            echo "Copies a string or the contents of a file to the clipboard."
            echo "Usage: cb <string or file>"
            echo "       echo <string or file> | cb"
        else
            # If the input is a filename that exists, then use the contents of that file.
            if [ -e "$input" ]; then input="$(cat $input)"; fi
            # Copy input to clipboard
            echo -n "$input" | xclip -selection c
            # Truncate text for status
            if [ ${#input} -gt 80 ]; then input="$(echo $input | cut -c1-80)$_trn_col...\e[0m"; fi
            # Print status.
            echo -e "$_scs_col""Copied to clipboard:\e[0m $input"
        fi
    fi
}
# Shortcut to copy SSH public key to clipboard.
alias cb_ssh="cb ~/.ssh/id*.pub" #}}}
x () { # EXPAND ALL THE FILETYPES! eatallthethings.jpg #{{{
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)     echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
} # }}}
# Command line alias to start the browser-sync server
alias serve="browser-sync start --server --files . > /dev/null &"
alias jekl="jekyll serve > /dev/null &"
