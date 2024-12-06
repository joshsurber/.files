all:
	stow --verbose --target=$$HOME --restow */

delete:
	stow --verbose --target=$$HOME --delete */

link:
	echo 'source ~/.bash/source' >> ~/.bashrc
	echo 'source ~/.bash/profile' >> ~/.bash_profile
	echo 'source ~/.bash/logout' >> ~/.bash_logout

arch: install all link yay

archinstall:
	sudo pacman -S --needed -< ./pkgs.arch

yay:
	 sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
	 yay -Y --gendb
	 yay -Syu --devel
	 yay -Y --devel --save

deb: debinstall neovim all link

debinstall:
	# Install packages
	# for i in $$(cat pkgs); do sudo apt-get install $i; done
	xargs sudo apt-get install < pkgs
	# Install starship
	curl -sS https://starship.rs/install.sh | sh

neovim:
	curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
	sudo rm -rf /opt/nvim
	sudo tar -C /opt -xzf nvim-linux64.tar.gz
