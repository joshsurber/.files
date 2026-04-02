function yay --description 'A smart wrapper for package management'
    # 1. Check if the 'yay' executable exists (ignoring this function)
    if set -l yay_path (command -v yay)
        command $yay_path $argv
        return
    end

    # 2. Handle pacman systems
    if type -q pacman
        if count $argv > 0
            sudo pacman -S $argv
        else
            echo "yay not found. Installing yay via pacman..."
            sudo pacman -S --needed git base-devel
            git clone https://aur.archlinux.org/yay.git /tmp/yay-build
            cd /tmp/yay-build; makepkg -si; cd -
        end
        return
    end

    # 3. Handle system updates and installs (apt, brew, npm)
    set -l package_managers
    type -q apt; and set -a package_managers apt
    type -q brew; and set -a package_managers brew
    type -q npm; and set -a package_managers npm

    if count $argv > 0
        if contains apt $package_managers
            echo "Directing to apt install..."
            sudo apt install $argv
        else if contains brew $package_managers
            echo "Directing to brew install..."
            brew install $argv
        else if contains npm $package_managers
            echo "Directing to npm install..."
            npm install -g $argv
        end
    else
        echo "Updating system..."
        if contains apt $package_managers
            echo "Updating apt..."
            sudo apt update && sudo apt upgrade
        end
        if contains brew $package_managers
            echo "Updating brew..."
            brew update && brew upgrade
        end
        if contains npm $package_managers
            echo "Updating npm..."
            npm update -g
        end
    end

    if test (count $package_managers) -eq 0
        set -l failures \
            "I looked everywhere, but I couldn't find a way to help you." \
            "Error 404: Package manager not found." \
            "I'm a script, not a magician. Get a real package manager!"
        echo $failures[(random 1 (count $failures))]
        return 1
    end
end
