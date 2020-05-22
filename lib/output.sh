#!/usr/bin/env bash

# NOTE: These are helper functions. This file is not meant to be run as a standalone script.
# Also, lib/constants.sh must be sourced in the given script for this to work!

output::bold() {
  echo -e "${BOLD}$1${NORMAL}"
}

output::cyan() {
  echo -e "${CYAN}$1${NORMAL}"
}

output::green() {
  echo -e "${GREEN}$1${NORMAL}"
}

output::purple() {
  echo -e "${PURPLE}$1${NORMAL}"
}

output::red() {
  echo -e "${RED}$1${NORMAL}"
}

output::banner() {
  echo -e "$(output::cyan "
    ╔═╗╦╔╦╗   
    ║ ╦║ ║    
    ╚═╝╩ ╩    
    ╔═╗╔═╗╦╦═╗
    ╠═╝╠═╣║╠╦╝
    ╩  ╩ ╩╩╩╚═
  ")"
}