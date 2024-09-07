import SwiftUI

/// Fetches details of a given user.
struct UserDetailsAPI: GithubAPI {
    var username: String
    var apiPath: String {
        // Avoid invalid characters in username breaking the URL
        let username = username.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? username
        return "users/\(username)"
    }
    
    func previewData() -> Response {
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
    
    struct Response: Decodable {
        var login: String // "octocat",
        // var id: Int // 1,
        // var node_id: String // "MDQ6VXNlcjE=",
        var avatar_url: String // "https://github.com/images/error/octocat_happy.gif",
        // var gravatar_id: String // "",
        // var url: String // "https://api.github.com/users/octocat",
        var html_url: String // "https://github.com/octocat",
        // var followers_url: String // "https://api.github.com/users/octocat/followers",
        // var following_url: String // "https://api.github.com/users/octocat/following{/other_user}",
        // var gists_url: String // "https://api.github.com/users/octocat/gists{/gist_id}",
        // var starred_url: String // "https://api.github.com/users/octocat/starred{/owner}{/repo}",
        // var subscriptions_url: String // "https://api.github.com/users/octocat/subscriptions",
        // var organizations_url: String // "https://api.github.com/users/octocat/orgs",
        // var repos_url: String // "https://api.github.com/users/octocat/repos",
        // var events_url: String // "https://api.github.com/users/octocat/events{/privacy}",
        // var received_events_url: String // "https://api.github.com/users/octocat/received_events",
        // var type: String // "User",
        // var site_admin: Bool // false,
        var name: String? // "monalisa octocat",
        var company: String? // "GitHub",
        var blog: String? // "https://github.com/blog",
        var location: String? // "San Francisco",
        var email: String? // "octocat@github.com",
        // var hireable: Bool // false,
        var bio: String? // "There once was...",
        var twitter_username: String? // "monatheoctocat",
        var public_repos: Int // 2,
        var public_gists: Int // 1,
        var followers: Int // 20,
        var following: Int // 0,
        // var created_at: String // "2008-01-14T04:33:35Z",
        // var updated_at: String // "2008-01-14T04:33:35Z"
    }
}
