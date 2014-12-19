#!/bin/sh

echo ">>> Start install and setup postgres"

PG_VERSION=9.4

# Add PostgreSQL GPG public key
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

# Add PostgreSQL repo
if [ ! -f /etc/apt/sources.list.d/pgdg.list ]; then
  sudo touch /etc/apt/sources.list.d/pgdg.list
  sudo echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main" | sudo tee /etc/apt/sources.list.d/pgdg.list
fi

# Update Apt repos
sudo apt-get update

# Install Posgresql
sudo apt-get install -qq postgresql-$PG_VERSION postgresql-client-$PG_VERSION postgresql-contrib-$PG_VERSION postgresql-server-dev-$PG_VERSION libpq-dev

# Create a new super user
sudo -u postgres psql -c "CREATE ROLE $1 LOGIN SUPERUSER CREATEDB PASSWORD '$2'"

# Create a new db
sudo -u postgres psql -c "CREATE DATABASE $3 OWNER $1"

echo ">> End setup Postgres"
