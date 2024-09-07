import SwiftUI

private let baseURL = "https://api.github.com/"

// Fetches the access token from `Resources/Access Token.txt`.
func projectAccessToken() throws -> String {
    if let url = Bundle.main.url(forResource: "Access Token", withExtension: "txt") {
        try String(contentsOf: url)
    } else {
        throw GithubAPIError.noAccessToken
    }
}

func projectDefaultRequest(accessToken: @autoclosure () throws -> String = try projectAccessToken()) rethrows -> [String: String] {
    try [
        "Accept": "application/vnd.github+json",
        "User-Agent": "James-Github-Playgrounds",
        "Authorization": "Bearer " + accessToken(),
    ]
}

/// Represents one of Github's APIs. Conforming requires declaring what the GithubFetcher implementation needs to fetch from this API.
protocol GithubAPI {
    /// The API path to fetch data from.
    var apiPath: String { get }
    
    /// Optionally provide custom headers.
    func headers() throws -> [String: String]
    
    /// The response type which will be decoded from the data returned from the URL.
    associatedtype Response: Decodable
    
    /// A mock call & response used by the default previewing network layer.
    func previewData() -> Response
}
extension GithubAPI {
    func headers() throws -> [String: String] { [:] }
    
    /// The fully-formed API URL.
    var url: URL? { URL(string: baseURL + apiPath) }
    
    /// The fully-formed API Request.
    func urlRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: url!)
        urlRequest.allHTTPHeaderFields = try [
            "Accept": "application/vnd.github+json",
            "User-Agent": "James-Github-Playgrounds",
            "Authorization": "Bearer " + projectAccessToken(),
        ].merging(self.headers(), uniquingKeysWith: { $1 })
        return urlRequest
    }
}
