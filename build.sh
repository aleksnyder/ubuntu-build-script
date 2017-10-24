#!/bin/bash

#
echo
echo
echo
echo
echo
echo "First things first, let's make sure we have the latest updates."
echo "---------------------------------------------------------------"
#
apt-get update && apt-get -y upgrade
#

#
echo
echo
echo
echo
echo
echo "Now let's install git..."
echo "---------------------------------------------------------------"
#
apt-get install -y git

#
echo
echo
echo
echo
echo
echo "...and some Apache while we're at it..."
echo "---------------------------------------------------------------"
#
apt-get install -y apache2

#
echo
echo
echo
echo
echo "..and some essentials."
echo "---------------------------------------------------------------"
#
apt-get install -y build-essential

#
echo
echo
echo
echo
echo
echo "PHP time!"
echo "---------------------------------------------------------------"
#
apt-get install -y php-curl php-gd php-dom php-cli
apache2ctl restart

#
echo
echo
echo
echo
echo
echo "Now some Node.JS"
echo "---------------------------------------------------------------"
#
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
apt-get install nodejs

#
echo
echo
echo
echo
echo
echo "But what about our newer friend Composer?"
echo "---------------------------------------------------------------"
#
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer