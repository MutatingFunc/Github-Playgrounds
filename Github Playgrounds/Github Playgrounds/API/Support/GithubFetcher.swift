import SwiftUI
import ComposableArchitecture

private enum GithubFetcherKey: DependencyKey {
    static var liveValue: any GithubFetcher { GithubFetcherLive() }
    static var previewValue: any GithubFetcher { GithubFetcherPreview() }
    static var testValue: any GithubFetcher { GithubFetcherPreview() }
}
extension DependencyValues {
    /// The configured networking environment, for fetching data from Github APIs.
    var githubFetcher: any GithubFetcher {
        get { self[GithubFetcherKey.self] }
        set { self[GithubFetcherKey.self] = newValue }
    }
}

/// The protocol for the networking layer. This may be mocked out.
protocol GithubFetcher {
    func fetch<API: GithubAPI>(from api: API) async throws -> API.Response
}

/// A type to make real calls to the network.
struct GithubFetcherLive: GithubFetcher {
    @Dependency(\.urlSession) private var urlSession
    
    func fetch<API: GithubAPI>(from api: API) async throws -> API.Response {
        let (data, _) = try await urlSession.data(for: api.urlRequest())
        return try JSONDecoder().decode(API.Response.self, from: data)
    }
}

/// A type which uses the mocked calls provided by APIs. To be used by previews, snapshot tests, etc.
struct GithubFetcherPreview: GithubFetcher {
    var delay: Int = 1
    var error: Error?
    func fetch<API: GithubAPI>(from api: API) async throws -> API.Response {
        try await Task.sleep(for: .seconds(delay))
        if let error {
            throw error
        } else {
            return api.previewData()
        }
    }
}
