#!/bin/sh

WP_PATH="/var/www/html"

echo "Waiting MariaDB..."
sleep 5

if [ ! -f "$WP_PATH/wp-config.php" ]; then
    echo "Downloading Wordpress..."
    wp core download \
        --path=$WP_PATH \
        --allow-root

    echo "Building wp-config.php..."
    wp config create \
        --path=$WP_PATH \
        --dbname=$DB_NAME \
        --dbuser=$DB_USER \
        --dbpass=$DB_PASSWORD \
        --dbhost=$DB_HOST \
        --allow-root

    echo "Installation Wordpress..."
    wp core install \
        --path=$WP_PATH \
        --url=$WP_URL \
        --title="$WP_TITLE" \
        --admin_user=$WP_ADMIN \
        --admin_password=$WP_ADMIN_PWD \
        --admin_email=$WP_ADMIN_EMAIL \
        --skip-email \
        --allow-root

    echo "Creation user..."
    wp user create \
        $WP_USER \
        $WP_USER_EMAIL \
        --user_pass=$WP_USER_PWD \
        --role=author \
        --path=$WP_PATH \
        --allow-root

else
    echo "Wordpress is already install !"
fi

echo "Launching PHP-FPM..."
php-fpm81 -F
