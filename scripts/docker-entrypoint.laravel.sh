#!/bin/sh
set -eo pipefail

if [ "$1" = "supervisord" ]; then

    if [ -n "$PHP_INI_SENDMAIL_PATH" ]; then
        sed -i "s|;*sendmail_path =.*|sendmail_path=\"${PHP_INI_SENDMAIL_PATH}\"|i" /etc/php7/php.ini
    fi

    if [ -n "$PHP_EXT_XDEBUG" ]; then
        echo -en ';extension=pcov.so\n;pcov.enabled=1\n;pcov.directory=app\n' > /etc/php7/conf.d/pcov.ini
        printf "\
zend_extension=xdebug.so\n\
xdebug.mode=debug\n\
xdebug.start_with_request=yes\n" > /etc/php7/conf.d/50_xdebug.ini
    fi

    ARTISAN=/app/artisan
    if [ -f "$ARTISAN" ]; then
        #echo "* * * * * /usr/bin/php /app/artisan schedule:run >> /dev/null 2>&1" | crontab -u app -
        echo "* * * * * /usr/bin/php /app/artisan schedule:run" | crontab -u app -
        export LARAVEL_WORKER=${LARAVEL_WORKER:-1}
    else
        mv /etc/supervisor.d/laravel-worker.ini /etc/supervisor.d/laravel-worker.disabled
    fi
fi

exec "$@"
