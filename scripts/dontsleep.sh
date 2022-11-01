#!/bin/bash
DEFAULT_DELAY=1
DEFAULT_DISTANCE=100

DELAY=${1:-$DEFAULT_DELAY}
DISTANCE=${2:-$DEFAULT_DISTANCE}

echo -
echo - Keeping computer awake...
echo - Delay: ${DELAY}
echo - Distance: ${DISTANCE}
echo -
echo - Press CTRL+C to stop
echo -

function move_cycle {
  for iteratin in {1..4}
  do
    echo -en "  → → → → \r"
    xdotool mousemove_relative ${DISTANCE} 0
    sleep ${DELAY}
    echo -en "  ↓ ↓ ↓ ↓ \r"
    xdotool mousemove_relative 0 ${DISTANCE}
    sleep ${DELAY}
    echo -en "  ← ← ← ← \r"
    xdotool mousemove_relative -- -${DISTANCE} 0
    sleep ${DELAY}
    echo -en "  ↑ ↑ ↑ ↑ \r"
    xdotool mousemove_relative -- 0 -${DISTANCE}
    sleep ${DELAY}
  done
}

while true
do
  move_cycle
done
