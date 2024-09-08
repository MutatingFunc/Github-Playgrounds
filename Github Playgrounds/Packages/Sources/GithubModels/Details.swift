import SwiftUI

extension User {
    /// The further details of a Github user which may be fetched at a later time.
    public struct Details {
        public var fullName: String
        public var company: String
        public var location: String
        public var email: String
        public var bio: String
        public var repoCount: Int
        public var followingCount: Int
        public var followersCount: Int
        
        public static func preview() -> Self {
            Self(
                fullName: "monalisa octocat",
                company: "GitHub",
                location: "San Francisco",
                email: "octocat@github.com",
                bio: "There once was...",
                repoCount: 2,
                followingCount: 20,
                followersCount: 0
            )
        }
    }
}
