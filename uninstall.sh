#!/data/data/com.termux/files/usr/bin/bash

CYAN='\033[36m'
WHITE='\033[97m'
BOLD='\033[1m'
RESET='\033[0m'

clear

echo -e "${CYAN}╭────────────────────────────────────╮${RESET}"
echo -e "${CYAN}│${RESET} ${BOLD}${WHITE}Removing AmitCompressor...${RESET}     ${CYAN}│${RESET}"
echo -e "${CYAN}╰────────────────────────────────────╯${RESET}"

rm -f $PREFIX/bin/amitcomp

echo ""
echo -e "${WHITE}✓ Successfully Removed.${RESET}"
echo ""
