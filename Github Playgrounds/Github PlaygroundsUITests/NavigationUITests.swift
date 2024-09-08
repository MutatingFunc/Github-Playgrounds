import XCTest

final class NavigationUITests: XCTestCase {
    func testBasicNavigation() {
        _ = AppRobot()
            .launch()
            .tapUser("octocat")
            .tapGithubRepo("Hello-World")
            .goBack()
            .goBack()
    }
}
