#!/bin/bash

# Colors setup
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

PANEL_DIR="/var/www/pterodactyl"

# Banner
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
echo -e "${YELLOW}           Welcome to SKA HOST (SDGAMER)${NC}"
echo -e "${CYAN}=================================================${NC}"
echo -e "${GREEN}       Blueprint Updater & Downgrader            ${NC}"
echo ""

# Check if Panel is installed
if [ ! -d "$PANEL_DIR" ]; then
    echo -e "${RED}[ERROR] Pterodactyl Panel is not installed in $PANEL_DIR!${NC}"
    echo -e "${YELLOW}Blueprint needs Pterodactyl to be installed first.${NC}"
    exit 1
fi

cd $PANEL_DIR

# Ask for the specific Blueprint version
echo -e "${YELLOW}Note: Check the exact release tag on GitHub (e.g., v2024.1.0)${NC}"
read -p "Enter Blueprint Version: " VERSION

echo -e "${GREEN}Starting process for Blueprint version ${VERSION}...${NC}"

# Download the specific version zip file
echo -e "${YELLOW}Downloading Blueprint files for ${VERSION}...${NC}"
curl -L -o blueprint.zip https://github.com/teamblueprint/main/releases/download/${VERSION}/blueprint.zip

# STRICT CHECK: Verify if the download is a valid zip archive
if ! unzip -t blueprint.zip > /dev/null 2>&1; then
    echo -e "${RED}[ERROR] Failed to download Blueprint version ${VERSION}!${NC}"
    echo -e "${YELLOW}Exact version tag ta check koro GitHub theke.${NC}"
    rm -f blueprint.zip
    exit 1
fi

# Extract files and clean up the zip
echo -e "${GREEN}Download valid! Extracting files...${NC}"
unzip -o blueprint.zip > /dev/null 2>&1
rm -f blueprint.zip

# Run the Blueprint setup script
echo -e "${YELLOW}Running Blueprint setup...${NC}"
chmod +x blueprint.sh
bash blueprint.sh

echo -e "${CYAN}=================================================${NC}"
echo -e "${GREEN}Blueprint successfully updated/downgraded to ${VERSION}!${NC}"
echo -e "${CYAN}=================================================${NC}"
