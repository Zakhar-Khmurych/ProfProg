import Foundation

class UserService {
    private(set) var users = [User]()
    
    func register(nickname: String, password: String, isAdmin: Bool) -> Bool {
        if users.contains(where: { $0.nickname == nickname }) {
            return false // User already exists
        }
        users.append(User(nickname: nickname, password: password, isAdmin: isAdmin))
        return true
    }
    
    func login(nickname: String, password: String) -> Bool {
        return users.contains(where: { $0.nickname == nickname && $0.password == password })
    }
    
    func getUser(nickname: String) -> User? {
        return users.first(where: { $0.nickname == nickname })
    }
    
    func saveUsers() -> String {
        let userStrings = users.map { "\($0.nickname),\($0.password),\($0.isAdmin)" }
        return userStrings.joined(separator: "\n")
    }
    
    func loadUsers(from data: String) {
        let lines = data.split(separator: "\n")
        users = lines.map { line in
            let components = line.split(separator: ",")
            let nickname = String(components[0])
            let password = String(components[1])
            let isAdmin = Bool(String(components[2])) ?? false
            return User(nickname: nickname, password: password, isAdmin: isAdmin)
        }
    }
}
