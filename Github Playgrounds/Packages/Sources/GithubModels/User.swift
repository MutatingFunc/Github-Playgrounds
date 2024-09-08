import SwiftUI
import ComposableArchitecture

/// The basic details of a Github user, abstracted away from the underlying data source.
public struct User: Identifiable {
    public var username: String
    public var id: Int
    public var avatar: () async throws -> Image
    public var details: Details? = nil
    
    public static func preview(details: Details? = .preview()) -> Self {
        return Self(
            username: "octocat",
            id: UUID().hashValue,
            avatar: {
                try await Task.sleep(for: .seconds(0.5))
                return Image(systemName: "person.fill")
            },
            details: details
        )
    }
}
