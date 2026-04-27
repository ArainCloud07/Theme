curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
apt-get install -y nodejs && \
npm install -g yarn && \
cd /var/www/pterodactyl && \
wget -O arix0.zip https://raw.githubusercontent.com/sdgamer8263-sketch/Theme/main/F/arix0.zip && \
unzip -o arix0.zip && \
cd /var/www/pterodactyl

yarn install yarn build

php artisan view:clear
php artisan cache:clear
