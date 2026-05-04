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

# Type 't' to jump into a project session
function t
    set -l session (sesh list -i | fzf)
    if test -n "$session"
        sesh connect $session
    end
end


# Interactive Desktop Chooser (Enter = i3)
if status is-interactive; and test -z "$DISPLAY"; and test (tty) = /dev/tty1
    echo ---------------------------
    echo "  Select a Session:"
    echo "  1) i3wm (Default - Press Enter)"
    echo "  2) XFCE"
    echo "  3) Stay in Console"
    echo ---------------------------

    read -l choice -p 'echo "Choice [1-3]: "'

    # If $choice is empty or "1", launch i3
    if test -z "$choice"; or test "$choice" = 1
        exec startx /usr/bin/i3
    else if test "$choice" = 2
        exec startx /usr/bin/startxfce4
    else if test "$choice" = 3
        echo "Welcome to the console."
    else
        echo "Invalid choice, staying in console."
    end
end
