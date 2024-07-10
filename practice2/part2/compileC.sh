#!/bin/bash

# Скрипт для компіляції C++ коду з використанням корисних флагів

# Перевірка, чи були передані аргументи
if [ "$#" -lt 3 ]; then
    echo "Usage: $0 <source_file> -o <output_binary>"
    exit 1
fi

# Компіляція з використанням clang++-18 і прапорців
clang++-18 -Wall -Wextra -Wpedantic -Werror -std=c++23 "$@"
