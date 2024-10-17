#!/bin/bash

fib() {
  local n=$1
  if [ "$n" -eq 0 ]; then
    echo 0
  elif [ "$n" -eq 1 ]; then
    echo 1
  else
    local prev1=$(fib $((n - 1)))
    local prev2=$(fib $((n - 2)))
    echo $((prev1 + prev2))
  fi
}

echo "Enter number of terms: "
read NUM

echo "FIBONACCI SERIES:"
for ((i=0; i<NUM; i++)); do
result=$(fib $i) # Call the fib function
  echo "$result"  # Print the result
done
