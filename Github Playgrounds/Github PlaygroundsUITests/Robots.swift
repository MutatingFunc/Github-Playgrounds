import XCTest

let app = XCUIApplication()

/// A stateless representation of the UI, for composition of UI test logic.
protocol Robot {
    init()
}

/// A robot for a view which has been pushed to a NavigationStack.
protocol PushedRobot<Parent>: Robot {
    associatedtype Parent: Robot
    func goBack() -> Parent
}
extension PushedRobot {
    func goBack() -> Parent {
        app.navigationBars.buttons.firstMatch.tap()
        return .init()
    }
}
