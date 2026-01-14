# -------------------------------
# PHP 5.5 Full Image with GD, MySQL, PDO, FPDF
# -------------------------------

FROM nyanpass/php5.5:5.5-apache

# -------------------------------
# Use archived Debian Jessie repositories (old packages)
# -------------------------------
RUN sed -i 's|httpredir.debian.org|archive.debian.org|g' /etc/apt/sources.list \
    && sed -i '/jessie-updates/d' /etc/apt/sources.list \
    && sed -i '/security.debian.org/d' /etc/apt/sources.list \
    && echo 'Acquire::Check-Valid-Until "0";' > /etc/apt/apt.conf.d/99no-check-valid-until \
    && echo 'Acquire::AllowInsecureRepositories "true";' >> /etc/apt/apt.conf.d/99no-check-valid-until \
    && echo 'APT::Get::AllowUnauthenticated "true";' >> /etc/apt/apt.conf.d/99no-check-valid-until

# -------------------------------
# Install dependencies for GD and MySQL
# -------------------------------
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libmysqlclient-dev \
        zlib1g-dev \
        wget \
        ca-certificates \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install pdo pdo_mysql mysqli mysql \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# -------------------------------
# Add FPDF library (from local file)
# -------------------------------
# Make sure you have downloaded fpdf.php on your host and placed it as lib/fpdf.php
COPY lib/fpdf.php /usr/local/lib/php/fpdf/fpdf.php
RUN echo 'include_path=".:/usr/local/lib/php/fpdf"' > /usr/local/etc/php/conf.d/fpdf.ini

# -------------------------------
# Set Apache document root
# -------------------------------
WORKDIR /var/www/html

# Expose port 80
EXPOSE 80

