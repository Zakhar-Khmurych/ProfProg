import XCTest
@testable import FinalProject

final class UserServiceTests: XCTestCase {
    var userService: UserService!

    override func setUp() {
        super.setUp()
        userService = UserService()
    }

    override func tearDown() {
        userService = nil
        super.tearDown()
    }

    func testRegisterNewUser() {
        let result = userService.register(nickname: "john_doe", password: "password123", isAdmin: false)
        XCTAssertTrue(result, "User should be registered successfully")
    }

    func testRegisterExistingUser() {
        _ = userService.register(nickname: "john_doe", password: "password123", isAdmin: false)
        let result = userService.register(nickname: "john_doe", password: "newpassword", isAdmin: false)
        XCTAssertFalse(result, "User with the same nickname should not be registered again")
    }

    func testLoginSuccessful() {
        _ = userService.register(nickname: "john_doe", password: "password123", isAdmin: false)
        let result = userService.login(nickname: "john_doe", password: "password123")
        XCTAssertTrue(result, "Login should be successful with correct credentials")
    }

    func testLoginUnsuccessful() {
        _ = userService.register(nickname: "john_doe", password: "password123", isAdmin: false)
        let result = userService.login(nickname: "john_doe", password: "wrongpassword")
        XCTAssertFalse(result, "Login should fail with incorrect credentials")
    }

    func testGetUser() {
        _ = userService.register(nickname: "john_doe", password: "password123", isAdmin: false)
        let user = userService.getUser(nickname: "john_doe")
        XCTAssertNotNil(user, "User should be retrieved successfully")
        XCTAssertEqual(user?.nickname, "john_doe", "Nickname should match")
    }

    func testSaveUsers() {
        _ = userService.register(nickname: "john_doe", password: "password123", isAdmin: false)
        let savedData = userService.saveUsers()
        XCTAssertTrue(savedData.contains("john_doe,password123,false"), "Saved data should contain the registered user information")
    }

    func testLoadUsers() {
        let data = "john_doe,password123,false\njane_doe,password456,true"
        userService.loadUsers(from: data)
        
        let john = userService.getUser(nickname: "john_doe")
        XCTAssertNotNil(john, "John Doe should be loaded")
        XCTAssertEqual(john?.nickname, "john_doe", "Nickname should match")
        XCTAssertFalse(john!.isAdmin, "John Doe should not be an admin")

        let jane = userService.getUser(nickname: "jane_doe")
        XCTAssertNotNil(jane, "Jane Doe should be loaded")
        XCTAssertTrue(jane!.isAdmin, "Jane Doe should be an admin")
    }
}
