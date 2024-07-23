import Foundation

class InventoryService {
    private var products: [Product] = []

    func addProduct(name: String, quantity: Int) {
        if let index = products.firstIndex(where: { $0.name == name }) {
            products[index].quantity += quantity
        } else {
            let newProduct = Product(name: name, quantity: quantity)
            products.append(newProduct)
        }
    }

    func removeProduct(name: String, quantity: Int) {
        if let index = products.firstIndex(where: { $0.name == name }) {
            if products[index].quantity > quantity {
                products[index].quantity -= quantity
            } else {
                products.remove(at: index)
            }
        }
    }

    func listProducts() -> [Product] {
        return products
    }

    func getProduct(name: String) -> Product? {
        return products.first { $0.name == name }
    }

    func loadProducts(from data: String) {
        products = data.split(separator: "\n").compactMap { line in
            let components = line.split(separator: ",")
            guard components.count == 2,
                  let quantity = Int(components[1].trimmingCharacters(in: .whitespaces)) else {
                return nil
            }
            return Product(name: String(components[0].trimmingCharacters(in: .whitespaces)), quantity: quantity)
        }
    }

    func saveProducts() -> String {
        return products.map { "\($0.name), \($0.quantity)" }.joined(separator: "\n")
    }
}
