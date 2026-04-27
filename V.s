curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
apt-get install -y nodejs && \
npm install -g yarn && \
cd /var/www/pterodactyl && \
wget -O sdsa.zip https://raw.githubusercontent.com/sdgamer8263-sketch/Theme/main/F/sdsa.zip && \
unzip -o sdsa.zip && \
cp -r sdsa/* ./ && \
rm -rf sdsa sdsa.zip && \
yarn install && \
yarn build:production && \
php artisan view:clear && \
php artisan config:clear && \
chown -R www-data:www-data /var/www/pterodactyl/*
