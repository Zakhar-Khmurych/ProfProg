import Foundation

class ConsoleHandler {
    private var userService = UserService()
    private var inventoryService = InventoryService()
    private var orderService = OrderService()
    private var fileService = FileService()

    init() {
        if let userData = fileService.loadUsers() {
            userService.loadUsers(from: userData)
        }

        if let productData = fileService.loadProducts() {
            inventoryService.loadProducts(from: productData)
        }

        if let orderData = fileService.loadOrders() {
            orderService.loadOrders(from: orderData)
        }
    }

    func start() {
        while true {
            print("Enter command (register, login, addProduct, removeProduct, listProducts, makeOrder, listOrders, exit):")
            if let command = readLine() {
                switch command {
                case "register":
                    handleRegister()
                case "login":
                    handleLogin()
                case "addProduct":
                    handleAddProduct()
                case "removeProduct":
                    handleRemoveProduct()
                case "listProducts":
                    handleListProducts()
                case "makeOrder":
                    handleMakeOrder()
                case "listOrders":
                    handleListOrders()
                case "exit":
                    saveAllData()
                    return
                default:
                    print("Unknown command")
                }
            }
        }
    }

    private func handleRegister() {
        print("Enter nickname:")
        guard let nickname = readLine() else { return }

        print("Enter password:")
        guard let password = readLine() else { return }

        print("Enter role (true for admin, false for regular user):")
        guard let roleInput = readLine(), let isAdmin = Bool(roleInput) else { return }

        if userService.register(nickname: nickname, password: password, isAdmin: isAdmin) {
            print("Registration successful")
        } else {
            print("Registration failed")
        }
    }

    private func handleLogin() {
        print("Enter nickname:")
        guard let nickname = readLine() else { return }

        print("Enter password:")
        guard let password = readLine() else { return }

        if userService.login(nickname: nickname, password: password) {
            print("Login successful")
        } else {
            print("Login failed")
        }
    }

    private func handleAddProduct() {
        print("Enter product name:")
        guard let name = readLine() else { return }

        print("Enter quantity:")
        guard let quantityStr = readLine(), let quantity = Int(quantityStr) else { return }

        inventoryService.addProduct(name: name, quantity: quantity)
        print("Product added")
    }

    private func handleRemoveProduct() {
        print("Enter product name:")
        guard let name = readLine() else { return }

        print("Enter quantity:")
        guard let quantityStr = readLine(), let quantity = Int(quantityStr) else { return }

        inventoryService.removeProduct(name: name, quantity: quantity)
        print("Product removed")
    }

    private func handleListProducts() {
        let products = inventoryService.listProducts()
        for product in products {
            print("Product: \(product.name), Quantity: \(product.quantity)")
        }
    }

    private func handleMakeOrder() {
        print("Enter your nickname:")
        guard let nickname = readLine() else { return }

        guard let user = userService.getUser(nickname: nickname) else {
            print("User not found")
            return
        }

        var items = [Product]()
        while true {
            print("Enter product name (or 'done' to finish):")
            guard let productName = readLine() else { return }
            if productName == "done" {
                break
            }

            print("Enter quantity:")
            guard let quantityStr = readLine(), let quantity = Int(quantityStr) else { return }

            if let product = inventoryService.getProduct(name: productName) {
                items.append(Product(name: product.name, quantity: quantity))
            } else {
                print("Product not found")
            }
        }

        orderService.makeOrder(user: user, items: items)
        print("Order made")
    }

    private func handleListOrders() {
        let orders = orderService.listOrders()
        for order in orders {
            print("Order ID: \(order.id), User: \(order.user.nickname), Date: \(order.date), Fulfilled: \(order.fulfilled)")
            for item in order.items {
                print("  Product: \(item.name), Quantity: \(item.quantity)")
            }
        }
    }

    private func saveAllData() {
        let userData = userService.saveUsers()
        fileService.saveUsers(data: userData)

        let productData = inventoryService.saveProducts()
        fileService.saveProducts(data: productData)

        let orderData = orderService.saveOrders()
        fileService.saveOrders(data: orderData)
    }
}
