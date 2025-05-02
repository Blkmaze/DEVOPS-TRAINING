New-Item -ItemType Directory -Force -Path "provision","web","app","db"

# Vagrantfile
@"
Vagrant.configure("2") do |config|
  config.vm.define "web" do |web|
    web.vm.box = "ubuntu/focal64"
    web.vm.hostname = "web"
    web.vm.network "private_network", ip: "192.168.56.10"
    web.vm.provision "shell", path: "provision/web.sh"
  end

  config.vm.define "app" do |app|
    app.vm.box = "ubuntu/focal64"
    app.vm.hostname = "app"
    app.vm.network "private_network", ip: "192.168.56.11"
    app.vm.provision "shell", path: "provision/app.sh"
  end

  config.vm.define "db" do |db|
    db.vm.box = "ubuntu/focal64"
    db.vm.hostname = "db"
    db.vm.network "private_network", ip: "192.168.56.12"
    db.vm.provision "shell", path: "provision/db.sh"
  end
end
"@ | Set-Content Vagrantfile

# Provision scripts
@"
#!/bin/bash
sudo apt update
sudo apt install -y nginx
echo '<h1>Welcome to the Web Tier</h1>' | sudo tee /var/www/html/index.html
sudo systemctl restart nginx
"@ | Set-Content provision/web.sh

@"
#!/bin/bash
sudo apt update
sudo apt install -y python3-pip
pip3 install flask
cat <<EOL > /home/vagrant/app.py
from flask import Flask
app = Flask(__name__)
@app.route('/')
def home():
    return "Hello from the App Tier!"
app.run(host='0.0.0.0', port=5000)
EOL
nohup python3 /home/vagrant/app.py &
"@ | Set-Content provision/app.sh

@"
#!/bin/bash
sudo apt update
sudo apt install -y postgresql postgresql-contrib
sudo -u postgres psql -f /vagrant/db/init.sql
"@ | Set-Content provision/db.sh

# App and DB files
Set-Content web/index.html "<h1>Welcome to the Web Tier - Static Page</h1>"

@"
from flask import Flask
app = Flask(__name__)
@app.route('/')
def index():
    return "Hello from Flask App Tier"
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
"@ | Set-Content app/app.py

Set-Content db/init.sql "CREATE DATABASE trainingdb;"

# Git operations
git add .
git commit -m "Initial commit: Multi-tier Vagrant setup"
git push origin main
