import XCTest

struct AppRobot: Robot {
    
    private var sidebarButton: XCUIElement {
        app.navigationBars.firstMatch.buttons["Show Sidebar"]
    }
    
    func launch() -> UserListRobot {
        // Sets TCA's environment to a testing context.
        app.launchEnvironment["SWIFT_DEPENDENCIES_CONTEXT"] = "test"
        app.launch()
        // Open the sidebar if on iPad.
        if sidebarButton.exists {
            sidebarButton.tap()
        }
        return .init()
    }
    
}
