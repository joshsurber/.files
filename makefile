all:
	stow --verbose --target=$$HOME --restow */

delete:
	stow --verbose --target=$$HOME --delete */

install:
	sudo pacman -S --needed -< ./pkgs

link:
	echo 'source ~/.bash/source' >> ~/.bashrc
	echo 'source ~/.bash/profile' >> ~/.bash_profile
	echo 'source ~/.bash/logout' >> ~/.bash_logout

setup: install all link
