#!/bin/bash

# Function to show the banner
show_banner() {
    clear
    echo -e "\e[1;36m" # Cyan color start
    echo "  ____  ____   ____    _    __  __ _____ ____  "
    echo " / ___||  _ \ / ___|  / \  |  \/  | ____|  _ \ "
    echo " \___ \| | | | |  _  / _ \ | |\/| |  _| | |_) |"
    echo "  ___) | |_| | |_| |/ ___ \| |  | | |___|  _ < "
    echo " |____/|____/ \____/_/   \_\_|  |_|_____|_| \_\\"
    echo -e "\e[0m" # Color reset
    echo "=================================================="
    echo "       PROJECT: SKA HOST (SDGAMER) PANEL          "
    echo "=================================================="
}

# Pause function to wait for Enter
pause() {
    echo ""
    echo -e "\e[1;32mCommand Finished!\e[0m"
    read -p "Press [Enter] key to continue..."
}

# Blueprint Sub-menu
blueprint_menu() {
    while true; do
        show_banner
        echo -e "\e[1;35m             Blueprint Menu (V26.1)               \e[0m"
        echo "--------------------------------------------------"
        echo "1) Blueprint Installer (V26.1.1)"
        echo "2) Blueprint Installer (V26.1.2)"
        echo "3) Blueprint Auto Fix Installer (V26.1.1)"
        echo "0) Back to Main Menu"
        echo "--------------------------------------------------"
        echo -n "Enter your choice [0-3]: "
        read -r bp_choice

        case $bp_choice in
            1)
                echo "Starting Blueprint 1..."
                bash <(curl -sL https://raw.githubusercontent.com/sdgamer8263-sketch/Theme/main/blueprint.sh)
                pause
                ;;
            2)
                echo "Starting Blueprint 2..."
                bash <(curl -sL https://raw.githubusercontent.com/sdgamer8263-sketch/Theme/main/blueprint-2.sh)
                pause
                ;;
            3)
                echo "Starting Fix Blueprint..."
                bash <(curl -sL https://raw.githubusercontent.com/sdgamer8263-sketch/Theme/main/fix.sh)
                pause
                ;;
            0)
                # Break out of the sub-menu loop to return to Main Menu
                break
                ;;
            *)
                echo -e "\e[1;31mInvalid input!\e[0m Please select 0 to 3."
                sleep 2
                ;;
        esac
    done
}

# Main Menu function
show_menu() {
    show_banner
    echo -e "\e[1;33mBlueprint And Theme + Extentions Configuration (V26.1)\e[0m"
    echo "--------------------------------------------------"
    echo "1) Blueprint Installer"
    echo "2) Theme + Extension"
    echo "3) Pterodactyl Email Setup"
    echo "4) Uninstall Extension"
    echo "0) Exit"
    echo "--------------------------------------------------"
    echo -n "Enter your choice [0-4]: "
}

# Main Logic Loop
while true; do
    show_menu
    read -r choice

    case $choice in
        1)
            blueprint_menu
            ;;
        2)
            echo "Starting Theme + Extension..."
            bash <(curl -sL https://raw.githubusercontent.com/sdgamer8263-sketch/Theme/main/chang.sh)
            pause
            ;;
        3)
            echo "Setup Email..."
            bash <(curl -sL https://raw.githubusercontent.com/sdgamer8263-sketch/adon/main/email.sh)
            pause
            ;;
        4)
            echo "Uninstalling Extension..."
            bash <(curl -sL https://raw.githubusercontent.com/sdgamer8263-sketch/Theme/main/uninstallblueprint.sh)
            pause
            ;;   
        0)
            echo "Exiting... Good Luck!"
            exit 0
            ;;
        *)
            echo -e "\e[1;31mInvalid input!\e[0m Please select 0 to 4."
            sleep 2
            ;;
    esac
done
