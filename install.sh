#! /bin/bash
# vim: ft=bash fdm=indent wrap

system="base-devel blueman xclip zip bluez bluez-utils cups fuse2 fuse3 git gvfs gvfs-smb make man-db moreutils npm pamixer pkgfile"

XorgWM="arandr autorandr autotiling clipmenu dunst i3 maim picom polybar polybar rofi rofi-calc rofi-emoji rofimoji"

hypr="cliphist hypridle hyprland hyprlock hyprpaper hyprpicker hyprshot swaync waybar wl-clipboard"

apps="brightnessctl chromium eza fish fzf kitty lazygit neovide neovim nitrogen noto-fonts-emoji pcmanfm qutebrowser rclone ripgrep starship stow tldr tmux ttf-cascadia-code-nerd ttf-firacode-nerd ttf-roboto vifm xarchiver xdg-user-dirs zoxide"

has() {
    command -v "$1" 1>/dev/null 2>&1
}
if ! sudo -v; then
    error "Superuser not granted, aborting installation"
    exit 1
fi

if has pacman; then
    install="sudo pacman -S --needed"
    distro="fd bat bat-extras"
elif has apt; then
    install="sudo apt install"
    disto="fdfind batcat"
    curl -sS https://starship.rs/install.sh | sh
fi

$install $system $hypr $apps $distro
git clone --recursive git@github.com:joshsurber/.files
cd .files

if has bat; then
    bat cache --build
elif has batcat; then
    bat cache --build
fi

mkdir -p ~/Google ~/Projects ~/.config/rclone
cat rclone.txt >~/.config/rclone/rclone.conf
xdg-user-dirs-update
# rclone config reconnect drive:

make

echo 'source ~/.bash/source' >>~/.bashrc
echo 'source ~/.bash/profile' >>~/.profile
echo 'source ~/.bash/logout' >>~/.bash_logout

if has pacman && ! has yay; then
    sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
    yay -Y --gendb
    yay -Syu --devel
    yay -Y --devel --save
    cd ..
    rm -rf yay
elif has apt; then
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
    sudo rm -rf /opt/nvim-linux64
    sudo tar -C /opt -xzf nvim-linux64.tar.gz
    rm nvim-linux64.tar.gz
fi
