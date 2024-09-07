import SwiftUI
import XCTest
@testable import Github_Playgrounds

final class UserDetailsAPITests: XCTestCase {
    
    func testCanGetURLForUserDetails() {
        let user: User = .preview()
        
        let api = UserDetailsAPI(username: user.username)
        
        XCTAssertEqual(api.url, URL(string: "https://api.github.com/users/\(user.username)"))
    }
    
    func testUsersParsing() throws {
        let userDetails = try JSONDecoder().decode(
            UserDetailsAPI.Response.self,
            from: mockResponse
        )
        
        XCTAssertEqual(userDetails.login, "octocat")
        XCTAssertEqual(userDetails.avatar_url, "https://github.com/images/error/octocat_happy.gif")
        XCTAssertEqual(userDetails.html_url, "https://github.com/octocat")
        XCTAssertEqual(userDetails.name, "monalisa octocat")
        XCTAssertEqual(userDetails.company, "GitHub")
        XCTAssertEqual(userDetails.blog, "https://github.com/blog")
        XCTAssertEqual(userDetails.location, "San Francisco")
        XCTAssertEqual(userDetails.email, "octocat@github.com")
        XCTAssertEqual(userDetails.bio, "There once was...")
        XCTAssertEqual(userDetails.twitter_username, "monatheoctocat")
        XCTAssertEqual(userDetails.public_repos, 2)
        XCTAssertEqual(userDetails.public_gists, 1)
        XCTAssertEqual(userDetails.followers, 20)
        XCTAssertEqual(userDetails.following, 0)
    }
}

private let mockResponse = """
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
  "site_admin": false,
  "name": "monalisa octocat",
  "company": "GitHub",
  "blog": "https://github.com/blog",
  "location": "San Francisco",
  "email": "octocat@github.com",
  "hireable": false,
  "bio": "There once was...",
  "twitter_username": "monatheoctocat",
  "public_repos": 2,
  "public_gists": 1,
  "followers": 20,
  "following": 0,
  "created_at": "2008-01-14T04:33:35Z",
  "updated_at": "2008-01-14T04:33:35Z"
}
""".data(using: .utf8)!
