# Josh's dotfiles

Feel free to inspect these and take what you want from them, but they are designed to make my machine work exactly like I want. They are probably not what you want. Everything below is my hints to myself on setting up a new machine.

## Install Arch

These instructions are for setting up a new machine (or reinstalling an old one)

[Install Arch](https://wiki.archlinux.org/title/Installation_guide)
or
[install Arch in the ChromeOS Linux subsystem](https://wiki.archlinux.org/title/Chrome_OS_devices/Crostini).

## Install the basic apps.

Short and sweet since Arch has great repos

```bash
sudo pacman -S bash_completion bat fd fzf git kitty locate make man-db neofetch neovim pkgfile qutebrowser ripgrep starship stow tldr ttf-cascadia-code ttf-roboto unzip xclip xscreensaver
sudo pacman -S npm pandoc prettier python python-pip shfmt tidy
sudo pkgfile -u # To enable command-not-found matches
```

## Install yay to access AUR

This is the easiest way to install Chrome

```bash
sudo pacman -S yay || sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
yay google-chrome
```

## Install awesomewm

Not needed when installing in ChromeOS

```bash
sudo pacman -S awesome dmenu nitrogen volumeicon picom
```

## Post install setup

Next, add in your ssh directory from your keychain drive and run

```bash
chmod 0700 ~/.ssh/id_rsa
ssh-keygen -p
```

Finally, clone the dotfiles repo to carry over customizations

```bash
git clone git@github.com:joshsurber/.files.git
cd ~/.files
make&&make install
```
