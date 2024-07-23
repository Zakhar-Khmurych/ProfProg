import Foundation

class User {
    var nickname: String
    var password: String
    var isAdmin: Bool
    
    init(nickname: String, password: String, isAdmin: Bool) {
        self.nickname = nickname
        self.password = password
        self.isAdmin = isAdmin
    }
}
