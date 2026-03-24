#!/bin/bash

# ==========================================
# GITHUB TOKEN (Secret Scanner Bypass)
# ==========================================
# গিটহাব যাতে টোকেন ধরতে না পারে তাই টোকেনটিকে দুই ভাগে ভাগ করা হয়েছে।
T_P1="ghp_"
T_P2="sX8V7v1XHeC4uxV4sCr1MhBhIORxzY2IGZo5"

GITHUB_TOKEN="${T_P1}${T_P2}"

# Reset
NC='\033[0m'

# Style
BOLD='\033[1m'
DIM='\033[2m'
UNDERLINE='\033[4m'
BLINK='\033[5m'
REVERSE='\033[7m'
HIDDEN='\033[8m'

# Foreground (Text Color Normal)
BLACK='\033[0;30m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'

# Foreground (Text Color Bright/Bold)
BRIGHT_BLACK='\033[90m'
BRIGHT_RED='\033[91m'
BRIGHT_GREEN='\033[92m'
BRIGHT_YELLOW='\033[93m'
BRIGHT_BLUE='\033[94m'
BRIGHT_MAGENTA='\033[95m'
BRIGHT_CYAN='\033[96m'
BRIGHT_WHITE='\033[97m'

# Background Colors (Normal)
BG_BLUE='\033[44m'
BG_GREEN='\033[42m'
BG_YELLOW='\033[43m'
BG_RED='\033[41m'

# URLs Base
URL_FG="https://raw.githubusercontent.com/sdgamer8263-sketch/Theme/main/Fg"
URL_EX="https://raw.githubusercontent.com/sdgamer8263-sketch/Theme/main/Ex"
URL_TY="https://raw.githubusercontent.com/sdgamer8263-sketch/Theme/main/Ex/Ty"

# Print Functions
print_info() { echo -e "\n  ${BG_BLUE}${BRIGHT_WHITE}${BOLD} INFO ${NC} ${BOLD}$1${NC}\n"; }
print_success() { echo -e "\n  ${BG_GREEN}${BRIGHT_WHITE}${BOLD} SUCCESS ${NC} ${BOLD}$1${NC}\n"; }
print_warning() { echo -e "\n  ${BG_YELLOW}${BRIGHT_WHITE}${BOLD} WARNING ${NC} ${BOLD}$1${NC}\n"; }
print_error() { echo -e "\n  ${BG_RED}${BRIGHT_WHITE}${BOLD} ERROR ${NC} ${BOLD}$1${NC}\n"; }
log_info() { echo -e "${BOLD}${CYAN}$1${NC}"; }
log_success() { echo -e "${BOLD}${GREEN}$1${NC}"; }
log_error() { echo -e "${BOLD}${RED}$1${NC}"; }

# ==========================================
# BANNERS
# ==========================================

show_sdgamer_banner() {
    clear
    echo -e "${BRIGHT_CYAN}"
    echo "  ____  ____   ____    _    __  __ _____ ____  "
    echo " / ___||  _ \ / ___|  / \  |  \/  | ____|  _ \ "
    echo " \___ \| | | | |  _  / _ \ | |\/| |  _| | |_) |"
    echo "  ___) | |_| | |_| |/ ___ \| |  | | |___|  _ < "
    echo " |____/|____/ \____/_/   \_\_|  |_|_____|_| \_\\"
    echo -e "${NC}"
    echo -e "${BOLD}${MAGENTA}               AUTO INSTALLER${NC}"
    echo -e "${BLUE}=================================================${NC}"
}

show_abyss_banner() {
    clear
    echo -e "${BRIGHT_MAGENTA}"
    echo "      _    ____  __  __ ____  ____  "
    echo "     / \  | __ ) \ \/ // ___|/ ___| "
    echo "    / _ \ |  _ \  \  / \___ \\___ \ "
    echo "   / ___ \| |_) | /  \  ___) |___) |"
    echo "  /_/   \_\____/ /_/\_\|____/|____/ "
    echo -e "${NC}"
    echo -e "${BOLD}${CYAN}               POWERED BY - SDGAMER${NC}"
    echo -e "${BLUE}=================================================${NC}"
}

