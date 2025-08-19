sudo apt-get install -y zsh
chsh -s $(which zsh)
echo "Log out and log back in again to use your new default shell"
echo 'Test that it worked with echo $SHELL. Expected result: /bin/zsh or similar'
echo 'Test with $SHELL --version. Expected result: 'zsh 5.8' or similar'
