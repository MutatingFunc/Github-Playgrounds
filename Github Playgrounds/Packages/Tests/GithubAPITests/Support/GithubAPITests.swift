import XCTest
@testable import GithubAPI

private struct MockAPI: GithubAPI {
    var apiPath: String { "mock" }
    func previewData() -> Response {
        Response()
    }
    struct Response: Decodable {}
}

final class GithubAPITests: XCTestCase {
    
    func testCanFormURL() {
        XCTAssertNotNil(MockAPI().url)
    }
    
    func testURLRequestIsWellFormed() throws {
        let mockAPI = MockAPI()
        let url = try XCTUnwrap(mockAPI.url)
        let request = try mockAPI.urlRequest(for: url)
        if let header = request.allHTTPHeaderFields {
            XCTAssertEqual(header["Accept"], "application/vnd.github+json")
            XCTAssertEqual(header["User-Agent"], "James-Github-Playgrounds")
            XCTAssertNotEqual(header["Authorization"], nil)
        } else {
            XCTAssert(false, "Missing header fields")
        }
    }
}
