#include <ranges>
#include <print>
#include <algorithm>
#include <iostream>

int main()
{
    std::println("Enter the list of numbers separated by comma:");
    std::string inputString; //читабельні імена це тут
    std::getline(std::cin, inputString);
//розділення блоків пробілами
    constexpr std::string_view delimiter(","); //теж читабельно, але не так красиво
    auto filteredValues = std::views::split(inputString, delimiter)
        | std::ranges::to<std::vector<std::string>>() //роздільник великого фрагменту коду?
        | std::views::filter([](const auto& str) { try { return std::stod(str) < 0; } catch (const std::exception& e) { return false; } }) //лямбда-функція?
        | std::ranges::views::transform([](const auto& str) { return std::stod(str); })
        | std::ranges::to<std::vector>();

    if (filteredValues.empty()) {//перевірка для трансформації значень
        std::println("No negative values in the list or incorrect input format");
    }
    else {
        std::println("Result is {}", std::ranges::max(filteredValues)); //вивід результату
    }
}
