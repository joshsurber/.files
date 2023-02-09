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

yay:
	 sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
	 yay -Y --gendb
	 yay -Syu --devel
	 yay -Y --devel --save

setup: install all link yay
