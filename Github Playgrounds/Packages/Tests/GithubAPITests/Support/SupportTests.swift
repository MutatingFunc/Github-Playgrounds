import XCTest
@testable import GithubAPI

private struct MockAPI: GithubAPI {
    var apiPath: String { "mock" }
    func previewData() -> Response {
        Response()
    }
    struct Response: Decodable {}
}

final class SupportTests: XCTestCase {
    
    func testCanReadAccessToken() {
        do {
            let token = try Support.projectAccessToken()
            XCTAssert(true, "Can read token\n\(token)")
        } catch {
            XCTAssert(false, "Error:\n\(error)")
        }
    }
}
