#!/bin/bash

source $GPAIR_CONSTANTS_PATH
source $GPAIR_OUTPUTS_PATH
source $GPAIR_UTILS_PATH

echo-print-pair-usage() {
  echo -e "\n $(output::bold::green " USAGE:") gpair pair [options]\n"
  echo -e " Show current pair information.\n"
  echo -e " $(output::bold::green "[OPTIONS]:")\n"
  echo -e "   $(output::help_flag "-h" "--help")        Print usage information\n"
}

invalid_args=()

while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -h|--help)
    echo-print-pair-usage
    exit 0
    ;;
    *)    # unknown option
    invalid_args+=("$1") # save it in an array for later
    shift # past argument
    shift # past value
    ;;
esac
done

handle-invalid-args echo-print-pair-usage $invalid_args


if [ ! -f $GPAIR_CURRENT_PAIR_PATH ]; then
    echo -e "\n  No pair set. \n"
    exit 1
fi

read -r current_pair < $GPAIR_CURRENT_PAIR_PATH

echo -e "\n  $current_pair\n"
