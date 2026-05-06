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

echo -e "${CYAN}╭──────────────────────────────────────────────╮${RESET}"
echo -e "${CYAN}│${RESET}  ${BOLD}${WHITE} AmitCompressor Installer v1.0${RESET}      ${CYAN}│${RESET}"
echo -e "${CYAN}╰──────────────────────────────────────────────╯${RESET}"

echo ""
echo -e " ${BLUE}➤${RESET} ${BOLD}Preparing Installation...${RESET}"
sleep 1

# Fake Smooth Progress Animation
for i in {1..100}
do
    draw_bar $i
    sleep 0.03
done

echo ""
echo ""

echo -e " ${BLUE}➤${RESET} ${BOLD}Installing Required Packages...${RESET}"

pkg update -y > /dev/null 2>&1
pkg install python ffmpeg -y > /dev/null 2>&1

echo ""
echo -e " ${BLUE}➤${RESET} ${BOLD}Configuring AmitCompressor...${RESET}"

chmod +x amitcomp.py

cp amitcomp.py $PREFIX/bin/amitcomp

chmod +x $PREFIX/bin/amitcomp

echo ""

for i in {1..100}
do
    draw_bar $i
    sleep 0.01
done

echo ""
echo ""

clear

echo -e "${CYAN}╭──────────────────────────────────────────────╮${RESET}"
echo -e "${CYAN}│${RESET}     ${BOLD}${GREEN}✓ INSTALLATION COMPLETE${RESET}         ${CYAN}│${RESET}"
echo -e "${CYAN}╰──────────────────────────────────────────────╯${RESET}"

echo ""
echo -e " ${WHITE}Command:${RESET} ${CYAN}amitcomp${RESET}"
echo ""
echo -e " ${GRAY}Run Anytime Using:${RESET}"
echo -e " ${BLUE}└─>${RESET} amitcomp"
echo ""
