# Web Runner

A **LEMP** stack docker image based on [Alpine Linux](https://alpinelinux.org/).
Available variants: `frengky/web`, `frengky/web:php8`, `frengky/web:php7`, `frengky/web:laravel`, `frengky/web:static`

*Image description*:

| Variant  | Description |
|---|---|
| frengky/web | For running common PHP website |
| frengky/web:static | For running static html website |
| frengky/web:laravel | Optimized to run Laravel website, complete with scheduler and queue workers |

*Environment variables*:

| Name | Description | Example Value |
|------|-------------|---------------|
| PHP_EXT_XDEBUG | Enable XDEBUG extension | 1 |
| XDEBUG_CONFIG | [XDEBUG configuration](https://xdebug.org/docs/all_settings) | client_host=host.docker.internal |
| PHP_INI_SENDMAIL_PATH | PHP ini sendmail path | /usr/sbin/sendmail -S your-mail-host:3025 -t -i |
| LARAVEL_WORKER | Number of Laravel queue workers | 1 |

## Running a website
Running a php website with current directory as the document root, on port `8080`
```
docker run -it --rm --name web -v $(pwd):/app -p 8080:8080 frengky/web
```

## Running a Laravel application
Create a new Laravel project using composer in the current directory
```
docker run -it --rm --name composer -u 1000:1000 -v $(pwd):/app -v composer-cache:/tmp composer create-project --prefer-dist laravel/laravel .
```
Configure Laravel's `.env` file to use `stderr` as logging destination
```
LOG_CHANNEL=stderr
```
Running the Laravel website with current directory as the Laravel source code, on port `8080`
```
docker run -it --rm --name laravel -v $(pwd):/app -p 8080:8080 frengky/web:laravel
```
Access Laravel's artisan command
```
docker run -it --rm --name laravel -v $(pwd):/app frengky/web:laravel php artisan route:list
```

## Debugging in Visual Code (XDEBUG)

To debugging in Visual Code Make sure the `PHP Debug` extension are installed on your remote too.
Adjust your `launch.json`:

```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Listen for XDebug",
            "type": "php",
            "request": "launch",
            "port": 9003,
            "pathMappings": {
                "/app": "${workspaceRoot}"
            }
        },
        {
            "name": "Launch currently open script",
            "type": "php",
            "request": "launch",
            "program": "${file}",
            "cwd": "${fileDirname}",
            "port": 9003
        }
    ]
}
```
