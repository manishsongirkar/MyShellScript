#!/bin/bash

# Add NodeJs repository #
sudo apt-get install python-software-properties
sudo apt-add-repository ppa:chris-lea/node.js
sudo apt-get update

# Install NodeJs #
sudo apt-get install nodejs

# Install npm #
sudo apt-get install npm

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
