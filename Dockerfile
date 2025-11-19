# Usamos PHP 8.3 con Apache
FROM php:8.3-apache

# Instalamos dependencias para compilar pdo_sqlite
RUN apt-get update && apt-get install -y \
    libsqlite3-dev \
    && docker-php-ext-install pdo pdo_sqlite \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copiamos todo el proyecto al contenedor
COPY . /var/www/html/

# Establecemos el directorio de trabajo
WORKDIR /var/www/html

# Ajustamos permisos para storage y base de datos SQLite
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