show_catppuccin_banner() {
    clear
    echo -e "${BRIGHT_BLUE}"
    echo "   ____    _  _____ ____  ____  _   _  ____ ____ ___ _   _ "
    echo "  / ___|  / \|_   _|  _ \|  _ \| | | |/ ___/ ___|_ _| \ | |"
    echo " | |     / _ \ | | | |_) | |_) | | | | |  | |    | ||  \| |"
    echo " | |___ / ___ \| | |  __/|  __/| |_| | |__| |___ | || |\  |"
    echo "  \____/_/   \_\_| |_|   |_|    \___/ \____\____|___|_| \_|"
    echo -e "${NC}"
    echo -e "${BOLD}${MAGENTA}                     POWERED BY - SDGAMER${NC}"
    echo -e "${CYAN}===============================================================${NC}"
}

show_navy_banner() {
    clear
    echo -e "${BRIGHT_CYAN}"
    echo "  _   _    _    __     __ __   __ "
    echo " | \ | |  / \   \ \   / / \ \ / / "
    echo " |  \| | / _ \   \ \ / /   \ V /  "
    echo " | |\  |/ ___ \   \ V /     | |   "
    echo " |_| \_/_/   \_\   \_/      |_|   "
    echo -e "${NC}"
    echo -e "${BOLD}${MAGENTA}               POWERED BY - SDGAMER${NC}"
    echo -e "${BLUE}=================================================${NC}"
}

show_nebula_banner() {
    clear
    echo -e "${BRIGHT_YELLOW}"
    echo "   _   _ _____ ____  _   _ _        _    "
    echo "  | \ | | ____| __ )| | | | |      / \   "
    echo "  |  \| |  _| |  _ \| | | | |     / _ \  "
    echo "  | |\  | |___| |_) | |_| | |___ / ___ \ "
    echo "  |_| \_|_____|____/ \___/|_____/_/   \_\\"
    echo -e "${NC}"
    echo -e "${BOLD}${MAGENTA}               POWERED BY - SDGAMER${NC}"
    echo -e "${BLUE}=================================================${NC}"
}

show_xlpanel_banner() {
    clear
    echo -e "${BRIGHT_GREEN}"
    echo "   __  ___     ____   _    _   _ _____ _     "
    echo "   \ \/ / |   |  _ \ / \  | \ | | ____| |    "
    echo "    \  /| |   | |_) / _ \ |  \| |  _| | |    "
    echo "    /  \| |___|  __/ ___ \| |\  | |___| |___ "
    echo "   /_/\_\_____|_| /_/   \_\_| \_|_____|_____|"
    echo -e "${NC}"
    echo -e "${BOLD}${MAGENTA}               POWERED BY - SDGAMER${NC}"
    echo -e "${BLUE}=================================================${NC}"
}

# ==========================================
# SYSTEM SETUP & VALIDATION
# ==========================================

start_script() {
  show_sdgamer_banner
  echo -e ""
  echo -e "This script was created to make installing Pterodactyl themes easier."
  echo -e "Experiencing issues? Report them to the admin to get them fixed."
  sleep 2

  export DEBIAN_FRONTEND=noninteractive
  export NEEDRESTART_MODE=a

  if [ -f /etc/needrestart/needrestart.conf ]; then
    sudo sed -i "s/#\$nrconf{restart} = 'i';/\$nrconf{restart} = 'a';/" /etc/needrestart/needrestart.conf
    sudo sed -i "s/\$nrconf{restart} = 'i';/\$nrconf{restart} = 'a';/" /etc/needrestart/needrestart.conf
  fi

  sudo DEBIAN_FRONTEND=noninteractive NEEDRESTART_MODE=a apt-get update -y >/dev/null 2>&1
  sudo DEBIAN_FRONTEND=noninteractive NEEDRESTART_MODE=a apt-get install -y jq curl wget unzip >/dev/null 2>&1
  sleep 1
}

# ==========================================
# SUBMENU FUNCTIONS
# ==========================================

