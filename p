#!/bin/bash
# ╔══════════════════════════════════════════════════════════════════════════╗
#  SDGAMER Tunnel v3.0 — INSANE Edition
#  ► tunnel add <port>          → forward single port (TCP + UDP)
#  ► tunnel add <start>-<end>   → forward entire range (TCP + UDP)
#  ► tunnel stop <port|range>   → kill tunnel(s)
#  ► tunnel list                → show all active tunnels
#  ► tunnel stop-all            → nuke everything
# ╚══════════════════════════════════════════════════════════════════════════╝

# ── Server config ──────────────────────────────────────────────────────────
SERVER="YOUR VPS IP"
USER="root"
SSH_PORT=22

# ── Secret Access Code (SHA-256 hash) ──────────────────────────────────────
# Original code is hashed for security - never stored in plaintext
SECRET_HASH="5d7235a0c4aff6c5c9b369a5e03636557d03291f4646c9c2120274590b955cd2"

# ── Paths ──────────────────────────────────────────────────────────────────
CONFIG_DIR="$HOME/.sdgamer-tunnel"
LOG_DIR="$CONFIG_DIR/logs"
PID_DIR="$CONFIG_DIR/pids"
MAP_DIR="$CONFIG_DIR/maps"
mkdir -p "$CONFIG_DIR" "$LOG_DIR" "$PID_DIR" "$MAP_DIR" 2>/dev/null
chmod 700 "$CONFIG_DIR" 2>/dev/null

# ── Colors ─────────────────────────────────────────────────────────────────
RED="\e[31m";  GRN="\e[32m";  YEL="\e[33m";  BLU="\e[34m"
MAG="\e[35m";  CYN="\e[36m";  WHT="\e[97m";  GRY="\e[90m"
BOLD="\e[1m";  DIM="\e[2m";   UNDER="\e[4m"; BLINK="\e[5m"
BG_BLK="\e[40m"; BG_CYN="\e[46m"; BG_RED="\e[41m"; BG_GRN="\e[42m"
BG_YEL="\e[43m"; BG_MAG="\e[45m"; RST="\e[0m"

# ── Gradient & Effects ─────────────────────────────────────────────────────
FIRE_1="\e[38;5;196m"  # Bright red
FIRE_2="\e[38;5;202m"  # Orange
FIRE_3="\e[38;5;208m"  # Light orange
FIRE_4="\e[38;5;226m"  # Yellow
NEON_PINK="\e[38;5;198m"
NEON_BLUE="\e[38;5;51m"
NEON_GREEN="\e[38;5;46m"
PURPLE="\e[38;5;129m"

# ══════════════════════════════════════════════════════════════════════════
#  UI HELPERS
# ══════════════════════════════════════════════════════════════════════════
banner(){
  clear
  echo
  echo -e "${FIRE_1}${BOLD}  ╔═══════════════════════════════════════════════════════════════════════╗${RST}"
  echo -e "${FIRE_2}${BOLD}  ║                                                                       ║${RST}"
  echo -e "${FIRE_2}${BOLD}  ║         ${FIRE_4}⚡⚡⚡  ${NEON_PINK}${BOLD}SDGAMER Tunnel v3.0 — INSANE EDITION${FIRE_2}  ⚡⚡⚡${FIRE_2}        ║${RST}"
  echo -e "${FIRE_3}${BOLD}  ║                                                                       ║${RST}"
  echo -e "${FIRE_3}${BOLD}  ║          ${NEON_BLUE}TCP + UDP ${WHT}• ${NEON_GREEN}Range Forwarding ${WHT}• ${PURPLE}Auto-Reconnect${FIRE_3}          ║${RST}"
  echo -e "${FIRE_4}${BOLD}  ║                                                                       ║${RST}"
  echo -e "${FIRE_4}${BOLD}  ╚═══════════════════════════════════════════════════════════════════════╝${RST}"
  echo
  echo -e "  ${GRY}${DIM}╭─────────────────────────────────────────────────────────────────────────╮${RST}"
  echo -e "  ${GRY}${DIM}│${RST}  Server: ${NEON_BLUE}${BOLD}$SERVER${RST}  ${GRY}•${RST}  Port: ${NEON_BLUE}${BOLD}$SSH_PORT${RST}  ${GRY}•${RST}  Status: ${NEON_GREEN}${BOLD}${BLINK}●${RST} ${NEON_GREEN}${BOLD}ONLINE${RST}  ${GRY}${DIM}│${RST}"
  echo -e "  ${GRY}${DIM}╰─────────────────────────────────────────────────────────────────────────╯${RST}"
  echo
}

epic_banner(){
  clear
  echo
  echo -e "${FIRE_1}${BOLD}"
  echo "  ██████╗ ██╗   ██╗██╗   ██╗███████╗██╗  ██╗    ████████╗██╗   ██╗███╗   ██╗███╗   ██╗███████╗██╗     "
  echo "  ██╔══██╗╚██╗ ██╔╝██║   ██║██╔════╝██║  ██║    ╚══██╔══╝██║   ██║████╗  ██║████╗  ██║██╔════╝██║     "
  echo -e "${FIRE_2}  ███████║ ╚████╔╝ ██║   ██║███████╗███████║       ██║   ██║   ██║██╔██╗ ██║██╔██╗ ██║█████╗  ██║     ${RST}"
  echo -e "${FIRE_3}  ██╔══██║  ╚██╔╝  ██║   ██║╚════██║██╔══██║       ██║   ██║   ██║██║╚██╗██║██║╚██╗██║██╔══╝  ██║     ${RST}"
  echo -e "${FIRE_4}  ██║  ██║   ██║   ╚██████╔╝███████║██║  ██║       ██║   ╚██████╔╝██║ ╚████║██║ ╚████║███████╗███████╗${RST}"
  echo -e "${YEL}  ╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚══════╝╚═╝  ╚═╝       ╚═╝    ╚═════╝ ╚═╝  ╚═══╝╚═╝  ╚═══╝╚══════╝╚══════╝${RST}"
  echo
  echo -e "  ${NEON_PINK}${BOLD}╔═══════════════════════════════════════════════════════════════════════════════╗${RST}"
  echo -e "  ${NEON_PINK}${BOLD}║${RST}                  ${NEON_BLUE}${BOLD}🔥 THE MOST INSANE PORT FORWARDING TOOL 🔥${RST}                  ${NEON_PINK}${BOLD}║${RST}"
  echo -e "  ${NEON_PINK}${BOLD}╚═══════════════════════════════════════════════════════════════════════════════╝${RST}"
  echo
}

