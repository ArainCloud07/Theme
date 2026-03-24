#!/bin/bash

# Colors setup
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

PANEL_DIR="/var/www/pterodactyl"

# SDGAMER Banner
clear
echo -e "${CYAN}"
cat << "EOF"
  ____  ____   ____    _    __  __ _____ ____  
 / ___||  _ \ / ___|  / \  |  \/  | ____|  _ \ 
 \___ \| | | | |  _  / _ \ | |\/| |  _| | |_) |
  ___) | |_| | |_| |/ ___ \| |  | | |___|  _ < 
 |____/|____/ \____/_/   \_\_|  |_|_____|_| \_\
 
EOF
echo -e "${NC}"
echo -e "${YELLOW}      Welcome to SKA HOST (SDGAMER) - Blueprint Installer${NC}"
echo -e "${CYAN}=================================================================${NC}"
echo ""

# 1. Check if Pterodactyl is installed
if [ ! -d "$PANEL_DIR" ] || [ ! -f "$PANEL_DIR/artisan" ]; then
    echo -e "${RED}[ERROR] Pterodactyl Panel not found at $PANEL_DIR!${NC}"
    echo -e "${YELLOW}Please install Pterodactyl Panel first before installing Blueprint.${NC}"
    exit 1
fi

# 2. Automatically Detect Pterodactyl Version
cd $PANEL_DIR
PTERO_VERSION=$(php artisan --version | awk '{print $3}')
echo -e "${GREEN}[+] Detected Pterodactyl Panel Version: ${CYAN}${PTERO_VERSION}${NC}"
echo -e "${GREEN}[+] Preparing Blueprint Setup for this version...${NC}"
echo ""

# Update Function
update_blueprint() {
    echo -e "${YELLOW}Starting Blueprint Update & Setup...${NC}"
    cd $PANEL_DIR
    
    # Run official Blueprint upgrade command if available
    if command -v blueprint > /dev/null; then
        blueprint -upgrade
    else
        # Fallback manual update
        wget https://github.com/teamblueprint/main/releases/latest/download/blueprint.zip
        unzip -o blueprint.zip
        chmod +x blueprint.sh
        bash blueprint.sh
    fi
    
    echo -e "${GREEN}Blueprint Update & Setup Completed Successfully!${NC}"
}

# Install Function
install_blueprint() {
    echo -e "${YELLOW}Starting Fresh Blueprint Installation & Setup...${NC}"

    # Install System Dependencies required for Blueprint
    echo -e "${CYAN}Installing Required Dependencies (Node.js, Yarn, Zip, etc.)...${NC}"
    apt update -y
    apt install -y ca-certificates curl gnupg zip unzip git wget

    # Install Node.js (Required for Yarn and Blueprint build process)
    if ! command -v node > /dev/null; then
        mkdir -p /etc/apt/keyrings
        curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
        echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list
        apt update -y
        apt install -y nodejs
    fi

    # Install Yarn Globally
    npm install -g yarn

    # Download and Install Blueprint Framework
    echo -e "${CYAN}Downloading Blueprint Framework...${NC}"
    cd $PANEL_DIR
    wget https://github.com/teamblueprint/main/releases/latest/download/blueprint.zip
    unzip -o blueprint.zip
    
    # Set permissions and Run
    chmod +x blueprint.sh
    echo -e "${CYAN}Executing Blueprint Setup Script...${NC}"
    bash blueprint.sh

    echo -e "${GREEN}Fresh Blueprint Installation & Setup Completed Successfully!${NC}"
}

# ==========================================
# Main Execution Logic
# ==========================================

# Check if Blueprint is already installed (Checking for blueprint command or internal folder)
if command -v blueprint > /dev/null || [ -f "$PANEL_DIR/blueprint.sh" ] || [ -d "$PANEL_DIR/.blueprint" ]; then
    echo -e "${YELLOW}Blueprint Framework is already installed on this system!${NC}"
    update_blueprint
else
    echo -e "${GREEN}No existing Blueprint Framework found.${NC}"
    install_blueprint
fi

echo -e "${CYAN}Process Finished! You can now use Blueprint commands.${NC}"
