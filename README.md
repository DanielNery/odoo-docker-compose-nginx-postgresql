List of useful Command
=======================
 
# Downloading multiple submodules at once

git submodule update --init --recursive --remote  -j 8

# Changing all modules to branch 10
```git submodule foreach -q --recursive 'git checkout 10.0'```

# To pull all changes in the repo including changes in the submodules
```git pull --recurse-submodules -j 8```

# To add submodule (e.g.)
git submodule add git@code.indigoway.com:move-on/moveon-odoo-addons.git  addons/moveon-odoo-addons

# To show submodules status (branchs/commits)
git submodule status

# To start infrastructure:
docker-compose up  

# To see the logs
docker-compose logs --tail=50 -f
### It's gonna be availble on http://localhost

# To start infrastructure in background:
docker-compose up -d

# To connect to odoo container: 
docker-compose exec odoo bash

# To connect to postgres database server
docker-compose run --rm  db psql -h db -U odoo

## To generate a databse dump
export DATABASE=odoo && sudo docker-compose run --rm -e PGPASSWORD=odoo -e DATABASE=$DATABASE db pg_dump -h db -U odoo $DATABASE > /tmp/db-${DATABASE}-$(date +%Y%m%d%H%M).dump

## To restore a database
zcat database.dump.gz | docker-compose run -e PGPASSWORD=odoo --rm db psql -h db -U odoo

# To reload postgres configuration file
docker-compose exec db psql -U odoo -c "SELECT pg_reload_conf();" 

# To scale the number of odoo instances
docker-compose scale odoo=3

# Update modules
docker-compose run --rm odoo odoo -c /etc/odoo/odoo.conf -u base -d teste  --xmlrpc-port=9999   --db_host=db --db_user=odoo  --db_pass=odoo --stop-after-init

#### Delete all containers
```docker rm $(docker ps -a -q)```

#### Delete all images
```docker rmi $(docker images -q)```
