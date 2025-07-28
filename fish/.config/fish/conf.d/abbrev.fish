abbr cat bat
abbr f fd
abbr find fd
abbr grep rg
abbr ls eza
abbr o xdg-open
abbr v nvim
abbr i sudo pacman -S
abbr ll 'ls -l'
abbr la 'ls -a'
abbr lla 'ls -la'
abbr serve live-server
abbr lamp sudo /opt/lampp/lampp
abbr drive 'rclone mount drive: ~/Google --daemon'
abbr keyd 'sudoedit /etc/keyd/default.conf && sudo keyd reload'
abbr ducks 'du -cks *|sort -rn|head -11'
function multicd
    echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
end
abbr --add dotdot --regex '^\.\.+$' --function multicd
if test $TERM = xterm-kitty
    abbr theme kitty +kitten themes
    abbr ssh kitty +kitten ssh
end
