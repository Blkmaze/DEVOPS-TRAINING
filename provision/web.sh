#!/bin/bash
sudo apt update
sudo apt install -y nginx
echo '<h1>Welcome to the Web Tier</h1>' | sudo tee /var/www/html/index.html
sudo systemctl restart nginx
