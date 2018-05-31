#!/bin/sh

################################################################
# Bash script to install Apache, Git, Node, PHP 7, and Composer.
################################################################

#COLORS
# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan

# Update packages and Upgrade system
echo "$Cyan \n Updating System.. $Color_Off"
apt-get update -y && apt-get upgrade -y

## Install Essentials
echo "$Cyan \n Installing Apache2 & Essentials $Color_Off"
apt-get install apache2 nano build-essential -y

## Install Git
echo "$Green \n Installing Git $Color_Off"
apt-get install git -y

## Install PHP
echo "$Cyan \n Installing PHP & Requirements $Color_Off"
add-apt-get-repository -y ppa:ondrej/php
apt-get update && apt-get install php7.1 php7.1-fpm php7.1-mbstring php7.1-mysql php7.1-zip php7.1-gd php7.1-xml php7.1-curl php7.1-intl php7.1-json php7.1-mcrypt libapache2-mod-php7.1 libapache2-mod-fastcgi php-xdebug -y

# Xdebug
echo "zend_extension=/usr/lib/php/20160303/xdebug.so" >> /etc/php/7.1/apache2/php.ini
echo "xdebug.remote_enable=1" >> /etc/php/7.1/apache2/php.ini
echo "xdebug.remote_host=127.0.0.1" >> /etc/php/7.1/apache2/php.ini
echo "xdebug.remote_port = 9000" >> /etc/php/7.1/apache2/php.ini

# Enabling Mod Rewrite
echo "$Cyan \n Enabling Modules $Color_Off"
a2enmod rewrite
a2enmod fastcgi

# Restart Apache
echo "$Cyan \n Restarting Apache $Color_Off"
service apache2 restart

## Install NodeJS
echo "$Cyan \n Installing Node.js $Color_Off"
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
apt-get update && apt-get install nodejs -y
apt-get install build-essential -y

## Install Composer
composer -v > /dev/null 2>&1
COMPOSER_IS_INSTALLED=$?

# True, if composer is not installed
if [ $COMPOSER_IS_INSTALLED -ne 0 ]; then
    echo "$Cyan \n Installing Composer $Color_Off"
    curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
else
    echo "$Cyan \n Composer already installed $Color_Off"
fi

## Add git branch to PS1
echo "\n# Add Git branch to command line" >> ~/.bashrc
echo "parse_git_branch() {" >> ~/.bashrc
echo "    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'" >> ~/.bashrc
echo "}" >> ~/.bashrc

PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "
echo "export PS1=$PS1" >> ~/.bashrc