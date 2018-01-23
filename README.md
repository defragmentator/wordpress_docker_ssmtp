Container based on original wordpress docker container with addition of ssmtp to allow mail sending.

Package was inspired on [that project](https://github.com/RickWieman/Dockerfiles/tree/master/php-apache-ssmtp)

# Configuration
##  Configuration with environment variables
Environment variables possible to use:

```
SSMTP_ROOT - the person who gets all mail for userids < 1000, make this empty to disable rewriting

SSMTP_MAILHUB - smtp host

SSMTP_USETLS = YES/NO (default NO)

SSMTP_USESTARTTLS = YES/NO (default NO)

SSMTP_REWRITEDOMAIN (default empty) - where will the mail seem to come from

SSMTP_HOSTNAME - server hostname 

SSMTP_FROMLINEOVERRIDE = YES/NO (DEFAULT YES) - are users allowed to set their own From: address

SSMTP_AUTHUSER - user login

SSMTP_AUTHPASS - user password
```
## Configuration with ssmtp.conf file
alternatively VOLUME /etc/ssmtp with config files might be mounted. Configuration examples can be found [here](https://wiki.debian.org/sSMTP)

# Examples
## Gmail example
```
SSMTP_ROOT=user@gmail.com
SSMTP_USETLS=YES
SSMTP_USESTARTTLS=YES
SSMTP_MAILHUB=smtp.gmail.com:587
SSMTP_AUTHUSER=user@gmail.com
SSMTP_AUTHPASS=veryhardpassword
```
```
sudo docker run -e SSMTP_ROOT='user@gmail.com' -e SSMTP_USETLS='YES' \
-e SSMTP_USESTARTTLS='YES' -e SSMTP_MAILHUB='smtp.gmail.com:587' \
-e SSMTP_AUTHUSER='user@gmail.com' -e SSMTP_AUTHPASS='veryhardpassword' \
defragmentator/wordpress_ssmtp:apache
```
## Full wordpress installation example with docker stack

config.yml:
```
version: '3'

services:
   db:
     image: mysql:5.7
     volumes:
       - /home/docker/wordpress/db:/var/lib/mysql
     restart: always
     environment:
       MYSQL_ROOT_PASSWORD: mysql
       MYSQL_DATABASE: wordpress
       MYSQL_USER: wordpress
       MYSQL_PASSWORD: wordpress

   wordpress:
     depends_on:
       - db
     volumes:
       - /home/docker/wordpress/html:/var/www/html
     image: defragmentator/wordpress_ssmtp:fpm
     restart: always
     environment:
       WORDPRESS_DB_HOST: db:3306
       WORDPRESS_DB_USER: wordpress
       WORDPRESS_DB_PASSWORD: wordpress
       SSMTP_ROOT: user@gmail.com
       SSMTP_MAILHUB: smtp.gmail.com:587
       SSMTP_USETLS:  'YES'
       SSMTP_USESTARTTLS:  'YES'
       SSMTP_FROMLINEOVERRIDE: 'YES'
       SSMTP_AUTHUSER: user@gmail.com
       SSMTP_AUTHPASS: password


   web:
        image: nginx:latest
        restart: always
        ports:
            - "80:80"
        volumes:
            - /home/docker/wordpress/log:/var/log/nginx
            - /home/docker/wordpress/html:/var/www/html
            - /home/docker/wordpress/nginx/default.conf:/etc/nginx/conf.d/default.conf
```

deployment:
```
sudo docker stack deploy -c config.yml wordpresssite
```
