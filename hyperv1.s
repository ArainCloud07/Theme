   wget -O installer.sh https://r2.rolexdev.tech/hyperv1/installer.sh
            chmod +x installer.sh
            sudo ./installer.sh
            rm installer.sh
            cd /var/www/pterodactyl
            php artisan view:clear
            php artisan config:clear
            php artisan queue:restart
