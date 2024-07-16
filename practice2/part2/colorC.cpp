#include <iostream>
#include <fstream>
#include <sstream>
#include <vector>
#include <string>

const int WIDTH = 16;
const int HEIGHT = 16;

class Pixel {
public:
    int red, green, blue;

    Pixel(int r = 0, int g = 0, int b = 0) : red(r), green(g), blue(b) {}

    bool isFavoriteColor(const Pixel& favorite) const {
        return red == favorite.red && green == favorite.green && blue == favorite.blue;
    }
};

std::vector<std::string> readFile(const std::string& filename) {
    std::vector<std::string> lines;
    std::ifstream file(filename);
    std::string line;

    while (std::getline(file, line)) {
        lines.push_back(line);
    }

    return lines;
}

void writeFile(const std::string& filename, const std::vector<std::string>& lines) {
    std::ofstream file(filename);

    for (const auto& line : lines) {
        file << line << "\n";
    }
}

std::vector<Pixel> parsePixels(const std::vector<std::string>& lines) {
    std::vector<Pixel> pixels;
    std::stringstream ss;
    int r, g, b;

    for (const auto& line : lines) {
        ss.clear();
        ss.str(line);
        while (ss >> r >> g >> b) {
            pixels.emplace_back(r, g, b);
        }
    }

    return pixels;
}

std::vector<std::string> pixelsToString(const std::vector<Pixel>& pixels) {
    std::vector<std::string> lines;
    std::stringstream ss;

    for (int i = 0; i < HEIGHT; ++i) {
        ss.str("");
        ss.clear();
        for (int j = 0; j < WIDTH; ++j) {
            const Pixel& p = pixels[i * WIDTH + j];
            ss << p.red << "," << p.green << "," << p.blue;
            if (j < WIDTH - 1) ss << " ";
        }
        lines.push_back(ss.str());
    }

    return lines;
}

void processFavoriteColor(std::vector<Pixel>& pixels, const Pixel& favorite) {
    for (int i = 0; i < HEIGHT; ++i) {
        for (int j = 0; j < WIDTH; ++j) {
            int idx = i * WIDTH + j;
            if (pixels[idx].isFavoriteColor(favorite)) {
                if (j > 0) {
                    pixels[idx - 1] = favorite;  // Left pixel
                }
                if (i > 0) {
                    pixels[idx - WIDTH] = favorite;  // Top pixel
                }
            }
        }
    }
}

int main(int argc, char* argv[]) {
    if (argc < 5) {
        std::cerr << "Usage: " << argv[0] << " <input_file> <output_file> <red> <green> <blue>\n";
        return 1;
    }

    std::string inputFile = argv[1];
    std::string outputFile = argv[2];
    int favRed = std::stoi(argv[3]);
    int favGreen = std::stoi(argv[4]);
    int favBlue = std::stoi(argv[5]);

    Pixel favorite(favRed, favGreen, favBlue);

    std::vector<std::string> lines = readFile(inputFile);
    std::vector<Pixel> pixels = parsePixels(lines);
    processFavoriteColor(pixels, favorite);

    std::vector<std::string> outputLines = pixelsToString(pixels);
    writeFile(outputFile, outputLines);

    return 0;
}
