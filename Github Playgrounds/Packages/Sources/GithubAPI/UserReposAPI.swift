import Foundation

/// Fetches a list of repositories for the given user.
public struct UserReposAPI: GithubAPI {
    public var username: String
    
    public var kind: Kind
    public enum Kind: String { case all, owner, member }
    
    public var sort: Sort
    public enum Sort: String { case created, updated, pushed, full_name }
    
    public init(username: String, kind: Kind = .owner, sort: Sort = .full_name) {
        self.username = username
        self.kind = kind
        self.sort = sort
    }
    
    public var apiPath: String {
        // Avoid invalid characters in username breaking the URL
        let username = username.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? username
        return "users/\(username)/repos?kind=\(kind.rawValue)&sort=\(sort.rawValue)"
    }
    
    public func previewData() -> [Repository] {
        [
            Repository(
                id: 1296269,
                name: "Hello-World",
                full_name: "octocat/Hello-World",
                html_url: "https://github.com/octocat/Hello-World",
                description: "This your first repo!",
                fork: false,
                language: "swift",
                forks_count: 9,
                stargazers_count: 80,
                watchers_count: 80,
                has_issues: true,
                has_projects: true,
                has_wiki: true,
                has_pages: false,
                has_downloads: true,
                has_discussions: false,
                archived: false,
                disabled: false,
                pushed_at: "2011-01-26T19:06:43Z",
                created_at: "2011-01-26T19:01:12Z",
                updated_at: "2011-01-26T19:14:43Z"
            )
        ]
    }
    
