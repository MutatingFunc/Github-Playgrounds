import SwiftUI

/// The basic details of a Github user, abstracted away from the underlying data source.
struct User {
    var username: String
    var id: Int
    var avatar: () async throws -> Image
    var details: Details?
    var repos: [Repository]?
    
    static func preview() -> Self {
        Self(
            username: "mojombo",
            id: UUID().hashValue,
            avatar: {
                try await Task.sleep(for: .seconds(0.5))
                return Image(systemName: "person.fill")
            },
            details: .preview(),
            repos: [.preview()]
        )
    }
}
