FROM alpine:3.19

RUN apk update && apk add --no-cache \
    php81 \
    php81-fpm \
    php81-mysqli \
    php81-curl \
    php81-gd \
    php81-xml \
    php81-mbstring \
    php81-zip \
    php81-phar \
    php81-opcache \
    mariadb-client \
    curl \
    wget \
    bash \
    tzdata

RUN sed -i 's|listen = .*|listen = 0.0.0.0:9000|' /etc/php81/php-fpm.d/www.conf

#fix error wordpress needs more memory
RUN sed -i 's/memory_limit = .*/memory_limit = 512M/' /etc/php81/php.ini

RUN ln -s /usr/bin/php81 /usr/bin/php

#install wp-cli
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    -O /usr/local/bin/wp && \
    chmod +x /usr/local/bin/wp

#create web folder
RUN mkdir -p /var/www/html

#copy script
COPY ./tools/wp-setup.sh /usr/local/bin/wp-setup.sh
RUN chmod +x /usr/local/bin/wp-setup.sh

CMD ["sh", "/usr/local/bin/wp-setup.sh"]
