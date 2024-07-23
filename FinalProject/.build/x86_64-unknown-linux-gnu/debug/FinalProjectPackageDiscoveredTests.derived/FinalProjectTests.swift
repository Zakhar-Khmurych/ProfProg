import XCTest
@testable import FinalProjectTests

fileprivate extension InventoryServiceTests {
    @available(*, deprecated, message: "Not actually deprecated. Marked as deprecated to allow inclusion of deprecated tests (which test deprecated functionality) without warnings")
    static let __allTests__InventoryServiceTests = [
        ("testAddProductExisting", testAddProductExisting),
        ("testAddProductNew", testAddProductNew),
        ("testListProducts", testListProducts),
        ("testLoadProducts", testLoadProducts),
        ("testRemoveProduct", testRemoveProduct),
        ("testRemoveProductCompletely", testRemoveProductCompletely),
        ("testSaveProducts", testSaveProducts)
    ]
}

fileprivate extension UserServiceTests {
    @available(*, deprecated, message: "Not actually deprecated. Marked as deprecated to allow inclusion of deprecated tests (which test deprecated functionality) without warnings")
    static let __allTests__UserServiceTests = [
        ("testGetUser", testGetUser),
        ("testLoadUsers", testLoadUsers),
        ("testLoginSuccessful", testLoginSuccessful),
        ("testLoginUnsuccessful", testLoginUnsuccessful),
        ("testRegisterExistingUser", testRegisterExistingUser),
        ("testRegisterNewUser", testRegisterNewUser),
        ("testSaveUsers", testSaveUsers)
    ]
}
@available(*, deprecated, message: "Not actually deprecated. Marked as deprecated to allow inclusion of deprecated tests (which test deprecated functionality) without warnings")
func __FinalProjectTests__allTests() -> [XCTestCaseEntry] {
    return [
        testCase(InventoryServiceTests.__allTests__InventoryServiceTests),
        testCase(UserServiceTests.__allTests__UserServiceTests)
    ]
}