#!/data/data/com.termux/files/usr/bin/bash

CYAN='\033[36m'
WHITE='\033[97m'
BOLD='\033[1m'
RESET='\033[0m'
GRAY='\033[90m'
BLUE='\033[34m'

clear

echo -e "${CYAN}╭──────────────────────────────────────────────╮${RESET}"
echo -e "${CYAN}│${RESET}  ${BOLD}${WHITE} AmitCompressor VYO v1.0 Installer${RESET}      ${CYAN}│${RESET}"
echo -e "${CYAN}╰──────────────────────────────────────────────╯${RESET}"

sleep 1

echo ""
echo -e " ${BLUE}➤${RESET} ${BOLD}Updating Packages...${RESET}"
pkg update -y > /dev/null 2>&1

echo -e " ${BLUE}➤${RESET} ${BOLD}Installing Dependencies...${RESET}"
pkg install python ffmpeg -y > /dev/null 2>&1

echo -e " ${BLUE}➤${RESET} ${BOLD}Setting Permissions...${RESET}"
chmod +x amitcomp.py

echo -e " ${BLUE}➤${RESET} ${BOLD}Installing Command...${RESET}"
cp amitcomp.py $PREFIX/bin/amitcomp

chmod +x $PREFIX/bin/amitcomp

sleep 1

clear

echo -e "${CYAN}╭──────────────────────────────────────────────╮${RESET}"
echo -e "${CYAN}│${RESET}     ${BOLD}${WHITE}✓ INSTALLATION COMPLETE${RESET}         ${CYAN}│${RESET}"
echo -e "${CYAN}╰──────────────────────────────────────────────╯${RESET}"

echo ""
echo -e " ${WHITE}Command:${RESET} ${CYAN}amitcomp${RESET}"
echo ""
echo -e " ${GRAY}Run anytime using:${RESET}"
echo -e " ${BLUE}└─>${RESET} amitcomp"
echo ""
