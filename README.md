Container based on original wordpress docker container with addition of ssmtp to allow mail sending.

Package was inspired on [that project](https://github.com/RickWieman/Dockerfiles/tree/master/php-apache-ssmtp)

Environment variables possible to use:

```
$SSMTP_ROOT

$SSMTP_MAILHUB

$SSMTP_USETLS = YES/NO (default NO)

$SSMTP_STARTTLS = YES/NO (default NO)

$SSMTP_REWRITEDOMAIN (default empty)

$SSMTP_HOSTNAME

$SSMTP_FROMLINEOVERRIDE = YES/NO (DEFAULT YES)

$SSMTP_AUTHUSER 

$SSMTP_AUTHPASS
```
or alternatively VOLUME /etc/ssmtp with config files might be mounted.
