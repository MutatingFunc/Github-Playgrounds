import XCTest
import ComposableArchitecture
@testable import Github_Playgrounds

final class GithubTests: XCTestCase {
    
    func testUsersMapping() async throws {
        let usersReponse = UsersAPI().previewData()
        
        let users = try await GithubLive().users()
        
        XCTAssertEqual(users.count, usersReponse.count)
        
        let actual = try XCTUnwrap(users.first)
        let preview = try XCTUnwrap(usersReponse.first)
        XCTAssertEqual(actual.username, preview.login)
        XCTAssertEqual(actual.id, preview.id)
    }
    
    func testUserDetailsMapping() async throws {
        let user: User = .preview()
        let detailsResponse = UserDetailsAPI(username: user.username).previewData()
        
        let details = try await GithubLive().details(for: user)
        
        XCTAssertEqual(details.fullName, detailsResponse.name)
        XCTAssertEqual(details.company, detailsResponse.company)
        XCTAssertEqual(details.location, detailsResponse.location)
        XCTAssertEqual(details.email, detailsResponse.email)
        XCTAssertEqual(details.bio, detailsResponse.bio)
        XCTAssertEqual(details.repoCount, detailsResponse.public_repos)
        XCTAssertEqual(details.followingCount, detailsResponse.following)
        XCTAssertEqual(details.followersCount, detailsResponse.followers)
    }
    
    func testUserReposMapping() async throws {
        let user: User = .preview()
        let reposResponse = UserReposAPI(username: user.username).previewData()
        
        let repos = try await GithubLive().repos(for: user)
        
        XCTAssertEqual(repos.count, reposResponse.count)
        
        let actual = try XCTUnwrap(repos.first)
        let preview = try XCTUnwrap(reposResponse.first)
        XCTAssertEqual(actual.id, preview.id)
        XCTAssertEqual(actual.name, preview.name)
        XCTAssertEqual(actual.path, preview.full_name)
        XCTAssertEqual(actual.url?.absoluteString, preview.html_url)
        XCTAssertEqual(actual.description, preview.description)
        XCTAssertEqual(actual.language, preview.language)
        XCTAssertEqual(actual.isFork, preview.fork)
        XCTAssertEqual(actual.forkCount, preview.forks_count)
        XCTAssertEqual(actual.starCount, preview.stargazers_count)
        XCTAssertEqual(actual.watcherCount, preview.watchers_count)
        XCTAssertEqual(actual.hasIssues, preview.has_issues)
        XCTAssertEqual(actual.hasProjects, preview.has_projects)
        XCTAssertEqual(actual.hasWiki, preview.has_wiki)
        XCTAssertEqual(actual.hasPages, preview.has_pages)
        XCTAssertEqual(actual.hasDownloads, preview.has_downloads)
        XCTAssertEqual(actual.hasDiscussions, preview.has_discussions)
        XCTAssertEqual(actual.archived, preview.archived)
        XCTAssertEqual(actual.disabled, preview.disabled)
        XCTAssertEqual(actual.pushed?.ISO8601Format(), preview.pushed_at)
        XCTAssertEqual(actual.created?.ISO8601Format(), preview.created_at)
        XCTAssertEqual(actual.updated?.ISO8601Format(), preview.updated_at)
    }
}