    public struct Repository: Decodable {
        public var id: Int // 1296269,
        // "node_id": "MDEwOlJlcG9zaXRvcnkxMjk2MjY5",
        public var name: String // "Hello-World",
        public var full_name: String // "octocat/Hello-World",
        // "owner": {
        //   "login": "octocat",
        //   "id": 1,
        //   "node_id": "MDQ6VXNlcjE=",
        //   "avatar_url": "https://github.com/images/error/octocat_happy.gif",
        //   "gravatar_id": "",
        //   "url": "https://api.github.com/users/octocat",
        //   "html_url": "https://github.com/octocat",
        //   "followers_url": "https://api.github.com/users/octocat/followers",
        //   "following_url": "https://api.github.com/users/octocat/following{/other_user}",
        //   "gists_url": "https://api.github.com/users/octocat/gists{/gist_id}",
        //   "starred_url": "https://api.github.com/users/octocat/starred{/owner}{/repo}",
        //   "subscriptions_url": "https://api.github.com/users/octocat/subscriptions",
        //   "organizations_url": "https://api.github.com/users/octocat/orgs",
        //   "repos_url": "https://api.github.com/users/octocat/repos",
        //   "events_url": "https://api.github.com/users/octocat/events{/privacy}",
        //   "received_events_url": "https://api.github.com/users/octocat/received_events",
        //   "type": "User",
        //   "site_admin": false
        // },
        // "private": false,
        public var html_url: String // "https://github.com/octocat/Hello-World",
        public var description: String? // "This your first repo!",
        public var fork: Bool // false,
        // "url": "https://api.github.com/repos/octocat/Hello-World",
        // "archive_url": "https://api.github.com/repos/octocat/Hello-World/{archive_format}{/ref}",
        // "assignees_url": "https://api.github.com/repos/octocat/Hello-World/assignees{/user}",
        // "blobs_url": "https://api.github.com/repos/octocat/Hello-World/git/blobs{/sha}",
        // "branches_url": "https://api.github.com/repos/octocat/Hello-World/branches{/branch}",
        // "collaborators_url": "https://api.github.com/repos/octocat/Hello-World/collaborators{/collaborator}",
        // "comments_url": "https://api.github.com/repos/octocat/Hello-World/comments{/number}",
        // "commits_url": "https://api.github.com/repos/octocat/Hello-World/commits{/sha}",
        // "compare_url": "https://api.github.com/repos/octocat/Hello-World/compare/{base}...{head}",
        // "contents_url": "https://api.github.com/repos/octocat/Hello-World/contents/{+path}",
        // "contributors_url": "https://api.github.com/repos/octocat/Hello-World/contributors",
        // "deployments_url": "https://api.github.com/repos/octocat/Hello-World/deployments",
        // "downloads_url": "https://api.github.com/repos/octocat/Hello-World/downloads",
        // "events_url": "https://api.github.com/repos/octocat/Hello-World/events",
        // "forks_url": "https://api.github.com/repos/octocat/Hello-World/forks",
        // "git_commits_url": "https://api.github.com/repos/octocat/Hello-World/git/commits{/sha}",
        // "git_refs_url": "https://api.github.com/repos/octocat/Hello-World/git/refs{/sha}",
        // "git_tags_url": "https://api.github.com/repos/octocat/Hello-World/git/tags{/sha}",
        // "git_url": "git:github.com/octocat/Hello-World.git",
        // "issue_comment_url": "https://api.github.com/repos/octocat/Hello-World/issues/comments{/number}",
        // "issue_events_url": "https://api.github.com/repos/octocat/Hello-World/issues/events{/number}",
        // "issues_url": "https://api.github.com/repos/octocat/Hello-World/issues{/number}",
        // "keys_url": "https://api.github.com/repos/octocat/Hello-World/keys{/key_id}",
        // "labels_url": "https://api.github.com/repos/octocat/Hello-World/labels{/name}",
        // "languages_url": "https://api.github.com/repos/octocat/Hello-World/languages",
        // "merges_url": "https://api.github.com/repos/octocat/Hello-World/merges",
        // "milestones_url": "https://api.github.com/repos/octocat/Hello-World/milestones{/number}",
        // "notifications_url": "https://api.github.com/repos/octocat/Hello-World/notifications{?since,all,participating}",
        // "pulls_url": "https://api.github.com/repos/octocat/Hello-World/pulls{/number}",
        // "releases_url": "https://api.github.com/repos/octocat/Hello-World/releases{/id}",
        // "ssh_url": "git@github.com:octocat/Hello-World.git",
        // "stargazers_url": "https://api.github.com/repos/octocat/Hello-World/stargazers",
        // "statuses_url": "https://api.github.com/repos/octocat/Hello-World/statuses/{sha}",
        // "subscribers_url": "https://api.github.com/repos/octocat/Hello-World/subscribers",
        // "subscription_url": "https://api.github.com/repos/octocat/Hello-World/subscription",
        // "tags_url": "https://api.github.com/repos/octocat/Hello-World/tags",
        // "teams_url": "https://api.github.com/repos/octocat/Hello-World/teams",
        // "trees_url": "https://api.github.com/repos/octocat/Hello-World/git/trees{/sha}",
        // "clone_url": "https://github.com/octocat/Hello-World.git",
        // "mirror_url": "git:git.example.com/octocat/Hello-World",
        // "hooks_url": "https://api.github.com/repos/octocat/Hello-World/hooks",
        // "svn_url": "https://svn.github.com/octocat/Hello-World",
        // "homepage": "https://github.com",
        public var language: String? // null,
        public var forks_count: Int // 9,
        public var stargazers_count: Int // 80,
        public var watchers_count: Int // 80,
        // "size": 108,
        // "default_branch": "master",
        // "open_issues_count": 0,
        // "is_template": false,
        // "topics": [
        //   "octocat",
        //   "atom",
        //   "electron",
        //   "api"
        // ],
        public var has_issues: Bool // true,
        public var has_projects: Bool // true,
        public var has_wiki: Bool // true,
        public var has_pages: Bool // false,
        public var has_downloads: Bool // true,
        public var has_discussions: Bool // false,
        public var archived: Bool // false,
        public var disabled: Bool // false,
        // "visibility": "public",
        public var pushed_at: String? // "2011-01-26T19:06:43Z",
        public var created_at: String // "2011-01-26T19:01:12Z",
        public var updated_at: String? // "2011-01-26T19:14:43Z",
        // "permissions": {
        //   "admin": false,
        //   "push": false,
        //   "pull": true
        // },
        // "security_and_analysis": {
        //   "advanced_security": {
        //     "status": "enabled"
        //   },
        //   "secret_scanning": {
        //     "status": "enabled"
        //   },
        //   "secret_scanning_push_protection": {
        //     "status": "disabled"
        //   },
        //   "secret_scanning_non_provider_patterns": {
        //     "status": "disabled"
        //   }
        // }
    }
}
