all:
	stow --verbose --target=$$HOME --restow */

delete:
	stow --verbose --target=$$HOME --delete */

install:
	echo 'source ~/.bash/source' >> ~/.bashrc
	echo 'source ~/.bash/profile' >> ~/.bash_profile
	echo 'source ~/.bash/logout' >> ~/.bash_logout
