import XCTest

struct UserDetailsRobot<Parent: Robot>: PushedRobot {
    
    init() {
        XCTAssert(fullNameText.wait(for: \.exists))
    }
    
    private var fullNameText: XCUIElement {
        app.staticTexts["Full Name"]
    }
    
    private func repoRow(_ name: String) -> XCUIElement {
        app.buttons[name]
    }
    
    func tapGithubRepo(_ name: String) -> SafariVCRobot<Self> {
        repoRow(name).tap()
        return .init()
    }
    
}
