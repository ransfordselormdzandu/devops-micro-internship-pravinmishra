#!/bin/bash

#update && upgrade ubuntu vm
sudo apt update
sudo apt upgrade -y

#isntall nodejs and npm
sudo apt install -y nodejs npm

#install, start and enable nginx
sudo apt install -y nginx git curl build-essential
sudo systemctl start nginx
sudo systemctl enable nginx


#clone the react app repository
cd home/azureadmin
git clone https://github.com/pravinmishraaws/my-react-app.git
cd my-react-app

#Modify App.js with your custom info
sed -i 's|Your Full Name|Ransford Selorm Dzandu|' src/App.js
sed -i 's|DD/MM/YYYY|16/09/2026|' src/App.js

#install app dependencies and build
npm install
npm run build

#deploy build to Nginx
sudo rm -rf /var/www/html/*
sudo cp -r build/* /var/www/html/
sudo chown -R www-data:www-data /var/www/html
sudo chmod -R 755 /var/www/html

#Configure nginx for React App routing
echo 'server {
    listen 80;
    server_name _;

    root /var/www/html;
    index index.html;
    
    location / {
        try_files $uri /index.html;
    }

    error_page 404 /index.html;
}' | sudo tee /etc/nginx/sites-available/default > /dev/null

# Restart Nginx
sudo systemctl restart nginx

