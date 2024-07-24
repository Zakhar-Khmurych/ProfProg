import XCTest
@testable import FinalProject

final class InventoryServiceTests: XCTestCase {
    var inventoryService: InventoryService!

    override func setUp() {
        super.setUp()
        inventoryService = InventoryService()
    }

    override func tearDown() {
        inventoryService = nil
        super.tearDown()
    }

    func testAddProductNew() {
        inventoryService.addProduct(name: "Bread", quantity: 10)
        let product = inventoryService.getProduct(name: "Bread")
        XCTAssertNotNil(product, "Product should be added")
        XCTAssertEqual(product?.quantity, 10, "Product quantity should match")
    }

    func testAddProductExisting() {
        inventoryService.addProduct(name: "Bread", quantity: 10)
        inventoryService.addProduct(name: "Bread", quantity: 5)
        let product = inventoryService.getProduct(name: "Bread")
        XCTAssertNotNil(product, "Product should be found")
        XCTAssertEqual(product?.quantity, 15, "Product quantity should be updated")
    }

    func testRemoveProduct() {
        inventoryService.addProduct(name: "Bread", quantity: 10)
        inventoryService.removeProduct(name: "Bread", quantity: 5)
        let product = inventoryService.getProduct(name: "Bread")
        XCTAssertNotNil(product, "Product should be found")
        XCTAssertEqual(product?.quantity, 5, "Product quantity should be updated")
    }

    func testRemoveProductCompletely() {
        inventoryService.addProduct(name: "Bread", quantity: 10)
        inventoryService.removeProduct(name: "Bread", quantity: 10)
        let product = inventoryService.getProduct(name: "Bread")
        XCTAssertNil(product, "Product should be removed")
    }

    func testListProducts() {
        inventoryService.addProduct(name: "Bread", quantity: 10)
        inventoryService.addProduct(name: "Banana", quantity: 5)
        let products = inventoryService.listProducts()
        XCTAssertEqual(products.count, 2, "There should be 2 products")
        XCTAssertTrue(products.contains { $0.name == "Bread" && $0.quantity == 10 }, "Bread should be in the list with correct quantity")
        XCTAssertTrue(products.contains { $0.name == "Banana" && $0.quantity == 5 }, "Banana should be in the list with correct quantity")
    }

    func testLoadProducts() {
        let data = "Bread, 10\nBanana, 5"
        inventoryService.loadProducts(from: data)
        let Bread = inventoryService.getProduct(name: "Bread")
        let banana = inventoryService.getProduct(name: "Banana")
        XCTAssertNotNil(Bread, "Bread should be loaded")
        XCTAssertEqual(Bread?.quantity, 10, "Bread quantity should match")
        XCTAssertNotNil(banana, "Banana should be loaded")
        XCTAssertEqual(banana?.quantity, 5, "Banana quantity should match")
    }

    func testSaveProducts() {
        inventoryService.addProduct(name: "Bread", quantity: 10)
        inventoryService.addProduct(name: "Banana", quantity: 5)
        let savedData = inventoryService.saveProducts()
        let expectedData = "Bread, 10\nBanana, 5"
        XCTAssertEqual(savedData, expectedData, "Saved data should match expected format")
    }
}
