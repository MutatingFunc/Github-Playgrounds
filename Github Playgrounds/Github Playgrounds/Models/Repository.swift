import SwiftUI

extension User {
    /// The further details of a Github user which may be fetched at a later time.
    struct Repository {
        var id: Int
        var name: String
        var path: String
        var url: URL?
        var description: String
        var isFork: Bool
        var forkCount: Int
        var starCount: Int
        var watcherCount: Int
        var hasIssues: Bool
        var hasProjects: Bool
        var hasWiki: Bool
        var hasPages: Bool
        var hasDownloads: Bool
        var hasDiscussions: Bool
        var archived: Bool
        var disabled: Bool
        var pushed: Date?
        var created: Date?
        var updated: Date?
        
        static func preview() -> Self {
            Self(
                id: 1296269,
                name: "Hello-World",
                path: "octocat/Hello-World",
                url: URL(string: "https://github.com/octocat/Hello-World")!,
                description: "This your first repo!",
                isFork: false,
                forkCount: 9,
                starCount: 80,
                watcherCount: 80,
                hasIssues: true,
                hasProjects: true,
                hasWiki: true,
                hasPages: false,
                hasDownloads: true,
                hasDiscussions: false,
                archived: false,
                disabled: false,
                pushed: date(from: "2011-01-26T19:06:43Z"),
                created: date(from: "2011-01-26T19:01:12Z"),
                updated: date(from: "2011-01-26T19:14:43Z")
            )
        }
    }
    
    static func date(from string: String) -> Date? {
        ISO8601DateFormatter().date(from: string)
    }
}
