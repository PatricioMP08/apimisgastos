# --- Etapa 1: Base PHP ---
FROM php:8.3-apache

# Habilitar mod_rewrite para Lumen
RUN a2enmod rewrite

# Instalar extensiones necesarias (PDO, SQLite, etc.)
RUN apt-get update && apt-get install -y \
    libsqlite3-dev \
    unzip \
    git \
    && docker-php-ext-install pdo pdo_sqlite \
    && rm -rf /var/lib/apt/lists/*

# Copiar todo el proyecto al contenedor
COPY . /var/www/html

# Establecer permisos correctos para storage y bootstrap/cache
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache \
    && chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

# Configurar Apache para servir desde /public
RUN sed -i 's|/var/www/html|/var/www/html/public|g' /etc/apache2/sites-available/000-default.conf

# Crear .htaccess en /public para redirigir todas las rutas a index.php
RUN echo '<IfModule mod_rewrite.c>\n\
RewriteEngine On\n\
RewriteCond %{REQUEST_FILENAME} !-f\n\
RewriteRule ^ index.php [QSA,L]\n\
</IfModule>' > /var/www/html/public/.htaccess

# Exponer puerto 80
EXPOSE 80

# Comando para iniciar Apache en primer plano
CMD ["apache2-foreground"]
