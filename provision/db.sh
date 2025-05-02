#!/bin/bash
sudo apt update
sudo apt install -y postgresql postgresql-contrib
sudo -u postgres psql -f /vagrant/db/init.sql
