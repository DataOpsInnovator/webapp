# Create a script to install and configure Nginx on startup.

#!/bin/bash

# Update and install Nginx
sudo yum update -y
sudo yum install nginx -y

# Create the directory for the website. This creates the /var/www/mywebsite directory if it doesn't exist.

sudo mkdir -p /var/www/mywebsite

# Copy website files from /tmp/mywebsite (temporary location) to the Nginx web folder.  
# Thiscopies all files from the /tmp/mywebsite/ to /var/www/mywebsite/.

sudo cp -r /tmp/mywebsite/* /var/www/mywebsite  

# Change ownership so Nginx can serve the files.

sudo chown -R nginx:nginx /var/www/mywebsite

# Set up Nginx config to serve the website

sudo cat <<EOL > /etc/nginx/conf.d/mywebsite.conf
server {
    listen 80;
    location / {
        root /var/www/mywebsite;
        index index.html index.htm;
    }
}

EOL
sudo systemctl start nginx
sudo systemctl enable nginx


