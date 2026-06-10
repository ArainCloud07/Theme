#!/bin/bash

# ==========================================
# COLOR CONFIGURATION
# ==========================================
NC='\e[0m'
BOLD='\e[1m'
RED='\e[1;31m'
GREEN='\e[1;32m'
YELLOW='\e[1;33m'
BLUE='\e[1;34m'
MAGENTA='\e[1;35m'
CYAN='\e[1;36m'
WHITE='\e[1;37m'

# ==========================================
# UI FUNCTIONS
# ==========================================

show_banner() {
    clear
    echo -e "${CYAN}${BOLD}"
    echo "  ____  _   _ _   _ ____  _   _    _    __  __ "
    echo " / ___|| | | | | | | __ )| | | |  / \  |  \/  |"
    echo " \___ \| |_| | | | |  _ \| |_| | / _ \ | |\/| |"
    echo "  ___) |  _  | |_| | |_) |  _  |/ ___ \| |  | |"
    echo " |____/|_| |_|\___/|____/|_| |_/_/   \_\_|  |_|"
    echo -e "${NC}"
    echo -e "${MAGENTA}❖ ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ ❖${NC}"
    echo -e "${BOLD}${WHITE}           PROJECT: Backchodh (Shubham) PANEL  (V26.1)     ${NC}"
    echo -e "${MAGENTA}❖ ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ ❖${NC}"
    echo ""
}

print_header() {
    echo -e "${YELLOW}▶ $1${NC}"
    echo -e "${CYAN}----------------------------------------------------------${NC}"
}

print_option() {
    echo -e "  ${WHITE}[${CYAN}$1${WHITE}]${NC} $2"
}

pause() {
    echo ""
    echo -e "${GREEN}${BOLD}✔ Task Completed Successfully!${NC}"
    read -p "$(echo -e "${YELLOW}Press [Enter] to continue...${NC}")"
}

# ==========================================
# SUB-MENUS
# ==========================================

blueprint_menu() {
    while true; do
        show_banner
        print_header "BLUEPRINT MENU (V26.1)"
        
        print_option "1" "Blueprint Installer (V26.1.1)"
        print_option "2" "Blueprint Installer (V26.1.2)"
        print_option "3" "Blueprint Auto Fix Installer (V26.1.1)"
        echo ""
        print_option "0" "${RED}Back to Main Menu${NC}"
        echo -e "${CYAN}----------------------------------------------------------${NC}"
        
        echo -n -e "${BOLD}${YELLOW}Enter your choice [0-3]: ${NC}"
        read -r bp_choice

        case $bp_choice in
            1)
                echo -e "\n${CYAN}Starting Blueprint 1 Installation...${NC}"
                bash <(curl -sL https://raw.githubusercontent.com/ArainCloud07/Theme/refs/heads/main/blueprint.sh)
                pause
                ;;
            2)
                echo -e "\n${CYAN}Starting Blueprint 2 Installation...${NC}"
                bash <(curl -sL https://raw.githubusercontent.com/ArainCloud07/Theme/refs/heads/main/blueprint-2.sh)
                pause
                ;;
            3)
                echo -e "\n${CYAN}Starting Blueprint Auto Fix...${NC}"
                bash <(curl -sL https://raw.githubusercontent.com/ArainCloud07/Theme/refs/heads/main/fix.sh)
                pause
                ;;
            0)
                break
                ;;
            *)
                echo -e "\n${RED}✖ Invalid input! Please select a valid option.${NC}"
                sleep 2
                ;;
        esac
    done
}

