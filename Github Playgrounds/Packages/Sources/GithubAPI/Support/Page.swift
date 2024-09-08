import Foundation

/// Represents a paginated API page.
public struct Page {
    var url: URL
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
