import Foundation


//Lord be mercy. I neither coded nor planned this class. Mine didn't work well, so I begged AI for fixes


class OrderService {
    private var orders = [Order]()

    func makeOrder(user: User, items: [Product]) {
        let newOrder = Order(id: orders.count + 1, user: user, items: items, date: Date(), fulfilled: false)
        orders.append(newOrder)
    }

    func listOrders() -> [Order] {
        return orders
    }

    func loadOrders(from data: String) {
        let lines = data.split(separator: "\n")
        var loadedOrders = [Order]()
        
        for line in lines {
            let components = line.split(separator: ",")
            guard components.count >= 5 else { continue }
            
            // Parse order ID
            guard let id = Int(components[0].trimmingCharacters(in: .whitespaces)) else { continue }
            
            // Parse user name
            let userName = String(components[1].trimmingCharacters(in: .whitespaces))
            let user = User(nickname: userName, password: "", isAdmin: false)
            
            // Parse date
            let dateStr = String(components[2].trimmingCharacters(in: .whitespaces))
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            guard let date = dateFormatter.date(from: dateStr) else { continue }
            
            // Parse fulfilled status
            guard let fulfilled = Bool(components[3].trimmingCharacters(in: .whitespaces)) else { continue }
            
            // Parse items
            let items = components[4].split(separator: ";").compactMap { item -> Product? in
                let itemComponents = item.split(separator: ":")
                guard itemComponents.count == 2,
                      let quantity = Int(itemComponents[1].trimmingCharacters(in: .whitespaces)) else {
                    return nil
                }
                return Product(name: String(itemComponents[0].trimmingCharacters(in: .whitespaces)), quantity: quantity)
            }
            
            let order = Order(id: id, user: user, items: items, date: date, fulfilled: fulfilled)
            loadedOrders.append(order)
        }
        
        orders = loadedOrders
    }

    func saveOrders() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return orders.map { order in
            let itemsStr = order.items.map { "\($0.name):\($0.quantity)" }.joined(separator: ";")
            return "\(order.id),\(order.user.nickname),\(dateFormatter.string(from: order.date)),\(order.fulfilled),\(itemsStr)"
        }.joined(separator: "\n")
    }
}
