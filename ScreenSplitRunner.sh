#!/bin/bash

# Check for an active screen session
if [ -z "$STY" ]; then
  echo "This script must be run inside a screen session."
  exit 1
fi

# Initialize arrays for storing actions and commands
splits_and_moves=()
commands=()

# Function for processing arguments
parse_arguments() {
  for arg in "$@"; do
    if ! [[ $arg == v* || $arg == h* || $arg == m* ]]; then
      commands+=("$arg")
    else
      splits_and_moves+=("$arg")
    fi
  done
}

perform_splits_and_moves() {
  local move_zero=0

  for action in "${splits_and_moves[@]}"; do
    case "${action:0:1}" in
      v) ((vertical_splits+=${action:1}));;
      h) ((horizontal_splits+=${action:1}));;
    esac
  done

  # Perform splits
  for action in "${splits_and_moves[@]}"; do
    local type=${action:0:1}
    local count=${action:1}

    for ((i = 0; i < count; i++)); do
      case $type in
        v)
          screen -X split -v
          ((move_zero+=1))
          sleep 0.2
          ;;
        h)
          screen -X split
          ((move_zero+=1))
          sleep 0.2
          ;;
        m)
          screen -X focus
          ((move_zero-=1))
          sleep 0.2
          ;;
      esac
    done
  done
  ((move_zero+=1))

  # Return focus to the first pane
  for ((i = 0; i < move_zero; i++)); do
    screen -X focus
    sleep 0.2
  done

  local total_windows=$((vertical_splits + horizontal_splits + 1))
  for ((i = 1; i < total_windows; i++)); do
    screen -X screen
    sleep 0.2
  done
  screen -X select 0

  # Assign each pane to its own window
  for ((i = 0; i < total_windows; i++)); do
    screen -X select $i
    screen -X focus
    sleep 0.5
  done
}

execute_commands() {
  local total_commands=${#commands[@]}
  local current_window=0

  for ((i = 0; i < total_commands; i++)); do
    local command=${commands[i]}

    screen -X select $current_window
    sleep 0.2

    screen -X stuff "$command^M"
    sleep 0.2

    ((current_window++))
  done
  screen -X select 0
}

parse_arguments "$@"
perform_splits_and_moves
execute_commands
echo "All actions have been completed."
