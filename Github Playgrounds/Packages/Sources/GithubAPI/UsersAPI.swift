import SwiftUI

/// Fetches a list of users.
public struct UsersAPI: GithubAPI {
    
    public init() {}
    
    public var apiPath: String { "users" }
    
    public func previewData() -> [User] {
        [
            User(login: "mojombo", id: 1, avatar_url: "about:blank")
        ]
    }
    
    public struct User: Decodable {
        public var login: String // "mojombo",
        public var id: Int // 1,
        // public var node_id: String // "MDQ6VXNlcjE=",
        public var avatar_url: String // "https://avatars.githubusercontent.com/u/1?v=4",
        // public var gravatar_id: String // "",
        // public var url: String // "https://api.github.com/users/mojombo",
        // public var html_url: String // "https://github.com/mojombo",
        // public var followers_url: String // "https://api.github.com/users/mojombo/followers",
        // public var following_url: String // "https://api.github.com/users/mojombo/following{/other_user}",
        // public var gists_url: String // "https://api.github.com/users/mojombo/gists{/gist_id}",
        // public var starred_url: String // "https://api.github.com/users/mojombo/starred{/owner}{/repo}",
        // public var subscriptions_url: String // "https://api.github.com/users/mojombo/subscriptions",
        // public var organizations_url: String // "https://api.github.com/users/mojombo/orgs",
        // public var repos_url: String // "https://api.github.com/users/mojombo/repos",
        // public var events_url: String // "https://api.github.com/users/mojombo/events{/privacy}",
        // public var received_events_url: String // "https://api.github.com/users/mojombo/received_events",
        // public var type: String // "User",
        // public var site_admin: Bool // false
    }
}
