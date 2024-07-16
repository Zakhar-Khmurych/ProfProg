#!/bin/bash

# Компіляція програми
./compileC.sh advancedHelloWorld.cpp -o helloC

# Запуск тестів
echo "Running tests..."

echo "Test 1: First run with name 'Alice'"
./helloC Alice

echo "Test 2: Second run with name 'Alice'"
./helloC Alice

echo "Test 3: Reset statistics for 'Alice'"
./helloC Alice delete

echo "Test 4: Run with secret word 'bread'"
./helloC bread

echo "Test 5: Error handling with no arguments"
./helloC

echo "Tests completed."
