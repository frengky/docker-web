[program:crond]
command=/usr/sbin/crond -f -d 8
process_name=%(program_name)s_%(process_num)02d
priority=100
numprocs=1
autostart=true
autorestart=false
startsecs=0
redirect_stderr=true
stdout_logfile=/dev/stdout
stdout_logfile_maxbytes=0
stderr_logfile_backups=0
