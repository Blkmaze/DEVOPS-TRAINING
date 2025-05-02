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
