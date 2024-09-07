import SwiftUI
import XCTest
@testable import Github_Playgrounds

private struct MockAPI: GithubAPI {
    var apiPath: String { "mock" }
    func previewData() -> Response {
        Response()
    }
    struct Response: Decodable {}
}

final class GithubAPITests: XCTestCase {
    
    func testCanReadAccessToken() {
        do {
            let token = try projectAccessToken()
            XCTAssert(true, "Can read token\n\(token)")
        } catch {
            XCTAssert(false, "Error:\n\(error)")
        }
    }
    
    func canFormURL() {
        XCTAssertNotNil(MockAPI().url)
    }
    
    func testURLRequestIsWellFormed() throws {
        let request = try MockAPI().urlRequest()
        if let header = request.allHTTPHeaderFields {
            XCTAssertEqual(header["Accept"], "application/vnd.github+json")
            XCTAssertEqual(header["User-Agent"], "James-Github-Playgrounds")
            XCTAssertNotEqual(header["Authorization"], nil)
        } else {
            XCTAssert(false, "Missing header fields")
        }
    }
}
