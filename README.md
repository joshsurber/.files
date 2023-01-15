Josh's dotfiles
===============

Feel free to inspect these and take what you want from them, but they are designed to make my machine work exactly like I want. They are probably not what you want. Everything below is my hints to myself on setting up a new machine.

Setup
-----

Install the stuff you want.

### Arch based (tested in Manjaro)

Short and sweet since Arch has great repos
``` bash
sudo pacman -S bash_completion bat fd fzf git kitty locate make man-db neofetch neovim pkgfile qutebrowser ripgrep starship stow tldr ttf-cascadia-code unzip xclip xscreensaver
sudo pacman -S npm pandoc prettier python python-pip shfmt tidy
sudo pkgfile -u # To enable command-not-found matches

```

Install yay to access AUR

``` bash
sudo pacman -S yay || sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
```

For my setup of awesomewm:

``` bash
sudo pacman -S awesome dmenu nitrogen volumeicon picom
```

### Debian based (Tested in Mint)

Have to install starship separately since it isn't in the repos. Also getting Neovim from the project site since the repo is outdated.
``` bash
sudo apt install batcat fdfind firefox fzf git kitty neofetch neovim pandoc ripgrep starship stow tidy tldr
curl -sS https://starship.rs/install.sh | sh
curl -sS https://github.com/neovim/neovim/releases/download/stable/nvim.appimage > ~/nvim
mkdir -p ~/.local/bin
chmod a+x ~/nvim
mv ~/nvim ~/.local/bin
```

Next, add in your ssh directory from your keychain drive (this is specific for Josh) and run

``` bash
chmod 0700 ~/.ssh/id_rsa
ssh-keygen -p
```

Finally, clone the repo.

``` bash
git clone git@github.com:joshsurber/.files.git
cd ~/.files
make&&make install
```
