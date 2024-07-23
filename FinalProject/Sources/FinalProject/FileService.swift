import Foundation

class FileService {
    private let usersFileName: String = "users.txt"
    private let productsFileName: String = "products.txt"
    private let ordersFileName: String = "orders.txt"
    
    func saveData(data: String, to fileName: String) {
        let filePath = getCurrentDirectory().appending("/\(fileName)")
        do {
            try data.write(toFile: filePath, atomically: true, encoding: .utf8)
        } catch {
            print("Failed to save data to \(fileName): \(error)")
        }
    }
    
    func loadData(from fileName: String) -> String? {
        let filePath = getCurrentDirectory().appending("/\(fileName)")
        guard FileManager.default.fileExists(atPath: filePath) else {
            print("File \(fileName) does not exist")
            return nil
        }
        do {
            let data = try String(contentsOfFile: filePath, encoding: .utf8)
            return data
        } catch {
            print("Failed to load data from \(fileName): \(error)")
            return nil
        }
    }
    
    private func getCurrentDirectory() -> String {
        return FileManager.default.currentDirectoryPath
    }
    
    func saveUsers(data: String) {
        saveData(data: data, to: usersFileName)
    }
    
    func loadUsers() -> String? {
        return loadData(from: usersFileName)
    }
    
    func saveProducts(data: String) {
        saveData(data: data, to: productsFileName)
    }
    
    func loadProducts() -> String? {
        return loadData(from: productsFileName)
    }
    
    func saveOrders(data: String) {
        saveData(data: data, to: ordersFileName)
    }
    
    func loadOrders() -> String? {
        return loadData(from: ordersFileName)
    }
}