manage_extensions() {
    EXT_DIR="/var/www/pterodactyl/.blueprint/extensions"
    
    if [ ! -d "$EXT_DIR" ]; then
        echo -e "\n${RED}✖ Blueprint or Extensions directory not found!${NC}"
        return
    fi

    EXT_LIST=($(ls -1 "$EXT_DIR" 2>/dev/null))
    
    if [ ${#EXT_LIST[@]} -eq 0 ]; then
        echo -e "\n${YELLOW}⚠ No extensions are currently installed.${NC}"
        return
    fi

    echo -e "\n${CYAN}${BOLD}Installed Extensions:${NC}"
    for i in "${!EXT_LIST[@]}"; do
        print_option "$((i+1))" "${EXT_LIST[$i]}"
    done
    
    echo -e "${CYAN}----------------------------------------------------------${NC}"
    echo -e "${WHITE}Type ${BOLD}${RED}'all'${NC}${WHITE} to uninstall everything.${NC}"
    echo -e "${WHITE}Or type numbers separated by commas (e.g. ${CYAN}1,3,4${NC}${WHITE}).${NC}"
    echo -n -e "\n${BOLD}${YELLOW}Your choice: ${NC}"
    read -r ext_choice

    if [[ "${ext_choice,,}" == "all" ]]; then
        echo -e "\n${RED}Uninstalling ALL extensions...${NC}"
        bash <(curl -sL https://raw.githubusercontent.com/ArainCloud07/Theme/refs/heads/main/uninstallblueprint.sh)
    else
        IFS=',' read -ra SELECTED_EXTS <<< "$ext_choice"
        for sel in "${SELECTED_EXTS[@]}"; do
            sel=$(echo "$sel" | tr -d ' ') 
            if [[ "$sel" =~ ^[0-9]+$ ]] && [ "$sel" -gt 0 ] && [ "$sel" -le "${#EXT_LIST[@]}" ]; then
                EXT_NAME="${EXT_LIST[$((sel-1))]}"
                echo -e "${YELLOW}Uninstalling extension: ${WHITE}$EXT_NAME${NC}"
                
                cd /var/www/pterodactyl || return
                blueprint -remove "$EXT_NAME"
            else
                echo -e "${RED}✖ Invalid selection skipped: $sel${NC}"
            fi
        done
    fi
}

uninstaller_menu() {
    while true; do
        show_banner
        print_header "UNINSTALLER (V26.1)"
        
        print_option "1" "Blueprint Uninstaller"
        print_option "2" "Theme Uninstaller"
        print_option "3" "Blueprint Extension Uninstaller"
        echo ""
        print_option "0" "${RED}Back to Main Menu${NC}"
        echo -e "${CYAN}----------------------------------------------------------${NC}"
        
        echo -n -e "${BOLD}${YELLOW}Enter your choice [0-3]: ${NC}"
        read -r un_choice

        case $un_choice in
            1)
                echo -e "\n${RED}Uninstalling Blueprint...${NC}"
                # Add your custom curl link here if needed
                pause
                ;;
            2)
                echo -e "\n${RED}Uninstalling Theme...${NC}"
                # Add your custom curl link here if needed
                pause
                ;;
            3)
                manage_extensions
                pause
                ;;
            0)
                break
                ;;
            *)
                echo -e "\n${RED}✖ Invalid input! Please select a valid option.${NC}"
                sleep 2
                ;;
        esac
    done
}

# ==========================================
# MAIN MENU
# ==========================================

show_menu() {
    show_banner
    print_header "CONFIGURATION SETUP (V26.1)"
    
    print_option "1" "Blueprint Installer Hub"
    print_option "2" "Theme + Extension Installer"
    print_option "3" "Pterodactyl Email Setup"
    print_option "4" "Uninstaller Hub"
    echo ""
    print_option "0" "${RED}Exit Script${NC}"
    echo -e "${CYAN}----------------------------------------------------------${NC}"
    
    echo -n -e "${BOLD}${YELLOW}Enter your choice [0-4]: ${NC}"
}

# ==========================================
# MAIN LOGIC LOOP
# ==========================================

while true; do
    show_menu
    read -r choice

    case $choice in
        1)
            blueprint_menu
            ;;
        2)
            echo -e "\n${CYAN}Starting Theme + Extension Setup...${NC}"
            bash <(curl -sL https://raw.githubusercontent.com/ArainCloud07/Theme/refs/heads/main/chang.sh)
            pause
            ;;
        3)
            echo -e "\n${CYAN}Initializing Email Setup...${NC}"
            bash <(curl -sL https://raw.githubusercontent.com/ArainCloud07/adon/refs/heads/main/email.sh)
            pause
            ;;
        4)
            uninstaller_menu
            ;;   
        0)
            echo -e "\n${GREEN}${BOLD}Exiting... Have a great day!${NC}"
            exit 0
            ;;
        *)
            echo -e "\n${RED}✖ Invalid input! Please select an option between 0 and 4.${NC}"
            sleep 2
            ;;
    esac
done
