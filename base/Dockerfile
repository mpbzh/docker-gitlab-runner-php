# docker-gitlab-runner-php

FROM gitlab/gitlab-runner
MAINTAINER  Michael Burri "mpbzh@burri.io"

ENV PHP_DIR /etc/php5

# Install packages required to build PHP
RUN apt-get update -y && \
    apt-get build-dep -y php5 && \
    apt-get install -y libmcrypt-dev libltdl-dev libreadline-dev libc-client2007e-dev libbz2-dev libkrb5-dev \
                       libcurl4-gnutls-dev libfreetype6-dev libgmp-dev libjpeg8-dev libpng12-dev libt1-dev \
                       libmhash-dev libexpat1-dev libicu-dev libtidy-dev re2c lemon libldap2-dev libsasl2-dev \
                       libssh2-1-dev

# Install some usefull packages
RUN apt-get update -y && \
    apt-get install -y git \
                       wget \
                       curl \
                       apache2 \
                       php-pear

# Install a specific bison version
RUN wget -O /tmp/libbison-dev.deb http://launchpadlibrarian.net/140087283/libbison-dev_2.7.1.dfsg-1_amd64.deb && \
    wget -O /tmp/bison_2.7.1.deb http://launchpadlibrarian.net/140087282/bison_2.7.1.dfsg-1_amd64.deb && \
    dpkg -i /tmp/libbison-dev.deb && \
    dpkg -i /tmp/bison_2.7.1.deb && \
    rm -f /tmp/*.deb

USER gitlab-runner
ENV HOME /home/gitlab-runner
WORKDIR /home/gitlab-runner

RUN echo $HOME

# Install phpenv
RUN cd /home/gitlab-runner && git clone git://github.com/phpenv/phpenv.git .phpenv 
RUN echo 'export PATH="/home/gitlab-runner/.phpenv/bin:$PATH"' >> /home/gitlab-runner/.bashrc
RUN echo 'eval "$(phpenv init -)"' >> /home/gitlab-runner/.bashrc
RUN mkdir /home/gitlab-runner/.phpenv/plugins; \
    cd /home/gitlab-runner/.phpenv/plugins; \
    git clone https://github.com/CHH/php-build.git

ENV PATH /home/gitlab-runner/.phpenv/shims:/home/gitlab-runner/.phpenv/bin:$PATH

# RUN ln -s /usr/lib/x86_64-linux-gnu/libfreetype.so /usr/lib/libfreetype.so && \
#    ln -s /usr/lib/x86_64-linux-gnu/libgmp.so      /usr/lib/libgmp.so && \
#    ln -s /usr/lib/x86_64-linux-gnu/libldap.so     /usr/lib/libldap.so && \
#    ln -s /usr/include/x86_64-linux-gnu/gmp.h      /usr/include/gmp.h


USER root
ENV HOME /root
WORKDIR /root

# Install composer
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer
