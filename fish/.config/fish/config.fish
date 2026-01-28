# set EDITOR nvim
# set BROWSER chromium
if status is-interactive
    # Commands to run in interactive sessions can go here
    zoxide init fish --cmd cd | source
    # zoxide init fish | source
    starship init fish | source
    fzf --fish | source
end
eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
