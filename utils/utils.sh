handle-invalid-args() {
  echo_usage=$1
  invalid_args=(${@:2})

  invalid_args_length=${#invalid_args[@]}

  if [ $invalid_args_length != "0" ]; then
    echo -e "\n$(output::bold::red " Error processing the following arguments: \n")"
    for (( i=0; i<$invalid_args_length; i++ )); do echo -e "    ${invalid_args[$i]} is not a valid argument." ; done
    echo -e "\n$(output::bold " -----------------------------------------")"
    ($echo_usage)
    exit 1
  fi
}

handle-missing-arg() {
  error_message=$1
  echo_usage=$2
  arg_value=$3

  if [ -z "$arg_value" ]
  then
    echo -e "\n$(output::bold::red " $error_message \n")"
    ($echo_usage)
    exit 1
  fi
}
