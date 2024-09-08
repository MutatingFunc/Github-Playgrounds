import SwiftUI
import ComposableArchitecture

private enum GithubFetcherKey: DependencyKey {
    static var liveValue: any GithubFetcher { GithubFetcherLive() }
    static var previewValue: any GithubFetcher { GithubFetcherPreview() }
    static var testValue: any GithubFetcher { GithubFetcherPreview() }
}
public extension DependencyValues {
    /// The configured networking environment, for fetching data from Github APIs.
    var githubFetcher: any GithubFetcher {
        get { self[GithubFetcherKey.self] }
        set { self[GithubFetcherKey.self] = newValue }
    }
}

/// Represents a paginated API page.
public struct Page {
    fileprivate var url: URL
    init(url: URL) {
        self.url = url
    }
    
    /// Create from a link header received via API.
    public init?(nextInLinkHeader linkHeader: String) {
        let regex = /<([^>]*)>; rel="next"/
        do {
            let urlString = try regex.firstMatch(in: linkHeader)?.output.1
            if let urlString, let url = URL(string: String(urlString)) {
                self.url = url
            } else {
                return nil
            }
        } catch {
            print(error)
            return nil
        }
    }
    
    public static func preview() -> Self {
        Self.init(url: URL(string: "about:blank")!)
    }
}

/// The protocol for the networking layer. This may be mocked out.
public protocol GithubFetcher {
    /// Fetches content from an API, optionally fetching content following a given page.
    /// - Parameters:
    ///   - api: The API to fetch from.
    ///   - page: If specified, fetches content on the given page.
    /// - Returns: The response from the API, and the next page of content if it exists
    func fetch<API: GithubAPI>(from api: API, page: Page?) async throws -> (response: API.Response, nextPage: Page?)
}

/// A type to make real calls to the network.
struct GithubFetcherLive: GithubFetcher {
    @Dependency(\.urlSession) private var urlSession
    
    func fetch<API: GithubAPI>(from api: API, page: Page?) async throws -> (response: API.Response, nextPage: Page?) {
        let url = page?.url ?? api.url
        guard let url else { throw GithubAPIError.invalidAPIURL }
        
        let (data, urlResponse) = try await urlSession.data(for: api.urlRequest(for: url))
        var page: Page? = nil
        if let urlResponse = urlResponse as? HTTPURLResponse, let link = urlResponse.value(forHTTPHeaderField: "Link") {
            page = Page(nextInLinkHeader: link)
        }
        
        let apiResponse = try JSONDecoder().decode(API.Response.self, from: data)
        return (apiResponse, page)
    }
}

/// A type which uses the mocked calls provided by APIs. To be used by previews, snapshot tests, etc.
struct GithubFetcherPreview: GithubFetcher {
    var delay: Int = 1
    var error: Error? = nil
    
    public func fetch<API: GithubAPI>(from api: API, page: Page?) async throws -> (response: API.Response, nextPage: Page?) {
        try await Task.sleep(for: .seconds(delay))
        if let error {
            throw error
        } else if page != nil {
            return (api.previewData(), nil)
        } else if let apiURL = api.url {
            return (api.previewData(), Page(url: apiURL))
        } else {
            throw GithubAPIError.invalidAPIURL
        }
    }
}
