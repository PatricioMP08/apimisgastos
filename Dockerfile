# 1. Imagen base con PHP 8.3 y extensiones necesarias
FROM php:8.3-fpm

# 2. Instalar dependencias del sistema y extensiones de PHP necesarias
RUN apt-get update && apt-get install -y \
        libsqlite3-dev \
        zip unzip \
        git \
        curl \
        libonig-dev \
        libxml2-dev \
        pkg-config \
        && docker-php-ext-install pdo pdo_sqlite \
        && apt-get clean && rm -rf /var/lib/apt/lists/*

# 3. Instalar Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# 4. Establecer directorio de trabajo
WORKDIR /var/www/html

# 5. Copiar proyecto al contenedor
COPY . .

# 6. Crear carpetas necesarias y establecer permisos
RUN mkdir -p storage/framework/cache/data bootstrap/cache \
    && chown -R www-data:www-data storage bootstrap/cache \
    && chmod -R 775 storage bootstrap/cache

# 7. Instalar dependencias de PHP
RUN composer install --no-dev --optimize-autoloader

# 8. Establecer usuario www-data
USER www-data

# 9. Exponer el puerto 8080
EXPOSE 8080

# 10. Comando por defecto para iniciar Lumen
CMD ["php", "-S", "0.0.0.0:8080", "-t", "public"]
