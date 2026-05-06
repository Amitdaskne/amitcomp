#!/data/data/com.termux/files/usr/bin/bash

CYAN='\033[36m'
WHITE='\033[97m'
BOLD='\033[1m'
RESET='\033[0m'
GRAY='\033[90m'
BLUE='\033[34m'
GREEN='\033[32m'

clear

draw_bar() {
    percent=$1
    filled=$((percent / 5))

    bar=""

    for ((i=0; i<filled; i++)); do
        bar="${bar}█"
    done

    for ((i=filled; i<20; i++)); do
        bar="${bar}▒"
    done

    echo -ne "\r ${CYAN}│${RESET} ${BLUE}${bar}${RESET} ${WHITE}${percent}%${RESET}"
}

header() {
    echo -e "${CYAN}╭──────────────────────────────────────────────╮${RESET}"
    echo -e "${CYAN}│${RESET}  ${BOLD}${WHITE} AmitCompressor Installer v1.0${RESET}      ${CYAN}│${RESET}"
    echo -e "${CYAN}╰──────────────────────────────────────────────╯${RESET}"
}

header

echo ""
echo -e " ${BLUE}➤${RESET} ${BOLD}Preparing Installation...${RESET}"

for i in {1..100}
do
    draw_bar $i
    sleep 0.02
done

echo ""
echo ""

# UPDATE PACKAGES
echo -e " ${BLUE}➤${RESET} ${BOLD}Updating Packages...${RESET}"

pkg update -y > /dev/null 2>&1 &
PID=$!

progress=0

while kill -0 $PID 2>/dev/null
do
    if [ $progress -lt 95 ]; then
        progress=$((progress + 1))
    fi

    draw_bar $progress
    sleep 0.2
done

wait $PID

draw_bar 100

echo ""
echo ""

# INSTALL DEPENDENCIES
echo -e " ${BLUE}➤${RESET} ${BOLD}Installing Required Packages...${RESET}"

pkg install python ffmpeg -y > /dev/null 2>&1 &
PID=$!

progress=0

while kill -0 $PID 2>/dev/null
do
    if [ $progress -lt 95 ]; then
        progress=$((progress + 1))
    fi

    draw_bar $progress
    sleep 0.2
done

wait $PID

draw_bar 100

echo ""
echo ""

# CONFIGURE
echo -e " ${BLUE}➤${RESET} ${BOLD}Configuring AmitCompressor...${RESET}"

for i in {1..100}
do
    draw_bar $i
    sleep 0.01
done

chmod +x amitcomp.py

cp amitcomp.py $PREFIX/bin/amitcomp

chmod +x $PREFIX/bin/amitcomp

echo ""
echo ""

clear

header

echo ""
echo -e " ${WHITE}${BOLD}✓ INSTALLATION COMPLETED SUCCESSFULLY${RESET}"
echo ""

echo -e " ${WHITE}Command:${RESET} ${CYAN}amitcomp${RESET}"

echo ""
echo -e " ${GRAY}Run Anytime Using:${RESET}"
echo -e " ${BLUE}└─>${RESET} amitcomp"
echo ""
