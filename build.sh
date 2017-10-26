#!/bin/bash

#
echo "First things first, let's make sure we have the latest updates."
echo "---------------------------------------------------------------"
#
apt-get update && apt-get upgrade -y
#

#
echo "Now let's install git..."
echo "---------------------------------------------------------------"
#
apt-get install -y git

#
echo "...and some essentials..."
echo "---------------------------------------------------------------"
#
apt-get install -y build-essential

#
echo "...and some Apache while we're at it."
echo "---------------------------------------------------------------"
#
apt-get install -y apache2
service apache2 start

#
echo "PHP time!"
echo "---------------------------------------------------------------"
#
apt-get install -y software-properties-common
add-apt-repository -y ppa:ondrej/php
apt-get update
apt-get remove php7.0
apt-get install -y --allow-unauthenticated php7.1 php7.1-fpm php7.1-mbstring php7.1-mysql php7.1-zip php7.1-gd php7.1-xml php7.1-curl php7.1-intl php7.1-json php7.1-mcrypt libapache2-mod-php7.1
a2enmod actions
service apache2 restart

#
echo "Now some NodeJS"
echo "---------------------------------------------------------------"
#
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
apt-get install -y nodejs

#
echo "But what about our newer friend Composer?"
echo "---------------------------------------------------------------"
#
curl -o /tmp/composer-setup.php https://getcomposer.org/installer \
&& curl -o /tmp/composer-setup.sig https://composer.github.io/installer.sig \
&& php -r "if (hash('SHA384', file_get_contents('/tmp/composer-setup.php')) !== trim(file_get_contents('/tmp/composer-setup.sig'))) { unlink('/tmp/composer-setup.php'); echo 'Invalid installer' . PHP_EOL; exit(1); }" \
&& php /tmp/composer-setup.php --no-ansi --install-dir=/usr/local/bin --filename=composer --snapshot \
&& rm -f /tmp/composer-setup.*