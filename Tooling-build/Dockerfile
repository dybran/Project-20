FROM php:7-apache
LABEL "Project"="tooling"
LABEL "Author"="Solomon Onwuasoanya"
LABEL "Description"="Building the tooling app"


RUN docker-php-ext-install mysqli
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
COPY apache-config.conf /etc/apache2/sites-available/000-default.conf
COPY start-apache /usr/local/bin
RUN a2enmod rewrite

# Copy application source
COPY html /var/www
RUN chown -R www-data:www-data /var/www

ENV MYSQL_IP=mysqlserverhost
ENV MYSQL_USER=dybran
ENV MYSQL_PASS=password
ENV MYSQL_DBNAME=toolingdb

CMD ["start-apache"]