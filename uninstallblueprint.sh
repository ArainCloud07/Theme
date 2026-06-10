#!/bin/bash

# Clear screen for better look
clear

# SD GAMER Banner
echo "-------------------------------------------------------"
echo "  ____  _   _ _   _ ____  _   _    _    __  __ "
echo " / ___|| | | | | | | __ )| | | |  / \  |  \/  |"
echo " \___ \| |_| | | | |  _ \| |_| | / _ \ | |\/| |"
echo "  ___) |  _  | |_| | |_) |  _  |/ ___ \| |  | |"
echo " |____/|_| |_|\___/|____/|_| |_/_/   \_\_|  |_|"
echo "        BLUEPRINT EXTENSION MANAGER v1.0       "
echo "-------------------------------------------------------"

# Navigate to Pterodactyl directory
blueprint -upgrade
cd /var/www/pterodactyl || { echo "Error: Directory /var/www/pterodactyl not found!"; exit 1; }

# Check if extensions folder exists
if [ ! -d "extensions" ]; then
    echo "Blueprint extensions folder not found. Is Blueprint installed?"
    echo "Checking for core files..."
    if [ ! -d "blueprint" ]; then
        echo "No Blueprint installation detected."
        exit 1
    fi
fi

echo "Installed Extensions:"
echo "------------------------------------------"

# Create an array of extension names
mapfile -t EXTENSIONS < <(ls -1 extensions/ 2>/dev/null)

# Display extensions with numbers
if [ ${#EXTENSIONS[@]} -eq 0 ]; then
    echo "No individual extensions found."
else
    for i in "${!EXTENSIONS[@]}"; do
        echo "$((i+1)). ${EXTENSIONS[$i]}"
    done
fi

# Add a "Remove All" option
ALL_OPTION=$(( ${#EXTENSIONS[@]} + 1 ))
echo "$ALL_OPTION. REMOVE ALL BLUEPRINT FILES (COMPLETE UNINSTALL)"
echo "------------------------------------------"
echo -n "Enter the NUMBER you want to delete: "
read -r CHOICE

# Validation and Deletion
if [[ "$CHOICE" -eq "$ALL_OPTION" ]]; then
    echo "!!!"
    echo "Removing all Blueprint files, extensions, and framework..."
    rm -rf blueprint .blueprint extensions
elif [[ "$CHOICE" -gt 0 && "$CHOICE" -le "${#EXTENSIONS[@]}" ]]; then
    TARGET=${EXTENSIONS[$((CHOICE-1))]}
    echo "Removing extension: $TARGET..."
    rm -rf "extensions/$TARGET"
else
    echo "Invalid choice. Exiting script."
    exit 1
fi

# Cleanup and Permissions
echo "------------------------------------------"
echo "Step 2: Clearing Pterodactyl cache..."
php artisan view:clear
php artisan cache:clear

echo "Step 3: Fixing file permissions..."
chown -R www-data:www-data /var/www/pterodactyl/*

echo "------------------------------------------"
echo "SUCCESS: Operation completed by SD GAMER."
echo "------------------------------------------"
