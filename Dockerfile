# FROM php:8.1-apache


# RUN apt-get update \
#     && apt-get install git libpq-dev libmcrypt-dev libzip-dev --yes

# RUN docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql

# RUN docker-php-ext-install \
#     mysqli \
#     pgsql \
#     pdo \
#     pdo_mysql \
#     pdo_pgsql \
#     zip

# RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

FROM php:8.1-apache

# Instala pacotes necessários
RUN apt-get update \
    && apt-get install -y git libpq-dev libzip-dev --no-install-recommends

# Instala extensões do PHP
RUN docker-php-ext-install mysqli pgsql pdo pdo_mysql pdo_pgsql zip

# Instala o Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copia o código do projeto para o diretório do Apache
COPY . /var/www/html/

# Configura as permissões adequadas
RUN chown -R www-data:www-data /var/www/html

# Expõe a porta 80
EXPOSE 80