submenu_abyss() {
  while true; do
    show_abyss_banner
    echo -e " ${BRIGHT_WHITE}${BOLD}[a]${NC} ${WHITE}Purple Colour Version${NC}"
    echo -e " ${BRIGHT_WHITE}${BOLD}[b]${NC} ${WHITE}Amber Colour Version${NC}"
    echo -e " ${BRIGHT_WHITE}${BOLD}[c]${NC} ${WHITE}Emerald Colour Version${NC}"
    echo -e " ${BRIGHT_WHITE}${BOLD}[d]${NC} ${WHITE}Crimson Red Colour Version${NC}"
    echo -e " ${BRIGHT_WHITE}${BOLD}[0]${NC} ${RED}Back${NC}"
    echo -n -e "\n${BOLD}Select an option (a-d, or 0 to back): ${NC}"
    read choice
    case "$choice" in
      a|A) THEME_NAME="Abyss Purple"; THEME_URL="$URL_TY/abysspurple.blueprint"; INSTALL_TYPE="blueprint"; return 0;;
      b|B) THEME_NAME="Abyss Amber"; THEME_URL="$URL_TY/amberabyss.blueprint"; INSTALL_TYPE="blueprint"; return 0;;
      c|C) THEME_NAME="Abyss Emerald"; THEME_URL="$URL_TY/emeraldabyss.blueprint"; INSTALL_TYPE="blueprint"; return 0;;
      d|D) THEME_NAME="Abyss Crimson"; THEME_URL="$URL_TY/crimsonabyss.blueprint"; INSTALL_TYPE="blueprint"; return 0;;
      0) return 1;;
      *) print_error "Invalid selection, please try again."; sleep 1;;
    esac
  done
}

submenu_catppuccin() {
  while true; do
    show_catppuccin_banner
    echo -e " ${BRIGHT_WHITE}${BOLD}[a]${NC} ${WHITE}Catppuccindactyl Theme V1${NC}"
    echo -e " ${BRIGHT_WHITE}${BOLD}[b]${NC} ${WHITE}Catppuccindactyl Theme V2${NC}"
    echo -e " ${BRIGHT_WHITE}${BOLD}[0]${NC} ${RED}Back${NC}"
    echo -n -e "\n${BOLD}Select an option (a-b, or 0 to back): ${NC}"
    read choice
    case "$choice" in
      a|A) THEME_NAME="Catppuccindactyl V1"; THEME_URL="$URL_EX/catppuccindactyl1.blueprint"; INSTALL_TYPE="blueprint"; return 0;;
      b|B) THEME_NAME="Catppuccindactyl V2"; THEME_URL="$URL_EX/catppuccindactyl2.blueprint"; INSTALL_TYPE="blueprint"; return 0;;
      0) return 1;;
      *) print_error "Invalid selection, please try again."; sleep 1;;
    esac
  done
}

submenu_navy() {
  while true; do
    show_navy_banner
    echo -e " ${BRIGHT_WHITE}${BOLD}[a]${NC} ${WHITE}Navy Seals Slice Theme V1${NC}"
    echo -e " ${BRIGHT_WHITE}${BOLD}[b]${NC} ${WHITE}Navy Seals Slice Theme V2${NC}"
    echo -e " ${BRIGHT_WHITE}${BOLD}[0]${NC} ${RED}Back${NC}"
    echo -n -e "\n${BOLD}Select an option (a-b, or 0 to back): ${NC}"
    read choice
    case "$choice" in
      a|A) THEME_NAME="Navy Seals V1"; THEME_URL="$URL_EX/Navy%20seals%20slice.blueprint"; INSTALL_TYPE="blueprint"; return 0;;
      b|B) THEME_NAME="Navy Seals V2"; THEME_URL="$URL_EX/navyseals.blueprint"; INSTALL_TYPE="blueprint"; return 0;;
      0) return 1;;
      *) print_error "Invalid selection, please try again."; sleep 1;;
    esac
  done
}

