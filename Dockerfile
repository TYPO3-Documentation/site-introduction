FROM php:8.4-apache-bookworm

# Install system dependencies and PHP extensions
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        git unzip curl \
        libxml2-dev libfreetype6-dev \
        libjpeg62-turbo-dev libmcrypt-dev \
        libpng-dev libpq-dev libzip-dev zlib1g-dev \
        graphicsmagick \
    && docker-php-ext-configure gd --with-libdir=/usr/include/ --with-jpeg --with-freetype \
    && docker-php-ext-install -j$(nproc) mysqli soap gd zip opcache intl pgsql pdo_pgsql exif \
    && a2enmod rewrite \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# PHP runtime configuration for TYPO3
RUN echo "max_execution_time = 240\n\
max_input_vars = 1500\n\
upload_max_filesize = 32M\n\
post_max_size = 32M" > /usr/local/etc/php/conf.d/typo3.ini

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set working directory
WORKDIR /var/www/html

# Copy only the necessary folders and files
COPY composer.json composer.lock ./
COPY Build/ Build/
COPY config/ config/
COPY packages/ packages/
# Copy the entrypoint script into the container
COPY entrypoint.sh /entrypoint.sh

# Update Apache DocumentRoot to /var/www/html/public
RUN sed -i 's|DocumentRoot /var/www/html|DocumentRoot /var/www/html/public|g' /etc/apache2/sites-available/000-default.conf && \
    echo '<Directory /var/www/html/public>\n\
    AllowOverride All\n\
    Require all granted\n\
    </Directory>' >> /etc/apache2/apache2.conf

# Ensure correct permissions
RUN chown -R www-data:www-data /var/www/html

# Make the script executable
RUN chmod +x /entrypoint.sh

# Set it as the container's entrypoint
ENTRYPOINT ["/entrypoint.sh"]