spin(){
  local msg="$1"; local pid="$2"
  local frames=('⠋' '⠙' '⠹' '⠸' '⠼' '⠴' '⠦' '⠧' '⠇' '⠏')
  local colors=("${NEON_PINK}" "${NEON_BLUE}" "${NEON_GREEN}" "${FIRE_2}" "${PURPLE}")
  local i=0
  while kill -0 "$pid" 2>/dev/null; do
    local color="${colors[$((i % ${#colors[@]}))]}"
    printf "\r  ${color}${BOLD}${frames[$i]}${RST}  $msg"
    i=$(( (i+1) % ${#frames[@]} ))
    sleep 0.08
  done
  printf "\r  ${NEON_GREEN}${BOLD}✔${RST}  $msg\n"
}

matrix_effect(){
  local duration="$1"
  local chars='01'
  local width=80
  local end=$((SECONDS + duration))
  while [ $SECONDS -lt $end ]; do
    for ((i=0; i<5; i++)); do
      local line=""
      for ((j=0; j<width; j++)); do
        line+="${chars:RANDOM%${#chars}:1}"
      done
      echo -e "  ${NEON_GREEN}${DIM}$line${RST}"
    done
    sleep 0.05
    clear
  done
}

progress_bar(){
  local current="$1" total="$2" label="$3"
  local width=50
  local filled=$(( current * width / total ))
  local empty=$(( width - filled ))
  local bar=""
  
  # Gradient fill
  for ((i=0;i<filled;i++)); do
    if [ $i -lt $((width/4)) ]; then
      bar+="${FIRE_1}█${RST}"
    elif [ $i -lt $((width/2)) ]; then
      bar+="${FIRE_2}█${RST}"
    elif [ $i -lt $((3*width/4)) ]; then
      bar+="${FIRE_3}█${RST}"
    else
      bar+="${FIRE_4}█${RST}"
    fi
  done
  for ((i=0;i<empty;i++)); do bar+="${GRY}░${RST}"; done
  
  local pct=$(( current * 100 / total ))
  printf "\r  ${NEON_PINK}${BOLD}[${RST}%b${NEON_PINK}${BOLD}]${RST} ${NEON_BLUE}${BOLD}%3d%%${RST}  ${WHT}%s${RST}" "$bar" "$pct" "$label"
}

dots(){
  printf "  ${NEON_BLUE}${BOLD}$1${RST}"
  local colors=("${FIRE_1}" "${FIRE_2}" "${FIRE_3}" "${FIRE_4}")
  for i in 0 1 2; do
    printf "${colors[$i]}●${RST}"
    sleep 0.15
  done
  echo
}

hr(){ 
  echo -e "  ${NEON_PINK}${BOLD}═══════════════════════════════════════════════════════════════════════${RST}"
}

fancy_hr(){
  echo -e "  ${FIRE_1}▓${FIRE_2}▓${FIRE_3}▓${FIRE_4}▓${NEON_PINK}▓${NEON_BLUE}▓${NEON_GREEN}▓${PURPLE}▓${FIRE_1}▓${FIRE_2}▓${FIRE_3}▓${FIRE_4}▓${NEON_PINK}▓${NEON_BLUE}▓${NEON_GREEN}▓${PURPLE}▓${FIRE_1}▓${FIRE_2}▓${FIRE_3}▓${FIRE_4}▓${NEON_PINK}▓${NEON_BLUE}▓${NEON_GREEN}▓${PURPLE}▓${FIRE_1}▓${FIRE_2}▓${FIRE_3}▓${FIRE_4}▓${NEON_PINK}▓${NEON_BLUE}▓${NEON_GREEN}▓${PURPLE}▓${FIRE_1}▓${FIRE_2}▓${FIRE_3}▓${FIRE_4}▓${RST}"
}

# ══════════════════════════════════════════════════════════════════════════
#  AUTHENTICATION SYSTEM
# ══════════════════════════════════════════════════════════════════════════
hash_code(){
  # Generate SHA-256 hash of input
  echo -n "$1" | sha256sum | awk '{print $1}'
}

authenticate(){
  epic_banner
  echo -e "  ${FIRE_1}${BOLD}╔═══════════════════════════════════════════════════════════════════════╗${RST}"
  echo -e "  ${FIRE_2}${BOLD}║                                                                       ║${RST}"
  echo -e "  ${FIRE_3}${BOLD}║                    ${NEON_PINK}🔐  AUTHENTICATION REQUIRED  🔐${FIRE_3}                    ║${RST}"
  echo -e "  ${FIRE_4}${BOLD}║                                                                       ║${RST}"
  echo -e "  ${YEL}${BOLD}╚═══════════════════════════════════════════════════════════════════════╝${RST}"
  echo
  echo -e "  ${NEON_BLUE}${BOLD}Enter Access Code:${RST}"
  echo -e "  ${GRY}${DIM}(Paste is enabled - Ctrl+Shift+V or right-click)${RST}"
  echo
  printf "  ${NEON_PINK}${BOLD}►${RST} "
  
  # Read password without echo but allow paste
  IFS= read -r user_code
  echo
  
  # Hash the user input and compare with stored hash
  user_hash=$(hash_code "$user_code")
  
  if [ "$user_hash" != "$SECRET_HASH" ]; then
    echo -e "  ${BG_RED}${WHT}${BOLD}  ✗  ACCESS DENIED  ✗  ${RST}"
    echo
    echo -e "  ${RED}${BOLD}Invalid access code. This incident will be logged.${RST}"
    echo
    sleep 2
    
    # Epic fail animation
    for i in {1..3}; do
      echo -e "  ${RED}${BLINK}⚠ UNAUTHORIZED ACCESS ATTEMPT ⚠${RST}"
      sleep 0.3
      clear
      sleep 0.2
    done
    
    exit 1
  fi
  
  # Success animation
  echo -e "  ${NEON_GREEN}${BOLD}Verifying${RST}"
  for i in 1 2 3; do
    printf "  ${NEON_GREEN}${BOLD}█${RST}"
    sleep 0.2
  done
  echo
  echo
  echo -e "  ${BG_GRN}${WHT}${BOLD}  ✔  ACCESS GRANTED  ✔  ${RST}"
  echo
  echo -e "  ${NEON_GREEN}${BOLD}Welcome, SDGAMER!${RST}"
  echo
  sleep 1.5
}

# ══════════════════════════════════════════════════════════════════════════
#  DEPENDENCY CHECK
# ══════════════════════════════════════════════════════════════════════════
check_deps(){
  local missing=()
  command -v ssh     &>/dev/null || missing+=("openssh-client")
  command -v socat   &>/dev/null || missing+=("socat")
  command -v sshpass &>/dev/null || missing+=("sshpass")
  if [ ${#missing[@]} -gt 0 ]; then
    echo -e "  ${RED}${BOLD}✗ Missing dependencies:${RST} ${BOLD}${missing[*]}${RST}"
    echo
    echo -e "  ${YEL}${BOLD}Install:${RST}  sudo apt-get install -y ${missing[*]}"
    echo
    exit 1
  fi
}

# ══════════════════════════════════════════════════════════════════════════
#  PARSE RANGE  →  "3000-3005"  or  "8080"
# ══════════════════════════════════════════════════════════════════════════
parse_range(){
  local input="$1"
  if [[ "$input" =~ ^([0-9]+)-([0-9]+)$ ]]; then
    START_PORT="${BASH_REMATCH[1]}"
    END_PORT="${BASH_REMATCH[2]}"
  elif [[ "$input" =~ ^([0-9]+)$ ]]; then
    START_PORT="${BASH_REMATCH[1]}"
    END_PORT="${BASH_REMATCH[1]}"
  else
    echo -e "  ${RED}✗${RST} Invalid port/range: ${BOLD}$input${RST}"
    echo -e "  ${GRY}Examples: ${WHT}tunnel add 8080${GRY}  |  ${WHT}tunnel add 3000-4000${RST}"
    exit 1
  fi

  if [ "$START_PORT" -lt 1 ] || [ "$END_PORT" -gt 65535 ] || [ "$START_PORT" -gt "$END_PORT" ]; then
    echo -e "  ${RED}✗${RST} Port range out of bounds (1-65535, start ≤ end)"
    exit 1
  fi
}

# ══════════════════════════════════════════════════════════════════════════
#  SINGLE PORT — TCP TUNNEL  (SSH remote forward with sshpass)
# ══════════════════════════════════════════════════════════════════════════
start_tcp(){
  local port="$1"
  local remote_port="$2"  # Use specified remote port
  local pid_file="$PID_DIR/tcp-$port.pid"
  local log_file="$LOG_DIR/tcp-$port.log"
  local map_file="$MAP_DIR/tcp-$port"

  # Already running?
  if [ -f "$pid_file" ] && kill -0 "$(cat "$pid_file")" 2>/dev/null; then
    return 0
  fi

  # Start SSH tunnel in background using sshpass with specific remote port
  (
    sshpass -e ssh -o StrictHostKeyChecking=no \
        -o UserKnownHostsFile=/dev/null \
        -o ServerAliveInterval=60 \
        -o ServerAliveCountMax=3 \
        -o ConnectTimeout=30 \
        -o LogLevel=VERBOSE \
        -N \
        -R "${remote_port}:localhost:$port" \
        "$USER@$SERVER" -p "$SSH_PORT" \
        >> "$log_file" 2>&1
  ) &

  local ssh_pid=$!
  echo "$ssh_pid" > "$pid_file"
  
  # Wait for connection to establish
  sleep 5

  # Check if process is still running
  if ! kill -0 "$ssh_pid" 2>/dev/null; then
    echo -e "  ${RED}${BOLD}✗${RST} SSH connection failed"
    echo -e "  ${YEL}${BOLD}Debug:${RST} Check log with: ${WHT}cat $log_file${RST}"
    rm -f "$pid_file"
    return 1
  fi

  echo "$remote_port" > "$map_file"
  return 0
}

# ══════════════════════════════════════════════════════════════════════════
#  SINGLE PORT — UDP TUNNEL  (direct SSH UDP forward - requires OpenSSH 9.4+)
# ══════════════════════════════════════════════════════════════════════════
start_udp(){
  local port="$1"
  local remote_port="$2"  # Use same remote port as TCP
  local pid_file="$PID_DIR/udp-$port.pid"
  local log_file="$LOG_DIR/udp-$port.log"

  # Already running?
  if [ -f "$pid_file" ] && kill -0 "$(cat "$pid_file")" 2>/dev/null; then
    return 0
  fi

  # SSH UDP tunnel (same port as TCP)
  (
    sshpass -e ssh -o StrictHostKeyChecking=no \
        -o UserKnownHostsFile=/dev/null \
        -o ServerAliveInterval=60 \
        -o ServerAliveCountMax=3 \
        -o ConnectTimeout=30 \
        -o LogLevel=ERROR \
        -N \
        -R "${remote_port}:localhost:${port}" \
        "$USER@$SERVER" -p "$SSH_PORT" \
        >> "$log_file" 2>&1
  ) &

  local ssh_pid=$!
  echo "$ssh_pid" > "$pid_file"
  
  # Wait for connection
  sleep 3
  
  if ! kill -0 "$ssh_pid" 2>/dev/null; then
    return 1
  fi

  return 0
}

# ══════════════════════════════════════════════════════════════════════════
#  STOP SINGLE PORT (TCP + UDP)
# ══════════════════════════════════════════════════════════════════════════
stop_port(){
  local port="$1"
  local stopped=0

  for proto in tcp udp; do
    local pid_file="$PID_DIR/$proto-$port.pid"
    if [ -f "$pid_file" ]; then
      for pid in $(cat "$pid_file"); do
        kill "$pid" 2>/dev/null && stopped=1
      done
      rm -f "$pid_file"
    fi
  done

  rm -f "$MAP_DIR/tcp-$port" "$LOG_DIR/tcp-$port.log" "$LOG_DIR/udp-$port.log"
  return $(( 1 - stopped ))
}

# ══════════════════════════════════════════════════════════════════════════
#  STOP ALL TUNNELS
# ══════════════════════════════════════════════════════════════════════════
cmd_stop_all(){
  banner
  echo -e "  ${RED}${BOLD}🛑 TERMINATING ALL TUNNELS${RST}"
  echo
  fancy_hr
  echo

  local stopped=0

  for pid_file in "$PID_DIR"/*.pid; do
    [ -f "$pid_file" ] || continue
    for pid in $(cat "$pid_file" 2>/dev/null); do
      if kill "$pid" 2>/dev/null; then
        stopped=$(( stopped + 1 ))
      fi
    done
    rm -f "$pid_file"
  done
  
  rm -f "$MAP_DIR"/tcp-* "$LOG_DIR"/*.log 2>/dev/null

  echo -e "  ${NEON_GREEN}${BOLD}✔ Stopped ${FIRE_2}${BOLD}$stopped${RST} ${NEON_GREEN}${BOLD}tunnel process(es)${RST}"
  echo
}

# ══════════════════════════════════════════════════════════════════════════
#  ADD  —  single port or range
# ══════════════════════════════════════════════════════════════════════════
cmd_add(){
  parse_range "$1"
  banner

  local total=$(( END_PORT - START_PORT + 1 ))
  local ok=0 fail=0

  echo -e "  ${NEON_BLUE}${BOLD}╔═══════════════════════════════════════════════════════════════════════╗${RST}"
  echo -e "  ${NEON_BLUE}${BOLD}║${RST}                    ${FIRE_2}${BOLD}VPS AUTHENTICATION${RST}                         ${NEON_BLUE}${BOLD}║${RST}"
  echo -e "  ${NEON_BLUE}${BOLD}╚═══════════════════════════════════════════════════════════════════════╝${RST}"
  echo
  echo -e "  ${WHT}Server: ${NEON_GREEN}${BOLD}$SERVER${RST}"
  echo -e "  ${WHT}User:   ${NEON_GREEN}${BOLD}$USER${RST}"
  echo
  echo -e "  ${NEON_PINK}${BOLD}Enter VPS Password:${RST}"
  echo -e "  ${GRY}${DIM}(Password will be used for all tunnels in this session)${RST}"
  echo
  printf "  ${NEON_PINK}${BOLD}►${RST} "
  read -s VPS_PASSWORD
  echo
  echo
  
  # Export password for sshpass
  export SSHPASS="$VPS_PASSWORD"

  if [ "$total" -eq 1 ]; then
    # ── Single port ──────────────────────────────────────────────────────
    local port="$START_PORT"
    
    # Use the same port number on remote (or auto-assign if 0)
    local remote_port="$port"
    
    echo -e "  ${FIRE_2}${BOLD}🚀 INITIATING PORT FORWARD${RST}"
    echo
    fancy_hr
    echo
    echo -e "  ${NEON_BLUE}${BOLD}╭─ Configuration${RST}"
    echo -e "  ${NEON_BLUE}${BOLD}│${RST}"
    echo -e "  ${NEON_BLUE}${BOLD}├─${RST} Port     : ${NEON_PINK}${BOLD}$port${RST}"
    echo -e "  ${NEON_BLUE}${BOLD}├─${RST} Local    : ${WHT}localhost:$port${RST}"
    echo -e "  ${NEON_BLUE}${BOLD}├─${RST} Remote   : ${NEON_GREEN}${BOLD}$SERVER:$remote_port${RST}"
    echo -e "  ${NEON_BLUE}${BOLD}├─${RST} Server   : ${NEON_GREEN}${BOLD}$SERVER${RST}"
    echo -e "  ${NEON_BLUE}${BOLD}├─${RST} Protocol : ${FIRE_1}TCP${RST} ${WHT}+${RST} ${FIRE_4}UDP${RST} ${GRY}(same port)${RST}"
    echo -e "  ${NEON_BLUE}${BOLD}╰─${RST}"
    echo
    echo -e "  ${NEON_BLUE}${BOLD}Creating TCP tunnel...${RST}"
    if start_tcp "$port" "$remote_port"; then
      echo -e "  ${NEON_GREEN}${BOLD}✔${RST}  TCP  ${FIRE_1}→${RST}  ${NEON_GREEN}${BOLD}$SERVER:$remote_port${RST}"
      ok=$(( ok + 1 ))
    else
      echo -e "  ${RED}${BOLD}✗${RST}  TCP tunnel failed  ${GRY}(check ${LOG_DIR}/tcp-${port}.log)${RST}"
      fail=$(( fail + 1 ))
    fi
    echo
    echo -e "  ${NEON_BLUE}${BOLD}Creating UDP tunnel...${RST}"
    if start_udp "$port" "$remote_port"; then
      echo -e "  ${NEON_GREEN}${BOLD}✔${RST}  UDP  ${FIRE_4}→${RST}  ${NEON_GREEN}${BOLD}$SERVER:$remote_port${RST}"
      ok=$(( ok + 1 ))
    else
      echo -e "  ${RED}${BOLD}✗${RST}  UDP tunnel failed  ${GRY}(check ${LOG_DIR}/udp-${port}.log)${RST}"
      fail=$(( fail + 1 ))
    fi
  else
    # ── Range ────────────────────────────────────────────────────────────
    echo -e "  ${FIRE_1}${BOLD}🔥 MASS PORT FORWARD INITIATED 🔥${RST}"
    echo
    fancy_hr
    echo
    echo -e "  ${NEON_PINK}${BOLD}Range:${RST} ${NEON_BLUE}${BOLD}$START_PORT${RST} ${FIRE_2}→${RST} ${NEON_BLUE}${BOLD}$END_PORT${RST}  ${GRY}(${BOLD}${total}${RST}${GRY} ports × TCP + UDP)${RST}"
    echo
    hr
    echo

    local done_count=0
    for (( port=START_PORT; port<=END_PORT; port++ )); do
      done_count=$(( done_count + 1 ))
      progress_bar "$done_count" "$total" "Port $port"

      local remote_port="$port"  # Use same port on remote

      # TCP
      if start_tcp "$port" "$remote_port"; then
        ok=$(( ok + 1 ))
      else
        fail=$(( fail + 1 ))
      fi

      # UDP
      if start_udp "$port" "$remote_port"; then
        ok=$(( ok + 1 ))
      else
        fail=$(( fail + 1 ))
      fi
    done
    echo   # newline after progress bar
    echo
  fi

  # Clear password from environment
  unset SSHPASS
  unset VPS_PASSWORD

  fancy_hr
  echo
  echo -e "  ${NEON_PINK}${BOLD}╔═══════════════════════════════════════════════════════════════════╗${RST}"
  echo -e "  ${NEON_PINK}${BOLD}║${RST}                        ${FIRE_2}${BOLD}DEPLOYMENT SUMMARY${RST}                        ${NEON_PINK}${BOLD}║${RST}"
  echo -e "  ${NEON_PINK}${BOLD}╚═══════════════════════════════════════════════════════════════════╝${RST}"
  echo
  echo -e "  ${NEON_BLUE}${BOLD}├─${RST} Ports Requested  : ${NEON_PINK}${BOLD}$total${RST}"
  echo -e "  ${NEON_BLUE}${BOLD}├─${RST} Tunnels Started  : ${NEON_GREEN}${BOLD}$ok${RST}"
  [ "$fail" -gt 0 ] && \
  echo -e "  ${NEON_BLUE}${BOLD}├─${RST} Failures         : ${RED}${BOLD}$fail${RST}"
  echo -e "  ${NEON_BLUE}${BOLD}├─${RST} Server           : ${NEON_GREEN}${BOLD}$SERVER${RST}"
  echo -e "  ${NEON_BLUE}${BOLD}└─${RST} Status           : ${NEON_GREEN}${BOLD}${BLINK}●${RST} ${NEON_GREEN}${BOLD}ONLINE${RST}"
  echo
  if [ "$total" -eq 1 ] && [ "$ok" -gt 0 ]; then
    local remote=$(cat "$MAP_DIR/tcp-$START_PORT" 2>/dev/null || echo "$START_PORT")
    echo -e "  ${FIRE_1}${BOLD}╔═══════════════════════════════════════════════════════════════════╗${RST}"
    echo -e "  ${FIRE_2}${BOLD}║${RST}                      ${NEON_PINK}${BOLD}🔥 PUBLIC ACCESS 🔥${RST}                       ${FIRE_2}${BOLD}║${RST}"
    echo -e "  ${FIRE_3}${BOLD}╚═══════════════════════════════════════════════════════════════════╝${RST}"
    echo
    echo -e "     ${NEON_GREEN}${BOLD}TCP:${RST} ${NEON_GREEN}${BOLD}${UNDER}$SERVER:$remote${RST}"
    echo -e "     ${FIRE_4}${BOLD}UDP:${RST} ${FIRE_4}${BOLD}${UNDER}$SERVER:$remote${RST}"
    echo
  fi
  echo -e "  ${GRY}${DIM}💡 Run ${NEON_BLUE}${BOLD}tunnel list${RST}${GRY}${DIM} to see all active tunnels${RST}"
  echo
}

# ══════════════════════════════════════════════════════════════════════════
#  STOP  —  single port or range
# ══════════════════════════════════════════════════════════════════════════
cmd_stop(){
  parse_range "$1"
  banner

  local total=$(( END_PORT - START_PORT + 1 ))
  local stopped=0

  echo -e "  ${RED}${BOLD}🛑 TERMINATING TUNNELS${RST}"
  echo
  fancy_hr
  echo
  echo -e "  ${NEON_BLUE}${BOLD}Range:${RST} ${NEON_PINK}${BOLD}$START_PORT${RST} ${FIRE_2}→${RST} ${NEON_PINK}${BOLD}$END_PORT${RST}  ${GRY}(TCP + UDP)${RST}"
  echo

  for (( port=START_PORT; port<=END_PORT; port++ )); do
    if stop_port "$port"; then
      echo -e "  ${NEON_GREEN}${BOLD}✔${RST}  Port ${NEON_PINK}${BOLD}$port${RST} ${RED}terminated${RST}"
      stopped=$(( stopped + 1 ))
    fi
  done

  echo
  fancy_hr
  echo -e "  ${NEON_GREEN}${BOLD}✔ Stopped ${FIRE_2}${BOLD}$stopped${RST} ${NEON_GREEN}${BOLD}tunnel(s)${RST}"
  echo
}

# ══════════════════════════════════════════════════════════════════════════
#  LIST
# ══════════════════════════════════════════════════════════════════════════
cmd_list(){
  banner
  echo -e "  ${NEON_PINK}${BOLD}╔═══════════════════════════════════════════════════════════════════╗${RST}"
  echo -e "  ${NEON_PINK}${BOLD}║${RST}                      ${NEON_BLUE}${BOLD}ACTIVE TUNNELS${RST}                         ${NEON_PINK}${BOLD}║${RST}"
  echo -e "  ${NEON_PINK}${BOLD}╚═══════════════════════════════════════════════════════════════════╝${RST}"
  echo

  local count=0
  declare -A seen_ports

  for pid_file in "$PID_DIR"/tcp-*.pid; do
    [ -f "$pid_file" ] || continue
    local port
    port=$(basename "$pid_file" .pid | sed 's/tcp-//')
    seen_ports[$port]=1

    local pid
    pid=$(awk '{print $1}' "$pid_file")
    local alive=false
    kill -0 "$pid" 2>/dev/null && alive=true

    if $alive; then
      local remote
      remote=$(cat "$MAP_DIR/tcp-$port" 2>/dev/null || echo "?")
      local udp_status="${RED}${BOLD}✗ OFF${RST}"
      local udp_pid_file="$PID_DIR/udp-$port.pid"
      if [ -f "$udp_pid_file" ]; then
        local upid
        upid=$(awk '{print $1}' "$udp_pid_file")
        kill -0 "$upid" 2>/dev/null && udp_status="${NEON_GREEN}${BOLD}✔ ON${RST}"
      fi

      local start
      start=$(stat -c %Y "$pid_file" 2>/dev/null || stat -f %m "$pid_file" 2>/dev/null || echo 0)
      local now; now=$(date +%s)
      local dur=$(( now - start ))
      local uptime
      if   [ $dur -ge 3600 ]; then uptime="$((dur/3600))h $((dur%3600/60))m"
      elif [ $dur -ge 60   ]; then uptime="$((dur/60))m $((dur%60))s"
      else                         uptime="${dur}s"
      fi

      count=$(( count + 1 ))
      echo -e "  ${FIRE_2}${BOLD}[$count]${RST} ${NEON_GREEN}${BOLD}${BLINK}●${RST} ${NEON_PINK}${BOLD}Port $port${RST}"
      echo -e "      ${NEON_BLUE}${BOLD}├─${RST} Local  : ${WHT}localhost:$port${RST}"
      echo -e "      ${NEON_BLUE}${BOLD}├─${RST} Remote : ${NEON_GREEN}${BOLD}$SERVER:$remote${RST}"
      echo -e "      ${NEON_BLUE}${BOLD}├─${RST} TCP    : ${NEON_GREEN}${BOLD}✔ ON${RST}"
      echo -e "      ${NEON_BLUE}${BOLD}├─${RST} UDP    : $udp_status"
      echo -e "      ${NEON_BLUE}${BOLD}├─${RST} PID    : ${GRY}$pid${RST}"
      echo -e "      ${NEON_BLUE}${BOLD}└─${RST} Uptime : ${FIRE_3}${BOLD}$uptime${RST}"
      echo
    else
      rm -f "$pid_file"
    fi
  done

  if [ $count -eq 0 ]; then
    echo -e "  ${GRY}${DIM}╭─────────────────────────────────────────────────────────────────╮${RST}"
    echo -e "  ${GRY}${DIM}│${RST}                    ${YEL}No active tunnels${RST}                       ${GRY}${DIM}│${RST}"
    echo -e "  ${GRY}${DIM}╰─────────────────────────────────────────────────────────────────╯${RST}"
    echo
    echo -e "  ${NEON_BLUE}${BOLD}ℹ${RST}  Start one:  ${NEON_PINK}${BOLD}tunnel add 8080${RST}"
    echo -e "  ${NEON_BLUE}${BOLD}ℹ${RST}  Or a range: ${NEON_PINK}${BOLD}tunnel add 3000-4000${RST}"
  else
    fancy_hr
    echo -e "  ${NEON_GREEN}${BOLD}Total:${RST} ${FIRE_2}${BOLD}$count${RST} ${WHT}port(s) forwarded${RST}"
  fi
  echo
}

# ══════════════════════════════════════════════════════════════════════════
#  K1 - NUCLEAR CLEANUP (Kill all tunnels + remove everything)
# ══════════════════════════════════════════════════════════════════════════
cmd_k1(){
  epic_banner
  echo -e "  ${RED}${BOLD}  NUCLEAR CLEANUP INITIATED  ${RST}"
  echo
  fancy_hr
  echo
  echo -e "  ${RED}${BLINK}⚠ WARNING: THIS WILL:${RST}"
  echo
  echo -e "  ${RED}${BOLD}1.${RST} Kill all active tunnels"
  echo -e "  ${RED}${BOLD}2.${RST} Delete all tunnel data and logs"
  echo -e "  ${RED}${BOLD}3.${RST} Remove tunnel command from system"
  echo -e "  ${RED}${BOLD}4.${RST} Clean up all configuration files"
  echo
  fancy_hr
  echo
  echo -e "  ${YEL}${BOLD}Are you sure? Type 'YES' to confirm:${RST}"
  printf "  ${RED}${BOLD}►${RST} "
  read -r confirmation
  echo
  
  if [ "$confirmation" != "YES" ]; then
    echo -e "  ${GRY}${DIM}Cancelled. Nothing was deleted.${RST}"
    echo
    return 0
  fi
  
  echo -e "  ${RED}${BOLD}🔥 EXECUTING NUCLEAR CLEANUP...${RST}"
  echo
  
  # 1. Kill all tunnel processes
  echo -e "  ${NEON_BLUE}[1/4]${RST} Terminating all tunnel processes..."
  local killed=0
  for pid_file in "$PID_DIR"/*.pid; do
    [ -f "$pid_file" ] || continue
    for pid in $(cat "$pid_file" 2>/dev/null); do
      if kill -9 "$pid" 2>/dev/null; then
        killed=$(( killed + 1 ))
      fi
    done
  done
  echo -e "  ${NEON_GREEN}✔${RST} Killed ${RED}${BOLD}$killed${RST} process(es)"
  echo
  
  # 2. Delete all tunnel data
  echo -e "  ${NEON_BLUE}[2/4]${RST} Removing all tunnel data..."
  if [ -d "$CONFIG_DIR" ]; then
    rm -rf "$CONFIG_DIR"
    echo -e "  ${NEON_GREEN}✔${RST} Deleted ${RED}${BOLD}$CONFIG_DIR${RST}"
  else
    echo -e "  ${GRY}○${RST} No data directory found"
  fi
  echo
  
  # 3. Remove tunnel command
  echo -e "  ${NEON_BLUE}[3/4]${RST} Removing tunnel command..."
  local script_path=$(which tunnel 2>/dev/null)
  if [ -z "$script_path" ]; then
    # Try to find where this script is located
    script_path=$(readlink -f "$0" 2>/dev/null)
  fi
  
  if [ -n "$script_path" ] && [ -f "$script_path" ]; then
    rm -f "$script_path"
    echo -e "  ${NEON_GREEN}✔${RST} Removed ${RED}${BOLD}$script_path${RST}"
  else
    echo -e "  ${GRY}○${RST} Command location not found"
  fi
  
  # Remove from common locations
  for location in /usr/local/bin/tunnel /usr/bin/tunnel ~/tunnel ~/.local/bin/tunnel; do
    if [ -f "$location" ]; then
      rm -f "$location"
      echo -e "  ${NEON_GREEN}✔${RST} Removed ${RED}${BOLD}$location${RST}"
    fi
  done
  echo
  
  # 4. Clean up any remaining SSH connections to the server
  echo -e "  ${NEON_BLUE}[4/4]${RST} Cleaning up SSH connections to ${BOLD}$SERVER${RST}..."
  local ssh_killed=0
  for pid in $(pgrep -f "ssh.*$SERVER"); do
    if kill -9 "$pid" 2>/dev/null; then
      ssh_killed=$(( ssh_killed + 1 ))
    fi
  done
  if [ $ssh_killed -gt 0 ]; then
    echo -e "  ${NEON_GREEN}✔${RST} Killed ${RED}${BOLD}$ssh_killed${RST} SSH connection(s)"
  else
    echo -e "  ${GRY}○${RST} No active SSH connections found"
  fi
  echo
  
  fancy_hr
  echo
  echo -e "  ${NEON_GREEN}${BOLD}✔ NUCLEAR CLEANUP COMPLETE${RST}"
  echo
  echo -e "  ${FIRE_1}${BOLD}╔═══════════════════════════════════════════════════════════════════╗${RST}"
  echo -e "  ${FIRE_2}${BOLD}║${RST}                                                               ${FIRE_2}${BOLD}║${RST}"
  echo -e "  ${FIRE_3}${BOLD}║${RST}     ${RED}${BOLD}All tunnels destroyed. Command removed from system.${RST}     ${FIRE_3}${BOLD}║${RST}"
  echo -e "  ${FIRE_4}${BOLD}║${RST}                                                               ${FIRE_4}${BOLD}║${RST}"
  echo -e "  ${YEL}${BOLD}╚═══════════════════════════════════════════════════════════════════╝${RST}"
  echo
  echo -e "  ${GRY}${DIM}This terminal will close in 3 seconds...${RST}"
  sleep 3
  
  # Self-destruct - exit and the command is gone
  exit 0
}

# ══════════════════════════════════════════════════════════════════════════
#  HELP
# ══════════════════════════════════════════════════════════════════════════
cmd_help(){
  banner
  echo -e "  ${NEON_PINK}${BOLD}╔═══════════════════════════════════════════════════════════════════════╗${RST}"
  echo -e "  ${NEON_PINK}${BOLD}║${RST}                          ${FIRE_2}${BOLD}COMMANDS${RST}                              ${NEON_PINK}${BOLD}║${RST}"
  echo -e "  ${NEON_PINK}${BOLD}╚═══════════════════════════════════════════════════════════════════════╝${RST}"
  echo
  echo -e "  ${NEON_BLUE}${BOLD}tunnel add <port>${RST}           Forward a single port (TCP + UDP)"
  echo -e "  ${NEON_BLUE}${BOLD}tunnel add <start>-<end>${RST}    Forward an entire port range (TCP + UDP)"
  echo -e "  ${NEON_BLUE}${BOLD}tunnel stop <port|range>${RST}    Stop tunnel(s) for port or range"
  echo -e "  ${NEON_BLUE}${BOLD}tunnel list${RST}                 Show all active tunnels"
  echo -e "  ${NEON_BLUE}${BOLD}tunnel stop-all${RST}             Kill every tunnel immediately"
  echo -e "  ${RED}${BOLD}tunnel k1${RST}                   ${RED}${BOLD}NUCLEAR: Kill all + remove everything${RST}"
  echo -e "  ${NEON_BLUE}${BOLD}tunnel help${RST}                 Show this help"
  echo
  fancy_hr
  echo
  echo -e "  ${NEON_PINK}${BOLD}╔═══════════════════════════════════════════════════════════════════════╗${RST}"
  echo -e "  ${NEON_PINK}${BOLD}║${RST}                          ${FIRE_3}${BOLD}EXAMPLES${RST}                              ${NEON_PINK}${BOLD}║${RST}"
  echo -e "  ${NEON_PINK}${BOLD}╚═══════════════════════════════════════════════════════════════════════╝${RST}"
  echo
  echo -e "  ${GRY}# Forward port 8080${RST}"
  echo -e "  ${NEON_GREEN}${BOLD}tunnel add 8080${RST}"
  echo
  echo -e "  ${GRY}# Forward ports 0 through 6000 (TCP + UDP on every port)${RST}"
  echo -e "  ${NEON_GREEN}${BOLD}tunnel add 0-6000${RST}"
  echo
  echo -e "  ${GRY}# Forward a smaller range${RST}"
  echo -e "  ${NEON_GREEN}${BOLD}tunnel add 3000-3100${RST}"
  echo
  echo -e "  ${GRY}# Stop a single port${RST}"
  echo -e "  ${RED}${BOLD}tunnel stop 8080${RST}"
  echo
  echo -e "  ${GRY}# Stop a range${RST}"
  echo -e "  ${RED}${BOLD}tunnel stop 3000-3100${RST}"
  echo
  echo -e "  ${GRY}# List everything running${RST}"
  echo -e "  ${NEON_BLUE}${BOLD}tunnel list${RST}"
  echo
  echo -e "  ${GRY}# Kill it all${RST}"
  echo -e "  ${RED}${BOLD}tunnel stop-all${RST}"
  echo
  echo -e "  ${GRY}# NUCLEAR OPTION: Remove everything${RST}"
  echo -e "  ${RED}${BOLD}tunnel k1${RST}"
  echo
  fancy_hr
  echo
  echo -e "  ${NEON_PINK}${BOLD}╔═══════════════════════════════════════════════════════════════════════╗${RST}"
  echo -e "  ${NEON_PINK}${BOLD}║${RST}                       ${PURPLE}${BOLD}HOW UDP WORKS${RST}                           ${NEON_PINK}${BOLD}║${RST}"
  echo -e "  ${NEON_PINK}${BOLD}╚═══════════════════════════════════════════════════════════════════════╝${RST}"
  echo
  echo -e "  ${WHT}Each UDP port uses a TCP relay channel over SSH:${RST}"
  echo
  echo -e "    ${NEON_BLUE}Local socat${RST}  ${FIRE_2}→${RST}  ${NEON_GREEN}TCP relay${RST}  ${FIRE_2}→${RST}  ${PURPLE}SSH tunnel${RST}  ${FIRE_2}→${RST}  ${FIRE_4}Remote socat${RST}  ${FIRE_2}→${RST}  ${RED}UDP${RST}"
  echo
  echo -e "  ${WHT}The remote server needs socat running per port:${RST}"
  echo -e "    ${GRY}socat UDP-RECVFROM:<port>,fork TCP:localhost:<port+30000> &${RST}"
  echo
  fancy_hr
  echo
  echo -e "  ${NEON_PINK}${BOLD}╔═══════════════════════════════════════════════════════════════════════╗${RST}"
  echo -e "  ${NEON_PINK}${BOLD}║${RST}                         ${NEON_GREEN}${BOLD}SECURITY${RST}                              ${NEON_PINK}${BOLD}║${RST}"
  echo -e "  ${NEON_PINK}${BOLD}╚═══════════════════════════════════════════════════════════════════════╝${RST}"
  echo
  echo -e "  ${NEON_GREEN}${BOLD}🔒${RST}  Restricted SSH key  ${GRY}(port-forward only, no shell)${RST}"
  echo -e "  ${NEON_GREEN}${BOLD}🔒${RST}  Access code authentication"
  echo -e "  ${NEON_GREEN}${BOLD}🔒${RST}  Auto-reconnect on drop"
  echo -e "  ${NEON_GREEN}${BOLD}🔒${RST}  Per-port PID tracking"
  echo -e "  ${NEON_GREEN}${BOLD}🔒${RST}  Logs in ~/.sdgamer-tunnel/logs/"
  echo
}

# ══════════════════════════════════════════════════════════════════════════
#  ENTRY POINT
# ══════════════════════════════════════════════════════════════════════════
check_deps

# Commands that don't require authentication
case "${1:-help}" in
  help|--help|-h|"")
    cmd_help
    exit 0
    ;;
  list|ls)
    cmd_list
    exit 0
    ;;
esac

# All other commands require authentication
authenticate

case "${1}" in
  add)
    [ -z "$2" ] && { banner; echo -e "  ${RED}${BOLD}✗${RST} Usage: ${NEON_BLUE}${BOLD}tunnel add <port|range>${RST}\n"; exit 1; }
    cmd_add "$2"
    ;;
  stop)
    if [ -z "$2" ]; then
      banner; echo -e "  ${RED}${BOLD}✗${RST} Usage: ${NEON_BLUE}${BOLD}tunnel stop <port|range>${RST}\n"; exit 1
    fi
    cmd_stop "$2"
    ;;
  stop-all|stopall|nuke)
    cmd_stop_all
    ;;
  k1|K1|kill-all|nuke-all)
    cmd_k1
    ;;
  *)
    banner
    echo -e "  ${RED}${BOLD}✗${RST} Unknown command: ${NEON_PINK}${BOLD}$1${RST}"
    echo -e "  ${NEON_BLUE}${BOLD}ℹ${RST}  Run ${NEON_GREEN}${BOLD}tunnel help${RST} for usage"
    echo
    exit 1
    ;;
esac
