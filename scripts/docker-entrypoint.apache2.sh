#!/bin/sh
set -eo pipefail

if [ "$1" = "httpd" ]; then

    HOSTNAME=$(hostname)
    sed -i "s|#ServerName\ www.example.com:80|ServerName\ ${HOSTNAME}:8080|" /etc/apache2/httpd.conf
    sed -i "s#/var/www/localhost/htdocs#${DOCUMENT_ROOT:-/app}#" /etc/apache2/httpd.conf

    if [ -n "$PHP_INI_SENDMAIL_PATH" ]; then
        sed -i "s|;*sendmail_path =.*|sendmail_path=\"${PHP_INI_SENDMAIL_PATH}\"|i" /etc/php8/php.ini
    fi

    if [ -n "$PHP_EXT_XDEBUG" ]; then
        echo -en ';extension=pcov.so\n;pcov.enabled=1\n;pcov.directory=app\n' > /etc/php8/conf.d/pcov.ini
        printf "\
zend_extension=xdebug.so\n\
xdebug.mode=debug\n\
xdebug.start_with_request=yes\n" > /etc/php8/conf.d/50_xdebug.ini
    fi

fi

exec "$@"
