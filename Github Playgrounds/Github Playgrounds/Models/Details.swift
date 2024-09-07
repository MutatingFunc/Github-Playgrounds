import SwiftUI

extension User {
    /// The further details of a Github user which may be fetched at a later time.
    struct Details {
        var fullName: String
        var company: String
        var location: String
        var email: String
        var bio: String
        var repoCount: Int
        var followCount: Int
        var followerCount: Int
        
        static func preview() -> Self {
            Self(
                fullName: "monalisa octocat",
                company: "GitHub",
                location: "San Francisco",
                email: "octocat@github.com",
                bio: "There once was...",
                repoCount: 2,
                followCount: 20,
                followerCount: 0
            )
        }
    }
}
