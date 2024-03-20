FROM php:8.2-apache

# Instalacja narzędzi do generowania certyfikatów SSL
RUN apt-get update && apt-get install -y \
    openssl \
    && rm -rf /var/lib/apt/lists/*

# Ustawianie środowiska Apache do obsługi SSL
RUN a2enmod ssl
RUN a2ensite default-ssl

# Tworzenie katalogu na certyfikaty SSL
RUN mkdir /etc/apache2/ssl

# Generowanie certyfikatu SSL dla localhost
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/apache2/ssl/apache.key \
    -out /etc/apache2/ssl/apache.crt \
    -subj "/C=US/ST=State/L=City/O=Organization/CN=localhost"

# Konfiguracja VirtualHost Apache dla SSL
COPY project.conf /etc/apache2/sites-available/default.conf
COPY project.conf /etc/apache2/sites-available/default-ssl.conf
RUN a2ensite default
RUN a2ensite default-ssl

### Na tę scieżkę skopiuj projekt ###
WORKDIR /var/www/html

RUN docker-php-ext-install pdo pdo_mysql

### Ścieżka do folderu z projektem ###
COPY public_html/cryland/ /var/www/html/

EXPOSE 80
EXPOSE 443