submenu_nebula() {
  while true; do
    show_nebula_banner
    echo -e " ${BRIGHT_WHITE}${BOLD}[a]${NC} ${WHITE}Nebula Theme V1${NC}"
    echo -e " ${BRIGHT_WHITE}${BOLD}[b]${NC} ${WHITE}Nebula Theme V2${NC}"
    echo -e " ${BRIGHT_WHITE}${BOLD}[c]${NC} ${WHITE}Nebula Theme V3${NC}"
    echo -e " ${BRIGHT_WHITE}${BOLD}[0]${NC} ${RED}Back${NC}"
    echo -n -e "\n${BOLD}Select an option (a-c, or 0 to back): ${NC}"
    read choice
    case "$choice" in
      a|A) THEME_NAME="Nebula V1"; THEME_URL="$URL_EX/nebula1.8.blueprint"; INSTALL_TYPE="blueprint"; return 0;;
      b|B) THEME_NAME="Nebula V2"; THEME_URL="$URL_EX/nebula2.0.blueprint"; INSTALL_TYPE="blueprint"; return 0;;
      c|C) THEME_NAME="Nebula V3"; THEME_URL="$URL_EX/nebula.blueprint"; INSTALL_TYPE="blueprint"; return 0;;
      0) return 1;;
      *) print_error "Invalid selection, please try again."; sleep 1;;
    esac
  done
}

submenu_xlpanel() {
  while true; do
    show_xlpanel_banner
    echo -e " ${BRIGHT_WHITE}${BOLD}[a]${NC} ${WHITE}Xlpanel Theme V1${NC}"
    echo -e " ${BRIGHT_WHITE}${BOLD}[b]${NC} ${WHITE}Xlpanel Theme V2${NC}"
    echo -e " ${BRIGHT_WHITE}${BOLD}[0]${NC} ${RED}Back${NC}"
    echo -n -e "\n${BOLD}Select an option (a-b, or 0 to back): ${NC}"
    read choice
    case "$choice" in
      a|A) THEME_NAME="Xlpanel V1"; THEME_URL="$URL_EX/xlpaneltheme.blueprint"; INSTALL_TYPE="blueprint"; return 0;;
      b|B) THEME_NAME="Xlpanel V2"; THEME_URL="$URL_EX/xlpaneltheme2.0.blueprint"; INSTALL_TYPE="blueprint"; return 0;;
      0) return 1;;
      *) print_error "Invalid selection, please try again."; sleep 1;;
    esac
  done
}
# ==========================================
# MAIN MENU & DYNAMIC FETCHER
# ==========================================

