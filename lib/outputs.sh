#!/usr/bin/env bash

# NOTE: These are helper functions. This file is not meant to be run as a standalone script.
# Also, lib/constants.sh must be sourced in the given script for this to work!

output::bold() {
  echo -e "${BOLD}$1${NORMAL}"
}

output::bold::cyan() {
  echo -e "${BOLD_CYAN}$1${NORMAL}"
}

output::bold::green() {
  echo -e "${BOLD_GREEN}$1${NORMAL}"
}

output::bold::purple() {
  echo -e "${BOLD_PURPLE}$1${NORMAL}"
}

output::bold::red() {
  echo -e "${BOLD_RED}$1${NORMAL}"
}

output::bold::lightgray() {
  echo -e "${BOLD_LIGHT_GRAY}$1${NORMAL}"
}
output::bold::darkgray() {
  echo -e "${BOLD_DARK_GRAY}$1${NORMAL}"
}

output::bold::yellow() {
  echo -e "${BOLD_YELLOW}$1${NORMAL}"
}

output::bold::white() {
  echo -e "${BOLD_WHITE}$1${NORMAL}"
}

output::bold::orange() {
  echo -e "${BOLD_ORANGE}$1${NORMAL}"
}


output::cyan() {
  echo -e "${CYAN}$1${NORMAL}"
}

output::blue() {
  echo -e "${BLUE}$1${NORMAL}"
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

output::lightgray() {
  echo -e "${LIGHT_GRAY}$1${NORMAL}"
}
output::darkgray() {
  echo -e "${DARK_GRAY}$1${NORMAL}"
}

output::yellow() {
  echo -e "${YELLOW}$1${NORMAL}"
}

output::white() {
  echo -e "${WHITE}$1${NORMAL}"
}

output::orange() {
  echo -e "${ORANGE}$1${NORMAL}"
}

output::help_flag() {
  short_flag_name="$1"
  long_flag_name="$2"
  echo -e "$(output::bold::yellow $short_flag_name) $(output::bold::white "|") $(output::bold::yellow $long_flag_name)"
}

output::required() {
  echo -e "$(output::bold::red "(required)")"
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
