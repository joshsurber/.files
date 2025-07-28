function fish_user_key_bindings
    # Remap vi normal mode movement keys for Colemak
    bind -M default n down-or-search
    bind -M default e up-or-search
    bind -M default i forward-char
    bind -M default j 'set fish_cursor_end_mode exclusive' forward-single- │ char forward-word backward-char 'set fish_cursor_end_mode inclusive'
    bind -M default k fish_commandline_up_history
    bind -M default l -m insert repaint-mode
    bind -M default J 'set fish_cursor_end_mode exclusive' forward-single- │ char forward-bigword backward-char 'set fish_cursor_end_mode inclusive'
    bind -M default L -m insert beginning-of-line repaint-mode

    # You may also want to remap other common Vim commands like 'w', 'b', etc.
    # based on your specific Colemak layout and preferences.
end
