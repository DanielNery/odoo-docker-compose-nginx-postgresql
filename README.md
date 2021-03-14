# Odoo Production Environment Template
# Using Odoo + Postgresql + Nginx with Docker-compose

<img src="./project-images/project-image.png">

# Commands

sudo docker-compose up -d
sudo docker-compose stop odoo && sudo docker-compose run --rm odoo odoo -c /etc/odoo/odoo.conf -i base