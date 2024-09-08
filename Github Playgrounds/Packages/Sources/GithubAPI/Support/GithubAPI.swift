import SwiftUI

private let baseURL = "https://api.github.com/"

/// Represents one of Github's APIs. Conforming requires declaring what the GithubFetcher implementation needs to fetch from this API.
public protocol GithubAPI {
    /// The API path to fetch data from.
    var apiPath: String { get }
    
    /// Optionally provide custom headers.
    func headers() throws -> [String: String]
    
    /// The response type which will be decoded from the data returned from the URL.
    associatedtype Response: Decodable
    
    /// A mock call & response used by the default previewing network layer.
    func previewData() -> Response
}
public extension GithubAPI {
    func headers() throws -> [String: String] { [:] }
    
    /// The fully-formed API URL.
    var url: URL? { URL(string: baseURL + apiPath) }
    
    /// The fully-formed API Request.
    func urlRequest(for url: URL) throws -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = try Support.projectDefaultRequest()
            .merging(self.headers(), uniquingKeysWith: { $1 })
        return urlRequest
    }
}
