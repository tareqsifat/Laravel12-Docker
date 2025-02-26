FROM php:8.2-fpm

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y software-properties-common git zip unzip && \
    rm -rf /var/lib/apt/lists/*

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

    # Set working directory
    WORKDIR /var/www/html/

    # Copy existing application directory contents
    COPY ./Project /var/www/html/

    # Install Laravel dependencies
    RUN composer install

    # Expose port 8000 and start the PHP built-in server
    EXPOSE 8000
    CMD php artisan serve --host=0.0.0.0 --port=8000