# docker-gitlab-runner-php

FROM ubuntu:14.04

MAINTAINER  Michael Burri "mpbzh@burri.io"

ENV PHP_DIR /etc/php5

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y ca-certificates wget apt-transport-https vim nano

RUN echo "deb https://packages.gitlab.com/runner/gitlab-ci-multi-runner/ubuntu/ `lsb_release -cs` main" > /etc/apt/sources.list.d/runner_gitlab-ci-multi-runner.list && \
    wget -q -O - https://packages.gitlab.com/gpg.key | apt-key add - && \
    apt-get update -y && \
    apt-get install -y gitlab-ci-multi-runner

# Install packages required to build PHP
RUN apt-get update -y && \
    apt-get build-dep -y php5 && \
    apt-get install -y libmcrypt-dev libltdl-dev libreadline-dev libc-client2007e-dev libbz2-dev libkrb5-dev \
                       libcurl4-gnutls-dev libfreetype6-dev libgmp-dev libjpeg8-dev libpng12-dev libt1-dev \
                       libmhash-dev libexpat1-dev libicu-dev libtidy-dev re2c lemon libldap2-dev libsasl2-dev \
                       libssh2-1-dev git wget curl apache2 php-pear

# Install a specific bison version
RUN wget -O /tmp/libbison-dev.deb http://launchpadlibrarian.net/140087283/libbison-dev_2.7.1.dfsg-1_amd64.deb && \
    wget -O /tmp/bison_2.7.1.deb http://launchpadlibrarian.net/140087282/bison_2.7.1.dfsg-1_amd64.deb && \
    dpkg -i /tmp/libbison-dev.deb && \
    dpkg -i /tmp/bison_2.7.1.deb && \
    rm -f /tmp/*.deb

RUN curl https://raw.github.com/CHH/phpenv/master/bin/phpenv-install.sh | bash
RUN echo 'export PATH="/root/.phpenv/bin:$PATH"' >> /root/.bashrc
RUN echo 'eval "$(phpenv init -)"' >> /rootphp/.bashrc
RUN mkdir /root/.phpenv/plugins; \
    cd /root/.phpenv/plugins; \
    git clone https://github.com/CHH/php-build.git
ENV PATH /home/php/.phpenv/shims:/home/php/.phpenv/bin:$PATH

# Install composer
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

ADD entrypoint /
RUN chmod +x /entrypoint

VOLUME ["/etc/gitlab-runner", "/root"]
ENTRYPOINT ["/entrypoint"]
CMD ["run"]
