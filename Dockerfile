#FROM ubuntu:16.10
FROM blitznote/debootstrap-amd64:16.04

# Needed to stop install from prompting
ARG DEBIAN_FRONTED=noninteractive

# Update and upgrade
RUN apt-get update && apt-get upgrade -y

# Install some needed things
RUN apt-get install -y \
	git \
	zip \
	nginx \
	vim \
	wget

# Install PHP7
RUN apt-get install -y \
	php7.0 \
	php7.0-fpm \
	php7.0-mbstring \
	php7.0-xml \
	php7.0-curl \
	php7.0-json \
	php7.0-zip

# Install sqlite3
RUN apt-get install -y sqlite3 php7.0-sqlite3

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

# Add composer bin to path
ENV PATH /root/.composer/vendor/bin:$PATH

# Speed up composer
RUN composer global require "hirak/prestissimo:^0.3"

# Install phpUnit
RUN composer global require "phpunit/phpunit=5.6.*"

# Install Laravel installer
RUN composer global require "laravel/installer"

# Cleanup
RUN apt-get clean && \
	rm -rf /var/lib/apt/lists/* \
	/tmp/* \
	/var/tmp/*
