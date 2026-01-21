
# Stage 0: install Node dependencies
FROM node:18-alpine AS npm-installer

WORKDIR /usr/src/app
COPY www/package.json ./

# install node.js dependencies e.g. Vue (but not the development dependencies)
RUN npm install --omit=dev --ignore-scripts

# Stage 1: runtime image
FROM php:8.3.30-apache

ENV \
	SKOSMOS=v3.0-maintenance

# APCU
RUN pecl install apcu \
	&& mkdir -p /usr/src/php/ext/apcu && curl -fsSL https://pecl.php.net/get/apcu | tar xvz -C "/usr/src/php/ext/apcu" --strip 1 \
	&& docker-php-ext-install apcu \
	&& docker-php-ext-enable apcu --ini-name 10-docker-php-ext-apcu.ini


# xml*
RUN apt-get update \
	&& apt-get install -y \
		libxslt-dev --no-install-recommends \
	&& CFLAGS="-I/usr/src/php" docker-php-ext-install xsl \
	&& apt-get purge -y \
		libxslt-dev

# zip*
RUN apt-get update \
	&& apt-get install -y \
		libzip-dev \
		zlib1g-dev \
	&& docker-php-ext-install zip

# mbstring
RUN apt-get update \
	&& apt-get install -y \
		libmcrypt-dev \
		libonig-dev \
		libicu-dev \
	&& docker-php-ext-install mbstring \
	&& apt-get purge -y \
		libmcrypt-dev \
		libonig-dev

# Gettext, locale, timezone
RUN apt-get install -y locales \
	&& docker-php-ext-install -j$(nproc) \
		gettext \
		intl && \
		sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
		sed -i -e 's/# en_GB.UTF-8 UTF-8/en_GB.UTF-8 UTF-8/' /etc/locale.gen && \
		sed -i -e 's/# es_ES.UTF-8 UTF-8/es_ES.UTF-8 UTF-8/' /etc/locale.gen && \
		sed -i -e 's/# fr_FR.UTF-8 UTF-8/fr_FR.UTF-8 UTF-8/' /etc/locale.gen && \
		sed -i -e 's/# de_DE.UTF-8 UTF-8/de_DE.UTF-8 UTF-8/' /etc/locale.gen && \
		sed -i -e 's/# ar_AE.UTF-8 UTF-8/ar_AE.UTF-8 UTF-8/' /etc/locale.gen && \
        sed -i -e 's/# da_DK.UTF-8 UTF-8/da_DK.UTF-8 UTF-8/' /etc/locale.gen && \
        sed -i -e 's/# fa_IR.UTF-8 UTF-8/fa_IR.UTF-8 UTF-8/' /etc/locale.gen && \
        sed -i -e 's/# fi_FI.UTF-8 UTF-8/fi_FI.UTF-8 UTF-8/' /etc/locale.gen && \
        sed -i -e 's/# it_IT.UTF-8 UTF-8/it_IT.UTF-8 UTF-8/' /etc/locale.gen && \
        sed -i -e 's/# nb_NO.UTF-8 UTF-8/nb_NO.UTF-8 UTF-8/' /etc/locale.gen && \
        sed -i -e 's/# nl_NL.UTF-8 UTF-8/nl_NL.UTF-8 UTF-8/' /etc/locale.gen && \
        sed -i -e 's/# nn_NO.UTF-8 UTF-8/nn_NO.UTF-8 UTF-8/' /etc/locale.gen && \
        sed -i -e 's/# pl_PL.UTF-8 UTF-8/pl_PL.UTF-8 UTF-8/' /etc/locale.gen && \
        sed -i -e 's/# pt_PT.UTF-8 UTF-8/pt_PT.UTF-8 UTF-8/' /etc/locale.gen && \
        sed -i -e 's/# pt_BR.UTF-8 UTF-8/pt_BR.UTF-8 UTF-8/' /etc/locale.gen && \
        sed -i -e 's/# ru_RU.UTF-8 UTF-8/ru_RU.UTF-8 UTF-8/' /etc/locale.gen && \
        sed -i -e 's/# sv_SE.UTF-8 UTF-8/sv_SE.UTF-8 UTF-8/' /etc/locale.gen && \
        sed -i -e 's/# zh_CN.UTF-8 UTF-8/zh_CN.UTF-8 UTF-8/' /etc/locale.gen && \
		locale-gen

ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8



# Apache : modules
RUN a2enmod rewrite \
	&& a2enmod headers \
	&& a2enmod status

# set ServerName & redirect error log to stderr for docker logs
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf && \
        sed -ri \
        -e 's!^(\s*ErrorLog)\s+\S+!\1 /proc/self/fd/1!g' \
        "/etc/apache2/apache2.conf"

# PHP: composer
RUN apt-get update \
	&& apt-get install -y git unzip \
	&& curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Cleanup
RUN apt-get autoremove -y

COPY www/php.ini /usr/local/etc/php/php.ini

# timezone
RUN sed -i 's/;date.timezone =/date.timezone = "UTC"/g' /usr/local/etc/php/php.ini

# Skosmos
RUN mkdir -p /srv 
WORKDIR /srv
RUN mkdir Skosmos \
	&& chown `whoami` Skosmos

RUN rm -rf /var/www/html/* \ 
	&&  git clone -b ${SKOSMOS} https://github.com/NatLibFi/Skosmos.git  /var/www/html/


# install Node modules (from npm-installer stage)
COPY --from=npm-installer /usr/src/app/node_modules /var/www/html/node_modules

#configure skosmos
COPY www/config.ttl /var/www/html/


# ezmasterization
# see https://github.com/Inist-CNRS/ezmaster
RUN echo '{ \
  "httpPort": 80, \
  "configPath": "/usr/local/etc/php/php.ini", \
  "configType": "text", \
  "dataPath": "/var/www/html/" \
}' > /etc/ezmaster.json

COPY docker-entrypoint.overload.sh composer-install.sh /usr/local/bin/
ENTRYPOINT [ "docker-entrypoint.overload.sh" ]
CMD ["apache2-foreground"]
