import SwiftUI

/// Fetches a list of users.
struct UsersAPI: GithubAPI {
    var apiPath: String { "users" }
    
    func previewData() -> [User] {
        [
            User(login: "mojombo", id: 1, avatar_url: "about:blank")
        ]
    }
    
    struct User: Decodable {
        var login: String // "mojombo",
        var id: Int // 1,
        // var node_id: String // "MDQ6VXNlcjE=",
        var avatar_url: String // "https://avatars.githubusercontent.com/u/1?v=4",
        // var gravatar_id: String // "",
        // var url: String // "https://api.github.com/users/mojombo",
        // var html_url: String // "https://github.com/mojombo",
        // var followers_url: String // "https://api.github.com/users/mojombo/followers",
        // var following_url: String // "https://api.github.com/users/mojombo/following{/other_user}",
        // var gists_url: String // "https://api.github.com/users/mojombo/gists{/gist_id}",
        // var starred_url: String // "https://api.github.com/users/mojombo/starred{/owner}{/repo}",
        // var subscriptions_url: String // "https://api.github.com/users/mojombo/subscriptions",
        // var organizations_url: String // "https://api.github.com/users/mojombo/orgs",
        // var repos_url: String // "https://api.github.com/users/mojombo/repos",
        // var events_url: String // "https://api.github.com/users/mojombo/events{/privacy}",
        // var received_events_url: String // "https://api.github.com/users/mojombo/received_events",
        // var type: String // "User",
        // var site_admin: Bool // false
    }
}
