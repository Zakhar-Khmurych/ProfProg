import Foundation

struct Pixel {
    var red: Int
    var green: Int
    var blue: Int

    init(red: Int, green: Int, blue: Int) {
        self.red = red
        self.green = green
        self.blue = blue
    }

    func isFavoriteColor(_ favorite: Pixel) -> Bool {
        return red == favorite.red && green == favorite.green && blue == favorite.blue
    }

    func isUnfavoriteColor(_ unfavorite: Pixel) -> Bool {
        return red == unfavorite.red && green == unfavorite.green && blue == unfavorite.blue
    }
}

func readFile(_ filename: String) -> [String] {
    do {
        let contents = try String(contentsOfFile: filename)
        return contents.components(separatedBy: .newlines).filter { !$0.isEmpty }
    } catch {
        fatalError("Error reading file: \(filename)")
    }
}

func writeFile(_ filename: String, _ lines: [String]) {
    let content = lines.joined(separator: "\n")
    do {
        try content.write(toFile: filename, atomically: true, encoding: .utf8)
    } catch {
        fatalError("Error writing file: \(filename)")
    }
}

func parsePixels(_ lines: [String]) -> [Pixel] {
    var pixels: [Pixel] = []

    for line in lines {
        let components = line.split(separator: " ").map { $0.split(separator: ",") }
        for component in components {
            if component.count == 3,
               let red = Int(component[0]),
               let green = Int(component[1]),
               let blue = Int(component[2]) {
                pixels.append(Pixel(red: red, green: green, blue: blue))
            }
        }
    }

    return pixels
}

func pixelsToString(_ pixels: [Pixel]) -> [String] {
    var lines: [String] = []

    for i in 0..<HEIGHT {
        var line = ""
        for j in 0..<WIDTH {
            let pixel = pixels[i * WIDTH + j]
            line += "\(pixel.red),\(pixel.green),\(pixel.blue)"
            if j < WIDTH - 1 {
                line += " "
            }
        }
        lines.append(line)
    }

    return lines
}

func processFavoriteColor(_ pixels: inout [Pixel], _ favorite: Pixel, _ unfavorite: Pixel?) {
    for i in 0..<HEIGHT {
        for j in 0..<WIDTH {
            let idx = i * WIDTH + j
            if let unfav = unfavorite, pixels[idx].isUnfavoriteColor(unfav) {
                pixels[idx] = favorite
            }
            if pixels[idx].isFavoriteColor(favorite) {
                if j > 0 {
                    pixels[idx - 1] = favorite // Left pixel
                }
                if i > 0 {
                    pixels[idx - WIDTH] = favorite // Top pixel
                }
            }
        }
    }
}

let WIDTH = 16
let HEIGHT = 16

if CommandLine.argc < 6 || CommandLine.argc > 9 {
    print("Usage: \(CommandLine.arguments[0]) <input_file> <output_file> <fav_red> <fav_green> <fav_blue> [<unfav_red> <unfav_green> <unfav_blue>]")
    exit(1)
}

let inputFile = CommandLine.arguments[1]
let outputFile = CommandLine.arguments[2]
let favRed = Int(CommandLine.arguments[3])!
let favGreen = Int(CommandLine.arguments[4])!
let favBlue = Int(CommandLine.arguments[5])!

let favorite = Pixel(red: favRed, green: favGreen, blue: favBlue)

var unfavorite: Pixel? = nil
if CommandLine.argc == 9 {
    let unfavRed = Int(CommandLine.arguments[6])!
    let unfavGreen = Int(CommandLine.arguments[7])!
    let unfavBlue = Int(CommandLine.arguments[8])!
    unfavorite = Pixel(red: unfavRed, green: unfavGreen, blue: unfavBlue)
}

let lines = readFile(inputFile)
if lines.count != HEIGHT {
    print("Error: Invalid input file format. Expected \(HEIGHT) lines.")
    exit(1)
}

var pixels = parsePixels(lines)
if pixels.count != WIDTH * HEIGHT {
    print("Error: Invalid input file format. Expected \(WIDTH * HEIGHT) pixels.")
    exit(1)
}

processFavoriteColor(&pixels, favorite, unfavorite)

let outputLines = pixelsToString(pixels)
writeFile(outputFile, outputLines)
