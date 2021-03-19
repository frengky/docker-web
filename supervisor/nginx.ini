[program:nginx]
command=/usr/sbin/nginx -g 'daemon off;'
process_name=%(program_name)s_%(process_num)02d
priority=20
numprocs=1
autostart=true
autorestart=false
startsecs=0
redirect_stderr=true
stdout_logfile=/dev/stdout
stdout_logfile_maxbytes=0
stderr_logfile_backups=0