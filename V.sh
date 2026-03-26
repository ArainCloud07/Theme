#!/bin/bash

# Reset
NC='\033[0m'

# Style
BOLD='\033[1m'

# Foreground Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'
BRIGHT_WHITE='\033[97m'

# Background Colors
BG_RED='\033[41m'
BG_GREEN='\033[42m'
BG_YELLOW='\033[43m'
BG_BLUE='\033[44m'

print_info() {
  echo -e "\n  ${BG_BLUE}${BRIGHT_WHITE}${BOLD} INFO ${NC} ${BOLD}$1${NC}\n"
}

print_success() {
  echo -e "\n  ${BG_GREEN}${BRIGHT_WHITE}${BOLD} SUCCESS ${NC} ${BOLD}$1${NC}\n"
}

print_error() {
  echo -e "\n  ${BG_RED}${BRIGHT_WHITE}${BOLD} ERROR ${NC} ${BOLD}$1${NC}\n"
}

print_warning() {
  echo -e "\n  ${BG_YELLOW}${BRIGHT_WHITE}${BOLD} WARNING ${NC} ${BOLD}$1${NC}\n"
}

start_script() {
  clear
  echo -e ""
  echo -e "${BOLD}${BLUE}[+] =============================================== [+]${NC}"
  echo -e "${BOLD}${BLUE}[+]                                                 [+]${NC}"
  echo -e "${BOLD}${BLUE}[+]             ARIX THEME AUTO INSTALLER           [+]${NC}"
  echo -e "${BOLD}${BLUE}[+]              © SKA HOST (SDGAMER)               [+]${NC}"
  echo -e "${BOLD}${BLUE}[+]                                                 [+]${NC}"
  echo -e "${BOLD}${BLUE}[+] =============================================== [+]${NC}"
  echo -e ""
  echo -e "This script was created specifically to install the Arix theme from GitHub."
  echo -e "Make sure Pterodactyl is already installed correctly."
  echo -e ""
  sleep 2
}

install_arix() {
  echo " "
  echo -n -e "${BOLD}Start Arix theme installation? (y/n): ${NC}"
  read confirmation
  if [[ "$confirmation" != [yY] ]]; then 
      echo -e "${BOLD}Installation cancelled.${NC}"; exit 0; 
  fi
  
  set -e
  export DEBIAN_FRONTEND=noninteractive
  export NEEDRESTART_MODE=a

  if [ ! -d "/var/www/pterodactyl" ]; then
    print_error "Pterodactyl directory not found. Install Pterodactyl first!"
    exit 1
  fi

  print_info "[1/6] Preparing System & Downloading Arix Files..."
  sudo apt-get update -y > /dev/null 2>&1
  sudo apt-get install -y curl zip unzip wget > /dev/null 2>&1

  cd /var/www/pterodactyl
  
  # GitHub Raw Link (sdgamer8263-sketch/Theme/Fg/arix.zip)
  wget -q -O arix.zip "https://raw.githubusercontent.com/sdgamer8263-sketch/Theme/main/Fg/arix.zip"
  
  if [ ! -f "arix.zip" ]; then
      print_error "Failed to download arix.zip from GitHub. Check the link or your connection."
      exit 1
  fi

  print_info "[2/6] Extracting Theme Files..."
  unzip -o -q arix.zip
  rm arix.zip

  print_info "[3/6] Updating Panel Dependencies (Composer)..."
  sudo -u www-data env COMPOSER_PROCESS_TIMEOUT=2000 composer install --no-dev --optimize-autoloader --no-interaction > /dev/null 2>&1

  print_info "[4/6] Running Database & Arix Setup..."
  php artisan migrate --force
  php artisan arix
  
  print_info "[5/6] Clearing Cache..."
  php artisan view:clear
  php artisan config:clear
  php artisan cache:clear
  php artisan optimize:clear
  chmod -R 755 storage/* bootstrap/cache

  print_info "[6/6] Building Theme Assets (Yarn Build)..."
  
  # Check Node.js version 22
  CURRENT_NODE_VER=$(node -v 2>/dev/null | cut -d'.' -f1 | sed 's/v//')
  if [[ "$CURRENT_NODE_VER" != "22" ]]; then
      print_warning "Node.js v22 not found. Installing Node.js v22..."
      sudo apt-get remove -y nodejs npm > /dev/null 2>&1 || true
      sudo rm -rf /etc/apt/sources.list.d/nodesource.list
      sudo mkdir -p /etc/apt/keyrings
      curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor --yes | sudo tee /etc/apt/keyrings/nodesource.gpg > /dev/null
      echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_22.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list > /dev/null
      sudo apt-get update -y > /dev/null 2>&1
      sudo apt-get install -y nodejs > /dev/null 2>&1
  fi

  hash -r
  sudo npm i -g yarn > /dev/null 2>&1
  
  # Fix common OpenSSL errors
  export NODE_OPTIONS=--openssl-legacy-provider
  
  yarn install
  yarn run build:production

  # Set Final Ownership
  chown -R www-data:www-data /var/www/pterodactyl/*

  print_success "Arix Theme successfully installed!"
  echo " "
  echo -e "${BOLD}${GREEN}[+] =============================================== [+]${NC}"
  echo -e "${BOLD}${GREEN}[+]       INSTALLATION SUCCESSFULLY COMPLETED       [+]${NC}"
  echo -e "${BOLD}${GREEN}[+]            Please Refresh Your Panel            [+]${NC}"
  echo -e "${BOLD}${GREEN}[+] =============================================== [+]${NC}"
  echo " "
  sleep 2
}

# Run functions
start_script
install_arix
