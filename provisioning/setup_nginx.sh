#!/bin/sh

echo ">>> Start install and setup nginx"

# Add nginx ppa
sudo add-apt-repository ppa:nginx/stable

# Update
sudo apt-get update

# Install nginx
sudo apt-get install -qq nginx

# Turn of sendfile in nginx configuration
sed -i 's/sendfile on;/sendfile off;/' /etc/nginx/nginx.conf

# Remove default host file of nginx
sudo rm -f /etc/nginx/sites-enabled/default

# Copy default virtual host config file
sudo cp -f /home/vagrant/sites/larademo_bash/provisioning/site.conf /etc/nginx/sites-available/larabash

# Enable the virtual host config
if [ ! -f /etc/nginx/sites-enabled/larabash ]; then
  ln -sf /etc/nginx/sites-available/larabash /etc/nginx/sites-enabled
fi

# Restart
sudo service nginx restart

# Add default user vagrant to www-data group
usermod -a -G www-data vagrant

echo ">>> End setting up nginx"
