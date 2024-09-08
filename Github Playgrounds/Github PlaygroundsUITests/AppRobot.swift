import XCTest

struct AppRobot: Robot {
    
    private var sidebarButton: XCUIElement {
        app.navigationBars.firstMatch.buttons["Show Sidebar"]
    }
    
    func launch() -> UserListRobot {
        // Provide any launch arguments here
        app.launchEnvironment["SWIFT_DEPENDENCIES_CONTEXT"] = "test"
        app.launch()
        if sidebarButton.exists {
            sidebarButton.tap()
        }
        return .init()
    }
    
}
