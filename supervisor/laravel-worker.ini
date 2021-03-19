[program:laravel-worker]
command=/usr/bin/php /app/artisan queue:work --tries=3 --max-time=3600
process_name=%(program_name)s_%(process_num)02d
priority=30
numprocs=%(ENV_LARAVEL_WORKER)s
autostart=true
autorestart=true
user=app
startsecs=0
redirect_stderr=true
stdout_logfile=/dev/stdout
stdout_logfile_maxbytes=0
stderr_logfile_backups=0
stopwaitsecs=3600
