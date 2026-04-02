set -gx EDITOR nvim
set -gx BROWSER chromium

if status is-interactive
    # Commands to run in interactive sessions can go here
    set -g fish_greeting ""

    # Tools initialization
    zoxide init fish --cmd cd | source
    starship init fish | source
    fzf --fish | source

    # Key bindings
    # Tab completion is usually standard, but keeping this for explicit control
    bind \t complete
end
