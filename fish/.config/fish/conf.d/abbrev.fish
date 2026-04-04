# Package managers
abbr i 'sudo apt install'
abbr b 'brew install'
abbr nad 'npx astro dev'
abbr nab 'npx astro build'
abbr nap 'npx astro preview'

# Utilities
abbr cat bat
abbr f fd
abbr find fd
abbr grep rg
abbr o xdg-open
abbr v nvim
abbr y yazi
abbr serve live-server
abbr lamp 'sudo /opt/lampp/lampp'
abbr keyedit 'sudoedit /etc/keyd/default.conf && sudo keyd reload'
abbr ducks 'du -cks * | sort -rn | head -11'

# File listing (using eza if available)
if type -q eza
    abbr ls eza
    abbr ll 'eza -l'
    abbr la 'eza -a'
    abbr lla 'eza -la'
    abbr lt 'eza --tree'
else
    abbr ll 'ls -l'
    abbr la 'ls -a'
    abbr lla 'ls -la'
end

# Git shortcuts
abbr g git
abbr gs 'git status'
abbr ga 'git add'
abbr gc 'git commit'
abbr gp 'git push'
abbr gl 'git log --oneline --graph --decorate'

# Navigation
function multicd
    echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
end
abbr --add dotdot --regex '^\.\.+$' --function multicd

# Kitty specific
if test "$TERM" = xterm-kitty
    abbr theme 'kitty +kitten themes'
    abbr ssh 'kitty +kitten ssh'
end
