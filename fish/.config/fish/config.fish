# set EDITOR nvim
# set BROWSER chromium
if status is-interactive

    function fish_user_key_bindings
        # Maps 'tn' in insert mode to switch to normal mode
        bind -M insert tn 'set fish_bind_mode default; commandline -f backward-char repaint-mode'
    end

    # Commands to run in interactive sessions can go here
    zoxide init fish --cmd cd | source
    # zoxide init fish | source
    starship init fish | source
    fzf --fish | source
end
