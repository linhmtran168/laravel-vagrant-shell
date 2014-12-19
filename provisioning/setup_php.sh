#!/bin/sh
echo ">>> Starting PHP setup"

# Add repo for latest php
sudo apt-add-repository -y ppa:ondrej/php5

# Update the repo
sudo apt-get update

# Install necessary php packages
sudo apt-get install -y php5-fpm php5-dev php5-cli php5-json php5-curl php5-intl php5-pgsql php5-sqlite php5-gd php5-mcrypt php5-xdebug

# Install Composer
if [ ! -f  /usr/local/bin/composer ]; then
  curl -sS https://getcomposer.org/installer | php
  sudo mv composer.phar /usr/local/bin/composer
else
  sudo /usr/local/bin/composer self-update
fi

echo ">>> End setting up PHP"
