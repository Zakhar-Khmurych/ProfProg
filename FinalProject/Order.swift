import Foundation

class Order {
    var id: Int
    var user: User
    var items: [Product]
    var date: Date
    var fulfilled: Bool
    
    init(id: Int, user: User, items: [Product], date: Date, fulfilled: Bool = false) {
        self.id = id
        self.user = user
        self.items = items
        self.date = date
        self.fulfilled = fulfilled
    }
}
