echo "make sure you have go downloaded to Downloads folder. Not the src version."
if [ -f ~/Downloads/go1.21.6.linux-amd64.tar.gz ]; then
	sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf ~/Downloads/go1.21.6.linux-amd64.tar.gz && rm ~/Downloads/go1.21.6.linux-amd64.tar.gz
fi

go install github.com/jesseduffield/lazygit@latest
