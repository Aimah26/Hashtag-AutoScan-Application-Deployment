#!/bin/bash
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
sudo yum update 
sudo yum install wget -y
wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
sudo yum install ./google-chrome-stable_current_*.rpm -y
sudo yum -y install libXScrnSaver
sudo yum install xorg-x11-server-Xvfb -y
Xvfb -ac :99 -screen 0 1280x1024x16 & export DISPLAY=:99
wget https://chromedriver.storage.googleapis.com/109.0.5414.74/chromedriver_linux64.zip
sudo yum install unzip -y
sudo unzip chromedriver_linux64.zip
sudo mv chromedriver /usr/bin/chromedriver
sudo chown root:root /usr/bin/chromedriver
sudo chmod +x /usr/bin/chromedriver
sudo wget https://download.oracle.com/java/19/latest/jdk-19_linux-x64_bin.rpm
sudo yum update 
sudo rpm -Uvh jdk-19_linux-x64_bin.rpm
sudo yum install git -y
