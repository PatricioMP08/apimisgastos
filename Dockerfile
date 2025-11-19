# --- Etapa 1: Imagen base con PHP y SQLite ---
FROM php:8.3-cli

# Instalar extensiones necesarias y utilidades
RUN apt-get update && apt-get install -y \
    libsqlite3-dev \
    zip unzip git \
    && docker-php-ext-install pdo pdo_sqlite

# Establecer directorio de trabajo
WORKDIR /var/www/html

# Copiar archivos del proyecto al contenedor
COPY . .

# Crear archivo de base de datos SQLite si no existe
RUN mkdir -p database \
    && touch database/database.sqlite

# Dar permisos correctos para storage y bootstrap/cache
RUN mkdir -p storage/framework/cache storage/framework/sessions storage/framework/views bootstrap/cache \
    && chown -R www-data:www-data storage bootstrap/cache \
    && chmod -R 775 storage bootstrap/cache

# Instalar Composer y dependencias PHP
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer
RUN composer install --optimize-autoloader --no-dev --no-interaction

# Establecer variables de entorno
ENV APP_ENV=production \
    APP_DEBUG=false \
    APP_KEY=base64:xgkNtNZCFQ6lBoEBI678IjSL5TLufgz8In1JacCw3/g= \
    DB_CONNECTION=sqlite \
    DB_DATABASE=/var/www/html/database/database.sqlite \
    CACHE_DRIVER=file \
    QUEUE_CONNECTION=sync

# Exponer el puerto que Render usará
EXPOSE 8080

# Iniciar el servidor PHP built-in con el router de Lumen
CMD ["php", "-S", "0.0.0.0:8080", "-t", "public", "public/index.php"]
