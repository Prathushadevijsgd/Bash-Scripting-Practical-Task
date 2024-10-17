#!/bin/bash

if [[ $# -lt 4 ]]; then
    echo "Usage: $0 -o <operation> -n <num1> <num2> ... [-d]"
    exit 1
fi

operation=""
numbers=()
debug=false

while [[ $# -gt 0 ]]; do
    case "$1" in
        -o)
            operation="$2"
            shift 2
            ;;
        -n)
            shift
            while [[ $# -gt 0 && ! "$1" =~ ^- ]]; do
                numbers+=("$1")
                shift
            done
            ;;
        -d)
            debug=true
            shift
            ;;
        *)
            echo "Invalid option: $1"
            exit 1
            ;;
    esac
done

if [[ -z "$operation" ]] || [[ ${#numbers[@]} -eq 0 ]]; then
    echo "Error: Operation and numbers must be provided."
    exit 1
fi

result=${numbers[0]}
case "$operation" in
    "+")
        for num in "${numbers[@]:1}"; do
            result=$((result + num))
        done
        ;;
    "-")
        for num in "${numbers[@]:1}"; do
            result=$((result - num))
        done
        ;;
    "*")
        for num in "${numbers[@]}"; do
            result=$((result * num))
        done
        ;;
    "%")
        for num in "${numbers[@]:1}"; do
            result=$((result % num))
        done
        ;;
    *)
        echo "Error: Invalid operation."
        exit 1
        ;;
esac

echo "Result: $result"

if $debug; then
    echo "User: $(whoami)"
    echo "Script: $(basename "$0")"
    echo "Operation: $operation"
    echo "Numbers: ${numbers[*]}"
fi
