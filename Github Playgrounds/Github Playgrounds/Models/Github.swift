import SwiftUI
import ComposableArchitecture

private enum GithubKey: DependencyKey {
    static var liveValue: any Github { GithubLive() }
    static var previewValue: any Github { GithubPreview() }
    static var testValue: any Github { GithubPreview() }
}
extension DependencyValues {
    /// The Github model from which the UI will access data.
    var github: any Github {
        get { self[GithubKey.self] }
        set { self[GithubKey.self] = newValue }
    }
}

/// Represents the Github API surface
protocol Github {
    /// Produces a list of users.
    func users() async throws -> [User]
    /// Produces the details for a given user.
    func details(for user: User) async throws -> User.Details
    /// Produces a list of repositories for a given user.
    func repos(for user: User) async throws -> [User.Repository]
}

struct GithubLive: Github {
    @Dependency(\.githubFetcher) private var githubFetcher
    @Dependency(\.urlSession) private var urlSession
    
    func users() async throws -> [User] {
        try await githubFetcher
            .fetch(from: UsersAPI())
            .map { user in
                User(
                    username: user.login,
                    id: user.id,
                    avatar: { try await avatar(from: user.avatar_url) },
                    details: nil
                )
            }
    }
    
    func details(for user: User) async throws -> User.Details {
        let details = try await githubFetcher
            .fetch(from: UserDetailsAPI(username: user.username))
        return User.Details(
            fullName: details.name,
            company: details.company,
            location: details.location,
            email: details.email,
            bio: details.bio,
            repoCount: details.public_repos,
            followCount: details.following,
            followerCount: details.followers
        )
    }
    
    func repos(for user: User) async throws -> [User.Repository] {
        try await githubFetcher
            .fetch(from: UserReposAPI(username: user.username))
            .map { repo in
                User.Repository(
                    id: repo.id,
                    name: repo.name,
                    path: repo.full_name,
                    description: repo.description,
                    isFork: repo.fork,
                    forkCount: repo.forks_count,
                    starCount: repo.stargazers_count,
                    watcherCount: repo.watchers_count,
                    hasIssues: repo.has_issues,
                    hasProjects: repo.has_projects,
                    hasWiki: repo.has_wiki,
                    hasPages: repo.has_pages,
                    hasDownloads: repo.has_downloads,
                    hasDiscussions: repo.has_discussions,
                    archived: repo.archived,
                    disabled: repo.disabled
                )
            }
    }
    
    func avatar(from avatarURLString: String) async throws -> Image {
        guard let avatarURL = URL(string: avatarURLString) else {
            throw GithubAPIError.invalidAvatarURL
        }
        let (data, _) = try await urlSession.data(from: avatarURL)
        guard let image = UIImage(data: data) else {
            throw GithubAPIError.invalidAvatarData
        }
        return Image(uiImage: image)
    }
}

struct GithubPreview: Github {
    
    func users() async throws -> [User] {
        try await Task.sleep(for: .seconds(0.5))
        return [User.preview()]
    }
    
    func details(for user: User) async throws -> User.Details {
        try await Task.sleep(for: .seconds(0.5))
        return User.Details.preview()
    }
    
    func repos(for user: User) async throws -> [User.Repository] {
        try await Task.sleep(for: .seconds(0.5))
        return [User.Repository.preview()]
    }
}
