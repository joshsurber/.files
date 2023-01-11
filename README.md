Josh's dotfiles
===============

Feel free to inspect these and take what you want from them, but they are designed to make my machine work exactly like I want. They are probably not what you want. Everything below is my hints to myself on setting up a new machine.

Setup
-----

Install the stuff you want.

### Arch based (tested in Manjaro)

Short and sweet since Arch has great repos
``` bash
sudo pacman -S bat chromium fd firefox fzf git locate make neovim pandoc python qterminal ripgrep screenfetch starship stow tidy tldr yay
```

If running base Arch or another distro without `yay` in the repos, run this to access AUR:

``` bash
pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
```

### Debian based (Tested in Mint)

Have to install starship seperately since it isn't in the repos. Also getting Neovim from the project site since the repo is outdated.
``` bash
sudo apt install batcat chromium fdfind firefox fzf git neovim pandoc qterminal ripgrep screenfetch starship stow tidy tldr
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
make
echo 'source ~/.bash/source' >> ~/.bashrc
```
You might need to change which lines are commented out based on distro. Hope this makes setting up your next machine a breeze.
