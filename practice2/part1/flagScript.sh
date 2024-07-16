#!/bin/bash

if [ "$#" -lt 2 ]; then
    echo "Usage: $0 source_file -o output_binary"
    exit 1
fi

clang++ -Wall -Wextra -Wpedantic -Werror -std=c++20 "$@"

