# gitlab-runner-php-54

FROM mpbzh/gitlab-runner-php
MAINTAINER  Michael Burri "mpbzh@burri.io"

ENV PHP_VERSION 5.4.38

# COPY files/ci-runner.ini /home/gitlab-runner/.phpenv/versions/$PHP_VERSION/etc/conf.d/ci-runner.ini

RUN phpenv install $PHP_VERSION \
    phpenv rehash && \
    phpenv global $PHP_VERSION

# Install PHP PECL extensions
RUN yes '' | pecl install \
	mongo \
	redis \
	memcache \
	ssh2-0.12 \
	xdebug