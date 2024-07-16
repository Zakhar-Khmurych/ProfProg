
#include <iostream>
#include <vector>
#include <string>
#include <algorithm>
#include <cstdio>
#include <filesystem>
//#include <print>

int gCount = 0;
double gBiggestArea = 0;
double gSmallestArea = 1000000;

class Rectangle {
public:
    double Width;
    double Height;
    std::string Name;

    Rectangle(const std::string& n, double w, double h) : Name(n), Width(w), Height(h) {}
};

// Функція для створення вектора об'єктів Rectangle
std::vector<Rectangle> createRectangles(int count) {
    std::vector<Rectangle> rectangles;

    for (int i = 0; i < count; ++i) {
        double width, height;
        std::string name = "Rectangle " + std::to_string(i + 1);
        //std::println("Enter width and height for {}  : ", name());
       	std::cout <<"Enter width and height for " << name << ":" ;
	std::cin >> width >> height;

        rectangles.emplace_back(name, width, height);
    }

    return rectangles;
}
//функція для пошуку прямокутника з максимальною площею. повертає його назву
std::string findRectangleWithMaxArea(const std::vector<Rectangle>& rectangles) {
    if (rectangles.empty()) {
        return "No rectangles provided";
    }

    const Rectangle* maxAreaRect = &rectangles[0];
    double maxArea = rectangles[0].Width * rectangles[0].Height;

    for (const auto& rect : rectangles) {
        double area = rect.Width * rect.Height;
        if (area > maxArea) {
            maxArea = area;
            maxAreaRect = &rect;
        }
    }

    return maxAreaRect->Name;
}
//...і з мінімальною площею
std::string findRectangleWithMinArea(const std::vector<Rectangle>& rectangles) {
    if (rectangles.empty()) {
        return "No rectangles provided";
    }

    const Rectangle* minAreaRect = &rectangles[0];
    double minArea = rectangles[0].Width * rectangles[0].Height;

    for (const auto& rect : rectangles) {
        double area = rect.Width * rect.Height;
        if (area < minArea) {
            minArea = area;
            minAreaRect = &rect;
        }
    }

    return minAreaRect->Name;
}
//поверне назву прямокутника з найбільною стороною
std::string findRectangleWithMaxSide(const std::vector<Rectangle>& rectangles) {
    if (rectangles.empty()) {
        return "No rectangles provided";
    }

    const Rectangle* maxSideRect = &rectangles[0];
    double maxSide = std::max(rectangles[0].Width, rectangles[0].Height);

    for (const auto& rect : rectangles) {
        double maxCurrentSide = std::max(rect.Width, rect.Height);
        if (maxCurrentSide > maxSide) {
            maxSide = maxCurrentSide;
            maxSideRect = &rect;
        }
    }

    return maxSideRect->Name;
}
//...і з мінімальною стороною
std::string findRectangleWithMinSide(const std::vector<Rectangle>& rectangles) {
    if (rectangles.empty()) {
        return "No rectangles provided";
    }

    const Rectangle* minSideRect = &rectangles[0];
    double minSide = std::min(rectangles[0].Width, rectangles[0].Height);

    for (const auto& rect : rectangles) {
        double minCurrentSide = std::min(rect.Width, rect.Height);
        if (minCurrentSide < minSide) {
            minSide = minCurrentSide;
            minSideRect = &rect;
        }
    }

    return minSideRect->Name;
}
//виведе сумарну площу
double calculateTotalArea(const std::vector<Rectangle>& rectangles) {
    double totalArea = 0;

    for (const auto& rect : rectangles) {
        totalArea += rect.Width * rect.Height;
    }

    return totalArea;
}
//виведе їх назви у порядку вкладання, якщо це можливо
std::vector<std::string> sortRectanglesByNestingOrder(std::vector<Rectangle>& rectangles) {
    std::sort(rectangles.begin(), rectangles.end(), [](const Rectangle& a, const Rectangle& b) {
        return (a.Width * a.Height) < (b.Width * b.Height);
    });

    std::vector<std::string> names;
    for (const auto& rect : rectangles) {
        names.push_back(rect.Name);
    }

    return names;
}

int main() {
    int count = 5;
    std::vector<Rectangle> rectangles = createRectangles(count);

    std::cout << "Rectangle with max area: " << findRectangleWithMaxArea(rectangles) << std::endl;
    std::cout << "Rectangle with min area: " << findRectangleWithMinArea(rectangles) << std::endl;
    std::cout << "Rectangle with max side: " << findRectangleWithMaxSide(rectangles) << std::endl;
    std::cout << "Rectangle with min side: " << findRectangleWithMinSide(rectangles) << std::endl;
    std::cout << "Total area of all rectangles: " << calculateTotalArea(rectangles) << std::endl;

    std::vector<std::string> sortedNames = sortRectanglesByNestingOrder(rectangles);
    std::cout << "Rectangles sorted by nesting order (by area):" << std::endl;
    for (const auto& name : sortedNames) {
        std::cout << name << std::endl;
    }

    return 0;
}
