# Usamos PHP 8.2 con Apache
FROM php:8.2-apache

# Instalamos extensiones necesarias para Lumen + SQLite
RUN docker-php-ext-install pdo pdo_sqlite

# Copiamos todo el proyecto al contenedor
COPY . /var/www/html/

# Establecemos el directorio de trabajo
WORKDIR /var/www/html

# Ajustamos permisos para almacenamiento y SQLite
RUN chown -R www-data:www-data storage database \
    && chmod -R 775 storage database

# Habilitamos mod_rewrite de Apache
RUN a2enmod rewrite

# Configuramos Apache para que use public/ como raíz
RUN sed -i 's|/var/www/html|/var/www/html/public|g' /etc/apache2/sites-available/000-default.conf

# Exponemos el puerto 8080
EXPOSE 8080

# Comando por defecto para iniciar Apache
CMD ["apache2-foreground"]
