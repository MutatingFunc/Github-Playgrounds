import XCTest

let app = XCUIApplication()

/// A stateless representation of the UI, for composition of UI test logic.
protocol Robot {
    init()
}

protocol PushedRobot<Parent>: Robot {
    associatedtype Parent: Robot
    func goBack() -> Parent
}
extension PushedRobot {
    func goBack() -> Parent {
        app.navigationBars.firstMatch.buttons.firstMatch.tap()
        return .init()
    }
}
