# Project to deploy GLPI with docker

[![](https://images.microbadger.com/badges/version/slmitch/glpi.svg)](http://microbadger.com/images/slmitch/glpi "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/slmitch/glpi.svg)](http://microbadger.com/images/slmitch/glpi "Get your own image badge on microbadger.com")

Install and run an GLPI instance with docker.

## Deploy GLPI without database
```sh
docker run --name glpi -p 80:80 -d slmitch/glpi
```



