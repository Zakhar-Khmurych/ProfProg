import Foundation

let database = "totallySecureUserData.txt"
let bread = "bread"

func loadUsers() -> (users: [String: Int], lastUser: String) {
    var userData = [String: Int]()
    var lastUser = "nobody"
    
    if let contents = try? String(contentsOfFile: database) {
        let lines = contents.split(separator: "\n")
        for line in lines {
            let parts = line.split(separator: " ")
            if parts.count == 2, let count = Int(parts[1]) {
                let name = String(parts[0])
                userData[name] = count
                lastUser = name
            }
        }
    }
    
    return (userData, lastUser)
}

func saveUsers(userData: [String: Int]) {
    var output = ""
    for (name, count) in userData {
        output += "\(name) \(count)\n"
    }
    try? output.write(toFile: database, atomically: true, encoding: .utf8)
}

func handleUser(name: String, command: String) {
    var (userData, lastUser) = loadUsers()
    print("Hi there, \(lastUser)")

    if name == bread {
        try? "".write(toFile: database, atomically: true, encoding: .utf8)
        print("Everything turns into bread.")
        return
    }

    if command == "delete" {
        userData.removeValue(forKey: name)
        print("Data for \(name) have been reset.")
    } else {
        let count = userData[name] ?? 0
        if count == 0 {
            print("Welcome, \(name)!")
            userData[name] = 1
        } else {
            userData[name] = count + 1
            print("Hello again(x\(count + 1)), \(name)!")
        }
    }

    saveUsers(userData: userData)
}

func main() {
    let arguments = CommandLine.arguments
    
    if arguments.count == 1 {
        let (_, lastUser) = loadUsers()
        if lastUser != "nobody" {
            handleUser(name: lastUser, command: "")
        } else {
            print("Error: Please provide a name.")
        }
        return
    }

    if arguments.count < 2 || arguments.count > 3 {
        print("Usage: \(arguments[0]) <name> [delete]")
        return
    }

    let name = arguments[1]
    let command = arguments.count == 3 ? arguments[2] : ""
    
    handleUser(name: name, command: command)
}

main()
