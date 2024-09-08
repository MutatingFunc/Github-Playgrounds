import SwiftUI

/// Fetches details of a given user.
public struct UserDetailsAPI: GithubAPI {
    public var username: String
    public init(username: String) {
        self.username = username
    }
    
    public var apiPath: String {
        // Avoid invalid characters in username breaking the URL
        let username = username.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? username
        return "users/\(username)"
    }
    
    public func previewData() -> Response {
        Response(
            login: "octocat",
            avatar_url: "https://github.com/images/error/octocat_happy.gif",
            html_url: "https://github.com/octocat",
            name: "monalisa octocat",
            company: "GitHub",
            blog: "https://github.com/blog",
            location: "San Francisco",
            email: "octocat@github.com",
            bio: "There once was...",
            twitter_username: "monatheoctocat",
            public_repos: 2,
            public_gists: 1,
            followers: 20,
            following: 0
        )
    }
    
    public struct Response: Decodable {
        public var login: String // "octocat",
        // public var id: Int // 1,
        // public var node_id: String // "MDQ6VXNlcjE=",
        public var avatar_url: String // "https://github.com/images/error/octocat_happy.gif",
        // public var gravatar_id: String // "",
        // public var url: String // "https://api.github.com/users/octocat",
        public var html_url: String // "https://github.com/octocat",
        // public var followers_url: String // "https://api.github.com/users/octocat/followers",
        // public var following_url: String // "https://api.github.com/users/octocat/following{/other_user}",
        // public var gists_url: String // "https://api.github.com/users/octocat/gists{/gist_id}",
        // public var starred_url: String // "https://api.github.com/users/octocat/starred{/owner}{/repo}",
        // public var subscriptions_url: String // "https://api.github.com/users/octocat/subscriptions",
        // public var organizations_url: String // "https://api.github.com/users/octocat/orgs",
        // public var repos_url: String // "https://api.github.com/users/octocat/repos",
        // public var events_url: String // "https://api.github.com/users/octocat/events{/privacy}",
        // public var received_events_url: String // "https://api.github.com/users/octocat/received_events",
        // public var type: String // "User",
        // public var site_admin: Bool // false,
        public var name: String? // "monalisa octocat",
        public var company: String? // "GitHub",
        public var blog: String? // "https://github.com/blog",
        public var location: String? // "San Francisco",
        public var email: String? // "octocat@github.com",
        // var hireable: Bool // false,
        public var bio: String? // "There once was...",
        public var twitter_username: String? // "monatheoctocat",
        public var public_repos: Int // 2,
        public var public_gists: Int // 1,
        public var followers: Int // 20,
        public var following: Int // 0,
        // public var created_at: String // "2008-01-14T04:33:35Z",
        // public var updated_at: String // "2008-01-14T04:33:35Z"
    }
}
