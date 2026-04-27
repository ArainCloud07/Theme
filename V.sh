cd /var/www/pterodactyl && \
wget https://raw.githubusercontent.com/sdgamer1263-sketch/Theme/main/sdca.zip && \
unzip -o sdca.zip && \
yarn install && \
yarn build:production && \
php artisan view:clear && \
php artisan config:clear && \
chown -R www-data:www-data /var/www/pterodactyl/*
