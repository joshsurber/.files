function yay --description 'A smart wrapper for package management'
# 1. Check if the 'yay' EXECUTABLE exists (ignoring this function)
    if set -l yay_path (command -v yay)
        command $yay_path $argv
        return
    end

    # 2. If pacman exists, install yay
    if type -q pacman
        echo "yay not found. Installing yay via pacman..."
        sudo pacman -S --needed git base-devel
        git clone https://aur.archlinux.org/yay.git /tmp/yay-build
        cd /tmp/yay-build; makepkg -si; cd -
        return
    end

    # 3. Handle APT systems
    if type -q apt
        if count $argv > 0
            echo "Directing traffic to apt install..."
            sudo apt install $argv
        else
            echo "Nothing to install. Updating system instead..."
            sudo apt update && sudo apt upgrade
        end
        return
    end

    # 4. The "Funny Message" exit
    set -l failures "I looked everywhere, but I couldn't find a way to help you. Maybe try 'sudo install-brain'?" "Error 404: Package manager not found. Have you tried turning the computer off and leaving it off?" "I'm a script, not a magician. Get a real package manager!"

    # Pick a random message from the list
    echo $failures[(random 1 (count $failures))]
    return 1
end
