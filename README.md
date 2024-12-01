# Josh's dotfiles

Feel free to inspect these and take what you want from them, but they are designed to make my machine work exactly like I want. You probably do not want to use them as-is unless you happen to be me. Everything below is my hints to myself on setting up a new machine.

## Add ssh keys

Copy .ssh dir from keychain and run

```bash
mv dotssh ~/.ssh
chmod 0700 ~/.ssh/id_rsa
ssh-keygen -p
```

## Clone the repo

```bash
sudo pacman -S git base-devel
git clone git@github.com:joshsurber/.files
cd .files
```

Validate the software list from pkgs and remove any you don't want to install at this time.

## make

Run `make setup` to:

- Install the software in ./pkgs `make install`
- Symlink the dotfiles `make`
- Setup bash init files to source the custom dotfiles `make link`
- Install yay for accessing the AUR `make yay`

After this you can run `yay google-chrome` or `yay brave-bin` for a browser.
