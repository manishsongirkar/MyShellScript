#!/bin/bash

# Usage #
# Run the following command one-by-one
#
#     wget -c https://raw.github.com/manishsongirkar/MyShellScript/master/gruntInstall.sh
#     chmod u+x gruntInstall.sh
#     sudo bash gruntInstall.sh
#
# That's it :)

# Add NodeJs repository #
sudo apt-get install -y python-software-properties
sudo add-apt-repository -y ppa:chris-lea/node.js
sudo apt-get update

# Install NodeJs And NPM #
sudo apt-get install -y nodejs npm

# Install Grunt CLI #
sudo npm install -g grunt-cli

# Install Bower #
sudo npm install -g bower

clear

echo "Following Packages are installed:"
echo
echo "Node.js:"
node -v
echo
echo "npm:"
npm -v
echo
echo "Grunt:"
grunt --version
echo
echo "Bower:"
bower --version
echo
