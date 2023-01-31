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

With this stack file for example (I use folder /docker/volumes/glpi_plugins for my plugins, /docker/volumes/glpi_mysql for mysql data, /docker/volumes/glpi_files for all uploaded files and  /docker/volumes/glpi_conf/ (with db config and glpicrypt key) you can see below)

```sh
version: '3.3'

services:
  glpi:
    image: slmitch/glpi
    ports:
      - 8042:80
    volumes:
      - /docker/volumes/glpi_conf:/var/www/html/config/
      - /docker/volumes/glpi_plugins:/var/www/html/plugins
      - /docker/volumes/glpi_files:/var/www/html/files
  mysql:
    image: mysql:5.7
    volumes:
      - /docker/volumes/glpi_mysql:/var/lib/mysql/
    environment:
      MYSQL_DATABASE: glpi
      MYSQL_ROOT_PASSWORD: glpi
```

