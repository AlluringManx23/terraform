#!/bin/bash
sudo apt update && sudo apt upgrade -y
wget https://nodejs.org/dist/v16.13.0/node-v16.13.0-linux-x64.tar.xz --directory-prefix=/home/ubuntu
tar -xvf /home/ubuntu/node*.tar.xz -C /home/ubuntu/
rm -rf /home/ubuntu/node*.tar.xz
mv -T /home/ubuntu/node*  /home/ubuntu/node
sudo mv /home/ubuntu/node /opt
echo 'export NODEJS_HOME=/opt/node/bin' >> /home/ubuntu/.bashrc
echo 'export PATH=$NODEJS_HOME:$PATH' >> /home/ubuntu/.bashrc

#download and setup git repo
git clone https://github.com/Devided-By-Zero/Car-Rental-System.git /home/ubuntu/CarRental
rm -rf /home/ubuntu/CarRental/node_modules
tmux new -d -s node_server
tmux send-keys -t node_server "cd /home/ubuntu/CarRental" ENTER
tmux send-keys -t node_server "npm install" ENTER
tmux send-keys -t node_server "npm start" ENTER