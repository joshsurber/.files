# ~/.config/fish/functions/sweep.fish

function sweep
    switch $argv[1]
        case left
            make ferris/sweep:mine:avrdude-split-left
        case l
            make ferris/sweep:mine:avrdude-split-left
        case right
            make ferris/sweep:mine:avrdude-split-right
        case r
            make ferris/sweep:mine:avrdude-split-right
        case ''
            make ferris/sweep:mine
        case '*'
            echo "Usage: sweep [left|right]"
            return 1
    end
end
