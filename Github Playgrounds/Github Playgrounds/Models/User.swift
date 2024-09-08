import SwiftUI
import ComposableArchitecture

/// The basic details of a Github user, abstracted away from the underlying data source.
struct User: Identifiable {
    var username: String
    var id: Int
    var avatar: () async throws -> Image
    var details: Details? = nil
    var repos: [Repository] = []
    
    static func preview() -> Self {
        return Self(
            username: "octocat",
            id: UUID().hashValue,
            avatar: {
                try await Task.sleep(for: .seconds(0.5))
                return Image(systemName: "person.fill")
            },
            details: .preview(),
            repos: (0...100).map { _ in .preview() }
        )
    }
}
