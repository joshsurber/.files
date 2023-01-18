# Josh's dotfiles

Feel free to inspect these and take what you want from them, but they are designed to make my machine work exactly like I want. You probably do not want to use them as-is unless you happen to be me. Everything below is my hints to myself on setting up a new machine.

## Install the basic apps.

Basic command line utils

```bash
sudo pacman -S bash_completion bat fd fzf git kitty locate make man-db neofetch neovim pkgfile qutebrowser ripgrep starship stow tldr ttf-cascadia-code unzip xclip && sudo pkgfile -u
```

Awesome WM

```bash
sudo pacman -S awesome dmenu nitrogen volumeicon picom ttf-roboto xscreensaver
```

Dev tools

```bash
sudo pacman -S npm pandoc prettier python python-pip shfmt tidy
```

Hardware

```bash
sudo pacman -S blueman cups
```

## Install yay and Chrome

This is the easiest way to install Chrome

```bash
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
yay google-chrome
```

## Post install setup

Next, add in your ssh directory from your keychain drive and run

```bash
gpg dotssh.tgz.gpg
tar xzf dotssh.tgz
mv dotssh .ssh
chmod 0700 ~/.ssh/id_rsa
ssh-keygen -p
```

Finally, clone the dotfiles repo to carry over customizations

```bash
git clone git@github.com:joshsurber/.files.git
cd ~/.files
make
make install
```
