cd /var/www/pterodactyl && \
wget https://raw.githubusercontent.com/sdgamer8263-sketch/Theme/main/F/sdsa.zip && \
unzip -o sdsa.zip && \
yarn install && \
yarn build:production && \
php artisan view:clear && \
php artisan config:clear && \
chown -R www-data:www-data /var/www/pterodactyl/*
