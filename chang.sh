#!/bin/bash

# Colors
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
CYAN="\e[36m"
MAGENTA="\e[35m"
RESET="\e[0m"

line() {
    echo -e "${MAGENTA}====================================================${RESET}"
}

banner() {
    echo -e "${CYAN}"
    echo "  ____  ____     ____    _    __  __ _____ ____  "
    echo " / ___||  _ \   / ___|  / \  |  \/  | ____|  _ \ "
    echo " \___ \| | | | | |  _  / _ \ | |\/| |  _| | |_) |"
    echo "  ___) | |_| | | |_| |/ ___ \| |  | | |___|  _ < "
    echo " |____/|____/   \____/_/   \_\_|  |_|_____|_| \_\\"
    
    echo -e "${RESET}"
    
}

# ===== MAIN MENU =====
while true; do
    clear
    banner
    line
    
    echo -e "${CYAN}                    MAIN MENU  (V 26.1)                     ${RESET}"

    line
    echo -e "${YELLOW}1)${RESET} Themes"
    echo -e "${YELLOW}2)${RESET} Blueprint Extensions ${CYAN}(Auto Install)${RESET}"
    echo -e "${YELLOW}0)${RESET} Exit"
    line
    read -p "Choose an option: " opt

    case "$opt" in

        1)
            echo -e "${GREEN}🎨 Running Themes installer...${RESET}"
            bash <(curl -sL https://raw.githubusercontent.com/sdgamer8263-sketch/Theme/main/Theme.sh)
            echo -e "${GREEN}✅ Themes process finished!${RESET}"
            sleep 2
        ;;

        2)
            echo -e "${GREEN}🛠 Running Blueprint Extensions installer...${RESET}"
            bash <(curl -fsSL https://raw.githubusercontent.com/sdgamer8263-sketch/pterodactyl_extention/main/install.sh)
            echo -e "${GREEN}✅ Extension process finished!${RESET}"
            sleep 2
        ;;

        0)
            echo -e "${CYAN}Goodbye, legend… 🚀${RESET}"
            exit 0
        ;;

        *)
            echo -e "${RED}Galat option… try again.${RESET}"
            sleep 1
        ;;
    esac
done 

