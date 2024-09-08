import SwiftUI
import ComposableArchitecture
import GithubAPI

private enum GithubKey: DependencyKey {
    static var liveValue: any Github { GithubLive() }
    static var previewValue: any Github { GithubPreview() }
    static var testValue: any Github { GithubPreview() }
}
public extension DependencyValues {
    /// The Github model from which the UI will access data.
    var github: any Github {
        get { self[GithubKey.self] }
        set { self[GithubKey.self] = newValue }
    }
}

/// Represents the Github API surface
public protocol Github {
    /// Produces a list of users.
    func users(page: Page?) async throws -> (users: [User], nextPage: Page?)
    /// Produces the details for a given user.
    func details(for user: User) async throws -> User.Details
    /// Produces a list of repositories for a given user.
    func repos(for user: User, page: Page?) async throws -> (repos: [User.Repository], nextPage: Page?)
}

public typealias GithubPage = Page

struct GithubLive: Github {
    @Dependency(\.githubFetcher) private var githubFetcher
    @Dependency(\.urlSession) private var urlSession
    
    public func users(page: Page?) async throws -> (users: [User], nextPage: Page?) {
        let (response, page) = try await githubFetcher.fetch(from: UsersAPI(), page: page)
        let model = response.map { user in
            User(
                username: user.login,
                id: user.id,
                avatar: { try await avatar(from: user.avatar_url) },
                details: nil
            )
        }
        return (model, page)
    }
    
    public func details(for user: User) async throws -> User.Details {
        let (details, _) = try await githubFetcher
            .fetch(from: UserDetailsAPI(username: user.username), page: nil)
        return User.Details(
            fullName: details.name ?? "Anonymous",
            company: details.company ?? "",
            location: details.location ?? "",
            email: details.email ?? "",
            bio: details.bio ?? "",
            repoCount: details.public_repos,
            followingCount: details.following,
            followersCount: details.followers
        )
    }
    
    public func repos(for user: User, page: Page?) async throws -> (repos: [User.Repository], nextPage: Page?) {
        let (response, page) = try await githubFetcher
            .fetch(from: UserReposAPI(username: user.username), page: page)
        let model = response.map { repo in
                User.Repository(
                    id: repo.id,
                    name: repo.name,
                    path: repo.full_name,
                    url: URL(string: repo.html_url),
                    description: repo.description ?? "",
                    language: repo.language,
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
                    disabled: repo.disabled,
                    pushed: repo.pushed_at.flatMap(Support.date),
                    created: Support.date(from: repo.created_at),
                    updated: repo.updated_at.flatMap(Support.date)
                )
            }
        return (model, page)
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

public struct GithubPreview: Github {
    public var error: Error?
    public init(error: Error? = nil) {
        self.error = error
    }
    
    public func users(page: Page?) async throws -> (users: [User], nextPage: Page?) {
        if let error {
            throw error
        }
        try await Task.sleep(for: .seconds(0.5))
        let nextPage = page == nil ? Page.preview() : nil
        return ([User.preview()], nextPage)
    }
    
    public func details(for user: User) async throws -> User.Details {
        if let error {
            throw error
        }
        try await Task.sleep(for: .seconds(0.5))
        return User.Details.preview()
    }
    
    public func repos(for user: User, page: Page?) async throws -> (repos: [User.Repository], nextPage: Page?) {
        if let error {
            throw error
        }
        try await Task.sleep(for: .seconds(0.5))
        let nextPage = page == nil ? Page.preview() : nil
        return ([User.Repository.preview()], nextPage)
    }
}
