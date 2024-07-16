import XCTest
@testable import practice3

final class task_31_home_test: XCTestCase {
    func testProductInverse() {
        let result = inverseValue(x: 2.0, y: 3.0, z: 4.0)
        XCTAssertEqual(result, 1 / 24.0, accuracy: 0.01)
    }
    
    func testSumInverse() {
        let result = inverseValue(x: 0.0, y: 1.0, z: -1.0)
        XCTAssertEqual(result, -4.0, accuracy: 0.01)
    }
    
    func testProductAndSumZero() {
        let result = inverseValue(x: 0.0, y: 0.0, z: 0.0)
        XCTAssertEqual(result, 0.0, accuracy: 0.01)
    }
    
    func testComplexCalculation() {
        let result = inverseValue(x: 1.0, y: -1.0, z: 2.0)
        XCTAssertEqual(result, -0.5, accuracy: 0.01)
    }

    static var allTests = [
        ("testProductInverse", testProductInverse),
        ("testSumInverse", testSumInverse),
        ("testProductAndSumZero", testProductAndSumZero),
        ("testComplexCalculation", testComplexCalculation),
    ]
}
