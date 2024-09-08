import XCTest

struct UserListRobot: Robot {
    
    init() {
        XCTAssert(app.collectionViews["Users"].isHittable)
    }
    
    private func userRow(_ name: String) -> XCUIElement {
        app.buttons[name]
    }
    
    func tapUser(_ name: String) -> UserDetailsRobot<Self> {
        userRow(name).tap()
        return .init()
    }
    
}
