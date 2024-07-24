import Foundation

// Test for UserService
func testUserService() {
    let userService = UserService()
    
    // Test user registration
    assert(userService.register(nickname: "testuser", password: "password", isAdmin: false) == true, "User registration failed")
    assert(userService.register(nickname: "testuser", password: "password", isAdmin: false) == false, "Duplicate user registration failed to detect")
    
    // Test user login
    assert(userService.login(nickname: "testuser", password: "password") == true, "User login failed")
    assert(userService.login(nickname: "testuser", password: "wrongpassword") == false, "User login with wrong password failed to detect")
    
    // Test getUser
    if let user = userService.getUser(nickname: "testuser") {
        assert(user.nickname == "testuser", "Get user nickname mismatch")
        assert(user.password == "password", "Get user password mismatch")
        assert(user.isAdmin == false, "Get user isAdmin mismatch")
    } else {
        assert(false, "Get user failed")
    }
    
    print("UserService tests passed")
}

// Test for FileService
func testFileService() {
    let fileService = FileService()
    
    // Test saving and loading users
    let testData = "user1,password1,false\nuser2,password2,true"
    fileService.saveUsers(data: testData)
    if let loadedData = fileService.loadUsers() {
        assert(loadedData == testData, "FileService loadUsers data mismatch")
    } else {
        assert(false, "FileService loadUsers failed")
    }
    
    print("FileService tests passed")
}

// Run all tests
func runTests() {
    testUserService()
    testFileService()
}

runTests()
