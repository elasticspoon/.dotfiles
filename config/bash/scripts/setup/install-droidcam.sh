sudo apt-get install libappindicator3-1
cd /tmp/
wget -O droidcam_latest.zip https://files.dev47apps.net/linux/droidcam_2.1.2.zip
# sha1sum: d5eb769f249011fbfa0edef05ffd56949b63d470
unzip droidcam_latest.zip -d droidcam
cd droidcam && sudo ./install-client

sudo apt install linux-headers-$(uname -r) gcc make
sudo ./install-video

# flatpak install flathub com.obsproject.Studio.Plugin.DroidCam
