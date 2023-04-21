#sudo apt install git-all
#git clone https://github.com/MinhoChoi-a/osrm.git
#cd /home/ubuntu/osrm
#sudo git pull
#sudo chmod +x ./init.sh
#sudo mv ./init.sh /home/ubuntu/init.sh

sudo wget http://nginx.org/keys/nginx_signing.key
sudo apt-key add nginx_signing.key

cd /etc/apt
sudo echo "deb http://nginx.org/packages/ubuntu "$(. /etc/os-release && echo "$VERSION_CODENAME")" nginx" >> ./sources.list
sudo echo "deb-src http://nginx.org/packages/ubuntu "$(. /etc/os-release && echo "$VERSION_CODENAME")" nginx" >> ./sources.list

sudo apt-get update
sudo apt-get install nginx

cd /etc/nginx/conf.d
sudo mv default.conf default.conf.bak
sudo touch server1.conf
sudo echo "server { root /home/ubuntu/public_html; location /osrm/route/default { proxy_pass http://localhost:5000/route/v1/driving; } location /osrm/route/avoidtoll { proxy_pass http://localhost:5001/route/v1/driving; } }" > server1.conf

sudo systemctl start nginx.service

cd ~
sudo apt-get install ca-certificates curl gnupg
sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo mkdir /home/ubuntu/osrm_docker
sudo mkdir /home/ubuntu/osrm_docker/default
sudo mkdir /home/ubuntu/osrm_docker/avoidtoll

sudo cp /home/ubuntu/osrm/default/car.lua /home/ubuntu/osrm_docker/default/car.lua
sudo cp /home/ubuntu/osrm/avoidtoll/car.lua /home/ubuntu/osrm_docker/avoidtoll/car.lua

sudo cp /home/ubuntu/osrm/default/Dockerfile /home/ubuntu/osrm_docker/default/Dockerfile
sudo cp /home/ubuntu/osrm/avoidtoll/Dockerfile /home/ubuntu/osrm_docker/avoidtoll/Dockerfile

cd /home/ubuntu/osrm_docker
wget http://download.geofabrik.de/north-america/canada/ontario-latest.osm.pbf

#cd /home/ubuntu/osrm_docker/default
#sudo docker build -t osrm-default .
