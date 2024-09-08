import XCTest

final class NavigationUITests: XCTestCase {
    func testBasicNavigation() {
        _ = AppRobot()
            .launch()
            .tapUser("mojombo")
            .tapGithubRepo("30daysoflaptops.github.io")
            .goBack()
            .goBack()
    }
}
