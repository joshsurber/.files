# Josh's dotfiles

Feel free to inspect these and take what you want from them, but they are designed to make my machine work exactly like I want. You probably do not want to use them as-is unless you happen to be me. Everything below is my hints to myself on setting up a new machine.

## Add ssh keys

Copy .ssh dir from keychain and run

```bash
mv dotssh ~/.ssh
chmod 0700 ~/.ssh/id_rsa
```

## Clone the repo

```bash
curl -sS https://raw.githubusercontent.com/joshsurber/.files/refs/heads/master/install.sh | sh
```
