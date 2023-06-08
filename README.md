# Docker based setup to run old Indexhibit sites

## Getting started

- `docker-compose up --build -d`
- Import your database dump through adminer: http://localhost:8080/?server=idxz-mariadb&username=ndxz-user&db=ndxz-database
- Copy your Indexhibit backup into `html/`
- Rename `html/ndxz-studio/config/config.docker.php` to `html/ndxz-studio/config/config.php` (replacing your own)
- Go to http://localhost:8989 and check if everything is working OK

## Fixing

You can edit the files in `html/` and reload the page in your browser.

## Make static site

```
mkdir static
cd static
wget \
    --mirror \
    --page-requisites \
    --html-extension \
    --convert-links \
    --execute robots=off \
    --directory-prefix=. \
    --span-hosts \
    --domains=localhost \
    --user-agent=""\
    http://localhost:8989
```


## About

Once a big fan of Indexhibit i built many sites based on it. After many years of PHP versions and no Indexhibit updates it is almost impossible to keep these sites alive. This project is an attempt to mitigate some of that pain.

Florian Jenett, 2023