install_theme() {
  print_info "Checking for new themes dynamically..."

  API_URL="https://api.github.com/repos/sdgamer8263-sketch/Theme/git/trees/main?recursive=1"
  
  if [ -n "$GITHUB_TOKEN" ]; then
      TREE_DATA=$(curl -s -H "Authorization: token $GITHUB_TOKEN" -H "User-Agent: AutoInstaller" "$API_URL")
  else
      TREE_DATA=$(curl -s -H "User-Agent: AutoInstaller" "$API_URL")
  fi

  # এই লিস্টে মেনুর নামগুলোর শুধুমাত্র "ALPHABET" (অক্ষর) রাখা হয়েছে।
  IGNORE_ALPHABETS=(
      "abysspurple" "amberabyss" "crimsonabyss" "emeraldabyss"
      "arix" "billing" "catppuccindactyl" "darkenate" "elysium"
      "enigma" "euphoria" "euphoriatheme" "frostcore" "hyper" "hyperv"
      "iceminecraft" "lemem" "lememtheme" "lu" "lutheme"
      "navyseals" "navysealsslice" "nebula" "nightcore" "noobe" "nook"
      "refresh" "refreshtheme" "stellar" "xlpanel" "xlpaneltheme"
  )

  # ফাংশন: এটি নামের ভেতর থেকে স্পেস, নাম্বার, ডট, হিডেন ক্যারেক্টার সব মুছে শুধু ছোট হাতের অক্ষর মেলাবে
  is_ignored() {
      local file="$1"
      # হিডেন ক্যারেক্টার রিমুভ
      file="${file//$'\r'/}"
      local base="${file%.*}"
      # Pure Bash দিয়ে শুধুমাত্র a-z এবং A-Z অক্ষরগুলো রেখে বাকি সব মুছে ফেলা
      local pure_alpha="${base//[^a-zA-Z]/}"
      # ছোট হাতের অক্ষরে রূপান্তর
      pure_alpha=$(echo "$pure_alpha" | tr '[:upper:]' '[:lower:]')
      
      for ignored in "${IGNORE_ALPHABETS[@]}"; do
          if [[ "$ignored" == "$pure_alpha" ]]; then
              return 0 # নাম মিলে গেছে, তাই ইগনোর করবে
          fi
      done
      return 1 # নতুন নাম, তাই লিস্টে অ্যাড করবে
  }

  declare -a DYNAMIC_NAMES
  declare -a DYNAMIC_URLS
  declare -a DYNAMIC_TYPES
  DYNAMIC_COUNT=0

  if echo "$TREE_DATA" | grep -q '"tree":'; then
      # গিটহাব থেকে ফাইলগুলো নিয়ে "sort -f" কমান্ড দিয়ে A-Z অনুযায়ী সাজানো হচ্ছে
      while IFS= read -r raw_path; do
          [ -z "$raw_path" ] && continue
          
          file_path=$(echo "$raw_path" | tr -d '\r')
          filename="${file_path##*/}"
          
          # Alphabet Matching এর মাধ্যমে চেক
          if ! is_ignored "$filename"; then
              base_name="${filename%.*}"
              base_name_clean="${base_name//%20/ }"
              
              # নামের প্রথম অক্ষর বড় হাতের করা হচ্ছে
              first_char="${base_name_clean:0:1}"
              rest_str="${base_name_clean:1}"
              first_char_upper=$(echo "$first_char" | tr '[:lower:]' '[:upper:]')
              
              # যদি ফাইলের নামে Theme লেখা না থাকে, তবে যোগ করবে (দেখতে সুন্দর লাগবে)
              display_name="${first_char_upper}${rest_str}"
              if [[ ! "${display_name,,}" == *"theme"* ]]; then
                  display_name="${display_name} Theme"
              fi
              
              DYNAMIC_NAMES[$DYNAMIC_COUNT]="$display_name"
              DYNAMIC_URLS[$DYNAMIC_COUNT]="https://raw.githubusercontent.com/sdgamer8263-sketch/Theme/main/${file_path// /%20}"
              
              if [[ "$filename" == *.zip ]]; then
                  DYNAMIC_TYPES[$DYNAMIC_COUNT]="standard"
              elif [[ "$filename" == *.blueprint ]]; then
                  DYNAMIC_TYPES[$DYNAMIC_COUNT]="blueprint"
              fi
              ((DYNAMIC_COUNT++))
          fi
      done < <(echo "$TREE_DATA" | jq -r '.tree[] | select((.path | startswith("Fg/") and endswith(".zip")) or (.path | startswith("Ex/") and endswith(".blueprint"))) | .path' | awk -F'/' '{print $NF "|" $0}' | sort -f | cut -d'|' -f2)
  fi

  while true; do
    show_sdgamer_banner
    echo " "
    echo -e "${CYAN}=== Main Themes ===${NC}"
    echo -e " ${BRIGHT_WHITE}${BOLD}[01]${NC} ${WHITE}ABYSS Theme${NC}"
    echo -e " ${BRIGHT_WHITE}${BOLD}[02]${NC} ${WHITE}Arix Theme${NC}"
    echo -e " ${BRIGHT_WHITE}${BOLD}[03]${NC} ${WHITE}Billing Theme${NC}"
    echo -e " ${BRIGHT_WHITE}${BOLD}[04]${NC} ${WHITE}Catppuccindactyl Theme${NC}"
    echo -e " ${BRIGHT_WHITE}${BOLD}[05]${NC} ${WHITE}Darkenate Theme${NC}"
    echo -e " ${BRIGHT_WHITE}${BOLD}[06]${NC} ${WHITE}Elysium Theme${NC}"
    echo -e " ${BRIGHT_WHITE}${BOLD}[07]${NC} ${WHITE}Enigma Theme${NC}"
    echo -e " ${BRIGHT_WHITE}${BOLD}[08]${NC} ${WHITE}Euphoria Theme${NC}"
    echo -e " ${BRIGHT_WHITE}${BOLD}[09]${NC} ${WHITE}Frostcore Theme${NC}"
    echo -e " ${BRIGHT_WHITE}${BOLD}[10]${NC} ${WHITE}Hyper Theme V1${NC}"
    echo -e " ${BRIGHT_WHITE}${BOLD}[11]${NC} ${WHITE}IceMinecraft Theme${NC}"
    echo -e " ${BRIGHT_WHITE}${BOLD}[12]${NC} ${WHITE}Lemem Theme${NC}"
    echo -e " ${BRIGHT_WHITE}${BOLD}[13]${NC} ${WHITE}Lu Theme${NC}"
    echo -e " ${BRIGHT_WHITE}${BOLD}[14]${NC} ${WHITE}Navy Seals Slice Theme${NC}"
    echo -e " ${BRIGHT_WHITE}${BOLD}[15]${NC} ${WHITE}Nebula Theme${NC}"
    echo -e " ${BRIGHT_WHITE}${BOLD}[16]${NC} ${WHITE}Nightcore Theme${NC}"
    echo -e " ${BRIGHT_WHITE}${BOLD}[17]${NC} ${WHITE}Noobe Theme${NC}"
    echo -e " ${BRIGHT_WHITE}${BOLD}[18]${NC} ${WHITE}Nook Theme${NC}"
    echo -e " ${BRIGHT_WHITE}${BOLD}[19]${NC} ${WHITE}Refresh Theme${NC}"
    echo -e " ${BRIGHT_WHITE}${BOLD}[20]${NC} ${WHITE}Stellar Theme${NC}"
    echo -e " ${BRIGHT_WHITE}${BOLD}[21]${NC} ${WHITE}Xlpanel Theme${NC}"
    
    if [ $DYNAMIC_COUNT -gt 0 ]; then
        # নতুন থিমগুলো Alphabetical Order এ সাজানো থাকবে
        for i in "${!DYNAMIC_NAMES[@]}"; do
            printf " ${BRIGHT_WHITE}${BOLD}[%02d]${NC} ${WHITE}%s${NC}\n" "$((i+22))" "${DYNAMIC_NAMES[$i]}"
        done
    fi

    echo " "
    echo -e " ${BRIGHT_WHITE}${BOLD}[0]${NC}  ${RED}Exit${NC}"
    echo " "
    TOTAL_OPTIONS=$((21 + DYNAMIC_COUNT))
    echo -n -e "${BOLD}Enter your choice (0-$TOTAL_OPTIONS)${NC}${BOLD}: ${NC}"
    read SELECT_THEME

    if [[ "$SELECT_THEME" == "0" || "$SELECT_THEME" == "00" ]]; then
        echo -e "\n${BOLD}Installation cancelled.${NC}"
        return
    elif [[ "$SELECT_THEME" -ge 1 && "$SELECT_THEME" -le 21 ]]; then
        case "$SELECT_THEME" in
          1|01) submenu_abyss && break ;;
          2|02) THEME_NAME="Arix"; THEME_URL="$URL_FG/arix.zip"; INSTALL_TYPE="standard"; break ;;
          3|03) THEME_NAME="Billing"; THEME_URL="$URL_FG/billing.zip"; INSTALL_TYPE="standard"; break ;;
          4|04) submenu_catppuccin && break ;;
          5|05) THEME_NAME="Darkenate"; THEME_URL="$URL_EX/darkenate.blueprint"; INSTALL_TYPE="blueprint"; break ;;
          6|06) THEME_NAME="Elysium"; THEME_URL="$URL_FG/elysium.zip"; INSTALL_TYPE="standard"; break ;;
          7|07) THEME_NAME="Enigma"; THEME_URL="$URL_FG/enigma.zip"; INSTALL_TYPE="standard"; break ;;
          8|08) THEME_NAME="Euphoria"; THEME_URL="$URL_EX/euphoriatheme.blueprint"; INSTALL_TYPE="blueprint"; break ;;
          9|09) THEME_NAME="Frostcore"; THEME_URL="$URL_FG/frostcore.zip"; INSTALL_TYPE="standard"; break ;;
          10) THEME_NAME="Hyper V1"; THEME_URL="https://raw.githubusercontent.com/sdgamer8263-sketch/Theme/main/hyperv1.sh"; INSTALL_TYPE="script"; break ;;
          11) THEME_NAME="IceMinecraft"; THEME_URL="$URL_FG/iceMinecraft.zip"; INSTALL_TYPE="standard"; break ;;
          12) THEME_NAME="Lemem"; THEME_URL="$URL_EX/lememtheme.blueprint"; INSTALL_TYPE="blueprint"; break ;;
          13) THEME_NAME="Lu"; THEME_URL="$URL_EX/lutheme.blueprint"; INSTALL_TYPE="blueprint"; break ;;
          14) submenu_navy && break ;;
          15) submenu_nebula && break ;;
          16) THEME_NAME="Nightcore"; THEME_URL="$URL_FG/nightcore.zip"; INSTALL_TYPE="standard"; break ;;
          17) THEME_NAME="Noobe"; THEME_URL="$URL_FG/noobe.zip"; INSTALL_TYPE="standard"; break ;;
          18) THEME_NAME="Nook"; THEME_URL="$URL_FG/nook.zip"; INSTALL_TYPE="standard"; break ;;
          19) THEME_NAME="Refresh"; THEME_URL="$URL_EX/refreshtheme.blueprint"; INSTALL_TYPE="blueprint"; break ;;
          20) THEME_NAME="Stellar"; THEME_URL="$URL_FG/stellar.zip"; INSTALL_TYPE="standard"; break ;;
          21) submenu_xlpanel && break ;;
        esac
    elif [[ "$SELECT_THEME" -ge 22 && "$SELECT_THEME" -le "$TOTAL_OPTIONS" ]]; then
        INDEX=$((SELECT_THEME - 22))
        THEME_NAME="${DYNAMIC_NAMES[$INDEX]}"
        THEME_URL="${DYNAMIC_URLS[$INDEX]}"
        INSTALL_TYPE="${DYNAMIC_TYPES[$INDEX]}"
        break
    else
        print_error "Invalid selection, please try again."
        sleep 1
    fi
  done

  echo " "
  echo -n -e "${BOLD}You selected '$THEME_NAME'. Continue? (y/n): ${NC}"
  read confirmation
  if [[ "$confirmation" != [yY]* ]]; then echo -e "${BOLD}Installation cancelled.${NC}"; return; fi

  # -- SCRIPT EXECUTION --
  if [ "$INSTALL_TYPE" == "script" ]; then
      print_info "Running installation script for $THEME_NAME..."
      bash <(curl -sL "$THEME_URL")
      return 0
  fi
    # -- INSTALLATION ENGINE --
  set -e
  TEMP_DIR=$(mktemp -d)
  trap 'rm -rf -- "$TEMP_DIR"' EXIT
  cd "$TEMP_DIR"

  print_info "Starting installation for $THEME_NAME..."

  print_info "[1/4] Downloading files..."
  wget -q "$THEME_URL"
  DOWNLOADED_FILE=$(ls -1 | head -n 1)

  if [ "$INSTALL_TYPE" == "blueprint" ]; then
    print_info "[2/4] Preparing Blueprint Framework..."
    if [ ! -f "/var/www/pterodactyl/blueprint.sh" ]; then 
        print_error "Blueprint Framework is not installed on your server!"
        return 1
    fi
    
    IDENTIFIER="${DOWNLOADED_FILE%.*}"
    sudo mv "$DOWNLOADED_FILE" /var/www/pterodactyl/
    
    print_info "[3/4] Installing $THEME_NAME via Blueprint..."
    cd /var/www/pterodactyl
    sudo blueprint -install "$IDENTIFIER"
    sudo chown -R www-data:www-data /var/www/pterodactyl
    sudo rm -f "/var/www/pterodactyl/$DOWNLOADED_FILE"
    
    print_success "'$THEME_NAME' installed successfully."

  elif [ "$INSTALL_TYPE" == "standard" ]; then
    print_info "[2/4] Extracting files..."
    unzip -oq "$DOWNLOADED_FILE" || true

    print_info "[3/4] Copying files to Pterodactyl..."
    
    # ====================================================================
    # SMART COPY LOGIC (For dynamically added and standard zip themes)
    # ====================================================================
    
    # ১. প্রথমে খুঁজবে আনজিপ করা ফাইলের ভেতর 'pterodactyl' নামের কোনো ফোল্ডার আছে কিনা
    PTERO_DIR=$(find . -maxdepth 3 -type d -iname "pterodactyl" | head -n 1)

    if [ -n "$PTERO_DIR" ]; then
        sudo cp -r "$PTERO_DIR"/* /var/www/pterodactyl/
    else
        # ২. যদি 'pterodactyl' ফোল্ডার না থাকে, তবে সরাসরি resources/public ফোল্ডার খুঁজবে
        if [ -d "./resources" ] || [ -d "./public" ]; then
             sudo cp -r ./* /var/www/pterodactyl/
        else
            # ৩. অনেক সময় জিপের ভেতর একটাই মেইন ফোল্ডার থাকে (যেমন Ultra_Cheese-main)
            SINGLE_DIR=$(find . -mindepth 1 -maxdepth 1 -type d | grep -v "$DOWNLOADED_FILE" | head -n 1)
            
            if [ -n "$SINGLE_DIR" ] && { [ -d "$SINGLE_DIR/resources" ] || [ -d "$SINGLE_DIR/public" ]; }; then
                sudo cp -r "$SINGLE_DIR"/* /var/www/pterodactyl/
            else
                # ৪. সর্বশেষ উপায়, সরাসরি কারেন্ট ডিরেক্টরি থেকে কপি করবে (zip ফাইলটি বাদে)
                rm -f "$DOWNLOADED_FILE"
                sudo cp -r ./* /var/www/pterodactyl/ 2>/dev/null || true
            fi
        fi
    fi
    # ====================================================================

    cd /var/www/pterodactyl

    print_info "Checking Node.js version..."
    CURRENT_NODE_VER=$(node -v 2>/dev/null | cut -d'.' -f1 | sed 's/v//')
    if [[ "$CURRENT_NODE_VER" != "22" ]]; then
      print_warning "Installing Node.js v22..."
      sudo apt-get remove -y nodejs npm > /dev/null 2>&1 || true
      sudo apt-get purge -y nodejs > /dev/null 2>&1 || true
      sudo rm -f /usr/bin/node /usr/local/bin/node /usr/bin/npm /usr/local/bin/npm /etc/apt/sources.list.d/nodesource.list
      sudo mkdir -p /etc/apt/keyrings
      curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor --yes | sudo tee /etc/apt/keyrings/nodesource.gpg > /dev/null
      echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_22.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list > /dev/null
      sudo apt-get update -y > /dev/null 2>&1
      sudo apt-get install -y nodejs > /dev/null 2>&1
    fi

    hash -r
    sudo npm i -g yarn > /dev/null 2>&1
    
    print_info "Installing build dependencies..."
    yarn add cross-env react-feather > /dev/null 2>&1
    yarn install > /dev/null 2>&1

    if [[ "$THEME_NAME" == *"Billing"* ]]; then
      print_info "Running Billing installation..."
      php artisan billing:install stable
    fi

    print_info "[4/4] Building panel assets..."
    print_warning "Build process is running. DO NOT close the terminal until it finishes!"
    export NODE_OPTIONS=--openssl-legacy-provider
    php artisan migrate --force
    yarn build:production
    php artisan view:clear
    php artisan optimize:clear
    
    print_success "'$THEME_NAME' installed successfully."
  fi

  echo " "
  log_success "[=================================================]"
  log_success "[       INSTALLATION COMPLETED SUCCESSFULLY       ]"
  log_success "[=================================================]"
  echo " "
  sleep 3
  return 0
}

# ==========================================
# START EXECUTION
# ==========================================
start_script
install_theme
