func processInput(_ input: [String]) -> (Int?, String?) {
    var integers = [Int]()
    
    for str in input {
        if let number = Int(str) {
            integers.append(number)
        } else {
            return (nil, "invalid input")
        }
    }
    
    guard !integers.isEmpty else {
        return ( nil, "invalid numbers")
    }
    
    integers.sort()
    
    let negativeNumbers = integers.filter { $0 < 0 }
    let largestNegative = negativeNumbers.max()
    
    return (largestNegative, nil)
}

// Reading input from the command line
if CommandLine.argc < 2 {
    print("Correct: program <list of integers>")
} else {
    let inputArgs = Array(CommandLine.arguments.dropFirst())
    let result = processInput(inputArgs)
    
    if let errorMessage = result.1 {
        print(errorMessage)
    } else {
        if let largestNegative = result.0 {
            print("largest negative is: \(largestNegative)")
        } else {
            print("no negatives found")
        }
    }
}  
