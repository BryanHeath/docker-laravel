FROM ubuntu:16.10
#FROM blitznote/debootstrap-amd64:16.04

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
	wget \
	make \
	build-essential \
	tcl \
	xsltproc \
	libjemalloc-dev \ 
	liblua5.1-0-dev

# Install PHP7
RUN apt-get install -y \
	php7.0 \
	php7.0-dev \
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

# Download and build Redis and its deps
RUN wget http://download.redis.io/releases/redis-stable.tar.gz && \
    tar xvzf redis-stable.tar.gz && \
    rm redis-stable.tar.gz && \
    cd redis-stable && \
    cd deps && \
    make hiredis linenoise geohash-int && \
    cd .. && \
    make && \
    make test && \
    make install && \
    cp redis.conf /etc/redis.conf && \
    rm -Rf ../redis-stable && \
    mkdir /var/log/redis

# Download and build phpredis for php7
RUN wget https://github.com/phpredis/phpredis/archive/php7.tar.gz && \
    tar zxvf php7.tar.gz && \
    rm -Rf php7.tar.gz && \
    cd phpredis-php7/ && \
    phpize && \
    ./configure && \
    make && \
    make install && \
    rm -Rf ../phpredis-php7

# Cleanup
RUN apt-get clean && \
	rm -rf /var/lib/apt/lists/* \
	/tmp/* \
	/var/tmp/*
