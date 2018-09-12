# Project to deploy GLPI with docker

[![](https://images.microbadger.com/badges/version/slmitch/glpi.svg)](http://microbadger.com/images/slmitch/glpi "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/slmitch/glpi.svg)](http://microbadger.com/images/slmitch/glpi "Get your own image badge on microbadger.com")

Install and run an GLPI instance with docker.

## Deploy GLPI without database
```sh
docker run --name glpi -p 80:80 -d slmitch/glpi
```

## Deploy GLPI stack, with a database
You can start a stack with this command
```sh
docker stack deploy glpi --compose-file stack.yml 
```

With this stack file for example (I use folder /docker/volumes/glpi_plugins for my plugins, /docker/volumes/glpi_mysql for mysql data, and /docker/glpi/config_db.php you can see below)

```sh
version: '3.3'

services:
  glpi:
    image: slmitch/glpi
    ports:
      - 8042:80
    environment:
      TZ: Europe/Paris
    volumes:
      - /docker/glpi/config_db.php:/var/www/html/config/config_db.php:ro
      - /docker/volumes/glpi_plugins:/var/www/html/plugins
  mysql:
    image: mysql:5.7.21
    volumes:
      - /docker/volumes/glpi_mysql:/var/lib/mysql/
    environment:
      TZ: Europe/Paris
      MYSQL_DATABASE: glpi
      MYSQL_ROOT_PASSWORD: glpi
```

For the first run, remove the 
"      - /docker/glpi/config_db.php:/var/www/html/config/config_db.php:ro"
line, in order to have the initial setup.

After this, add the line on stack file, create the config_db.php file with 
```php
<?php
class DB extends DBmysql {
   public $dbhost     = 'mysql';
   public $dbuser     = 'root';
   public $dbpassword = 'glpi';
   public $dbdefault  = 'glpi';
}
```
and deploy again the stack.


When the database is started, on your container, you can extract the /var/www/html/config/config_db.php

