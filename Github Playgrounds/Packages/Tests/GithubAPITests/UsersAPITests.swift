import XCTest
@testable import GithubAPI

final class UsersAPITests: XCTestCase {
    
    func testCanGetURLForListUsers() {
        let api = UsersAPI()
        
        XCTAssertEqual(api.url, URL(string: "https://api.github.com/users"))
    }
    
    func testUsersParsing() throws {
        let users = try JSONDecoder().decode(
            UsersAPI.Response.self,
            from: mockResponse
        )
        
        XCTAssertEqual(users.count, 1)
        
        let first = try XCTUnwrap(users.first)
        XCTAssertEqual(first.login, "octocat")
        XCTAssertEqual(first.id, 1)
        XCTAssertEqual(first.avatar_url, "https://github.com/images/error/octocat_happy.gif")
    }
}

private let mockResponse = """
[
  {
    "login": "octocat",
    "id": 1,
    "node_id": "MDQ6VXNlcjE=",
    "avatar_url": "https://github.com/images/error/octocat_happy.gif",
    "gravatar_id": "",
    "url": "https://api.github.com/users/octocat",
    "html_url": "https://github.com/octocat",
    "followers_url": "https://api.github.com/users/octocat/followers",
    "following_url": "https://api.github.com/users/octocat/following{/other_user}",
    "gists_url": "https://api.github.com/users/octocat/gists{/gist_id}",
    "starred_url": "https://api.github.com/users/octocat/starred{/owner}{/repo}",
    "subscriptions_url": "https://api.github.com/users/octocat/subscriptions",
    "organizations_url": "https://api.github.com/users/octocat/orgs",
    "repos_url": "https://api.github.com/users/octocat/repos",
    "events_url": "https://api.github.com/users/octocat/events{/privacy}",
    "received_events_url": "https://api.github.com/users/octocat/received_events",
    "type": "User",
    "site_admin": false
  }
]
""".data(using: .utf8)!
