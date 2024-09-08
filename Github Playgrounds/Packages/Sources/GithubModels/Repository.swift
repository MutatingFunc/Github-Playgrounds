import Foundation
import GithubAPI

extension User {
    /// The further details of a Github user which may be fetched at a later time.
    public struct Repository: Identifiable {
        public var id: Int
        public var name: String
        public var path: String
        public var url: URL?
        public var description: String
        public var language: String?
        public var isFork: Bool
        public var forkCount: Int
        public var starCount: Int
        public var watcherCount: Int
        public var hasIssues: Bool
        public var hasProjects: Bool
        public var hasWiki: Bool
        public var hasPages: Bool
        public var hasDownloads: Bool
        public var hasDiscussions: Bool
        public var archived: Bool
        public var disabled: Bool
        public var pushed: Date?
        public var created: Date?
        public var updated: Date?
        
        public static func preview() -> Self {
            Self(
                id: UUID().hashValue,
                name: "Hello-World",
                path: "octocat/Hello-World",
                url: URL(string: "https://github.com/octocat/Hello-World")!,
                description: "This your first repo!",
                language: "swift",
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
                pushed: Support.date(from: "2011-01-26T19:06:43Z"),
                created: Support.date(from: "2011-01-26T19:01:12Z"),
                updated: Support.date(from: "2011-01-26T19:14:43Z")
            )
        }
    }
}
