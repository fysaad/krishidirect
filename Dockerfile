FROM php:8.2-apache

# Install MySQL/PDO extensions your app needs
RUN docker-php-ext-install pdo pdo_mysql mysqli

# Enable .htaccess / URL rewriting if your app uses it
RUN a2enmod rewrite

# Apache listens on port 80 by default; Render provides a $PORT env var
# that we need to bind to instead.
RUN sed -i 's/80/${PORT}/g' /etc/apache2/sites-available/000-default.conf /etc/apache2/ports.conf
ENV PORT 80

# Copy your project files into Apache's web root
COPY . /var/www/html/

# Make sure Apache can read your files
RUN chown -R www-data:www-data /var/www/html

EXPOSE 80

CMD ["apache2-foreground"]
