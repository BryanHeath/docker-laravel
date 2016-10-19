# docker-laravel
Docker container - Ubuntu 16.04, php7, composer, phpunit, &amp; laravel installer

# Base Docker Image

[blitznote/debootstrap-amd64:16.04](https://github.com/Blitznote/docker-ubuntu-debootstrap)

# Linux Components

* git
* Zip
* wget
* Vim
* sqlite3

# PHP7

* php7.0
* php7.0-fpm
* php7.0-mbstring
* php7.0-xml
* php7.0-curl
* php7.0-json
* php7.0-zip
* php7.0-sqlite3

# PHP Components

* [Composer](https://getcomposer.org)
* [hirak/prestissimo](https://github.com/hirak/prestissimo) - Composer addon that speeds up composer
* [phpunit/phpunit](https://phpunit.de)
* [Laravel](https://laravel.com)

# Misc

* apt-get update and upgrade run
* Composer bin added to PATH
* apt-get clean run and temp files deleted