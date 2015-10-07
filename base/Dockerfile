# docker-gitlab-runner-php

FROM alpine

MAINTAINER  Michael Burri "mpbzh@burri.io"

RUN apk add --update bash wget ca-certificates openssl

RUN wget -O /tmp/glibc.apk "https://circle-artifacts.com/gh/andyshinn/alpine-pkg-glibc/6/artifacts/0/home/ubuntu/alpine-pkg-glibc/packages/x86_64/glibc-2.21-r2.apk" && \
    apk add --allow-untrusted /tmp/glibc.apk && \
 	/usr/glibc/usr/bin/ldconfig /lib /usr/glibc/usr/lib && \
 	rm /tmp/glibc.apk

RUN wget -O /usr/bin/gitlab-ci-multi-runner https://gitlab-ci-multi-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-ci-multi-runner-linux-amd64 && \
	chmod +x /usr/bin/gitlab-ci-multi-runner

ENV PHP_DIR /etc/php5
ENV PATH /root/.phpenv/bin:/root/.phpenv/shims:$PATH
                       
RUN apk --update add wget curl git php php-curl php-openssl php-json php-phar php-dom

RUN git clone https://github.com/CHH/phpenv.git /tmp/phpenv && \
    /tmp/phpenv/bin/phpenv-install.sh
RUN echo 'eval \"\$(phpenv init -)\"' >> /etc/profile.d/phpenv.sh
RUN echo 'eval "$(phpenv init -)"' >> /root/.bashrc

RUN git clone git://github.com/CHH/php-build.git /root/.phpenv/plugins/php-build
COPY files/configure /root/.phpenv/plugins/php-build/share/php-build/default_configure_options

# Install composer
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

VOLUME ["/etc/gitlab-runner"]
ENTRYPOINT ["gitlab-ci-multi-runner"]
CMD ["run"]
