all:
	stow --verbose --target=$$HOME --restow */

delete:
	stow --verbose --target=$$HOME --delete */

link:
	echo 'source ~/.bash/source' >> ~/.bashrc
	echo 'source ~/.bash/profile' >> ~/.profile
	echo 'source ~/.bash/logout' >> ~/.bash_logout

arch: archinstall dirs all link yay

archinstall:
	sudo pacman -S --needed -< ./pkgs.arch
	bat cache --build

yay:
	 sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
	 yay -Y --gendb
	 yay -Syu --devel
	 yay -Y --devel --save
	 cd ..
	 rm -rf yay

deb: debinstall dirs neovim all link

debinstall:
	# Install packages
	# for i in $$(cat pkgs); do sudo apt-get install $i; done
	xargs sudo apt-get install -y < pkgs.deb
	# Install starship
	curl -sS https://starship.rs/install.sh | sh
	batcat cache --build

neovim:
	curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
	sudo rm -rf /opt/nvim-linux64
	sudo tar -C /opt -xzf nvim-linux64.tar.gz
	rm nvim-linux64.tar.gz

dirs:
	mkdir -p ~/Desktop ~/Documents ~/Downloads ~/Google ~/Music ~/Pictures ~/Projects ~/Public ~/Templates ~/Videos ~/.config/rclone
	cat rclone.txt > ~/.config/rclone/rclone.conf
	rclone config reconnect drive:
