import XCTest

struct SafariVCRobot<Parent: Robot>: PushedRobot {
    
    init() {
        XCTAssert(openInSafariButton.wait(for: \.exists))
    }
    
    private var openInSafariButton: XCUIElement {
        app.buttons["OpenInSafariButton"]
    }
    
    private var closeButton: XCUIElement {
        app.buttons["Close"]
    }
    
    func goBack() -> Parent {
        // For some reason a regular tap on the XCUIElement is not working on iPhone, only iPad.
        // Tapping with a finger works in both cases.
        closeButton.coordinate(withNormalizedOffset: CGVector(dx: 0.8, dy: 0.8)).tap()
        return .init()
    }
}
