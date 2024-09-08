import SwiftUI

/// An error produced when accessing the GithubAPI.
enum GithubAPIError: String, LocalizedError {
    case noAccessToken = "An access token must be added to the Resources directory to continue"
    case invalidAPIURL = "An API URL was invalid"
    case invalidAvatarURL = "Avatar URL was invalid"
    case invalidAvatarData = "Failed to convert avatar data to an image"
    
    var errorDescription: String? { rawValue }
}
