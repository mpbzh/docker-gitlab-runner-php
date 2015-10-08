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

ADD files/entrypoint /
RUN chmod +x /entrypoint

# Install composer
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer
	
# Install a specific bison version
RUN wget -O /tmp/libbison-dev.deb http://launchpadlibrarian.net/140087283/libbison-dev_2.7.1.dfsg-1_amd64.deb && \
    wget -O /tmp/bison_2.7.1.deb http://launchpadlibrarian.net/140087282/bison_2.7.1.dfsg-1_amd64.deb && \
    dpkg -i /tmp/libbison-dev.deb && \
    dpkg -i /tmp/bison_2.7.1.deb && \
    rm -f /tmp/*.deb

RUN git clone https://github.com/CHH/phpenv.git /tmp/phpenv && \
    /tmp/phpenv/bin/phpenv-install.sh && \
    sudo /bin/bash -c "echo 'eval \"\$(phpenv init -)\"' >> /etc/profile.d/phpenv.sh" && \
    echo 'eval "$(phpenv init -)"' >> /root/.bashrc
    
RUN git clone git://github.com/CHH/php-build.git /root/.phpenv/plugins/php-build
COPY files/configure /root/.phpenv/plugins/php-build/share/php-build/default_configure_options

ENV PATH /root/.phpenv/bin:/root/.phpenv/shims:$PATH

VOLUME ["/etc/gitlab-runner", "/home/gitlab-runner"]
ENTRYPOINT ["/entrypoint"]
CMD ["run"]

