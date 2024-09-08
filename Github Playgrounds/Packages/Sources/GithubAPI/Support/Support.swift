import Foundation

public enum Support {
    // Fetches the access token from `Resources/Access Token.txt`.
    static func projectAccessToken() throws -> String {
        if let url = Bundle.module.url(forResource: "Access Token", withExtension: "txt") {
            try String(contentsOf: url)
        } else {
            throw GithubAPIError.noAccessToken
        }
    }

    static func projectDefaultRequest(accessToken: @autoclosure () throws -> String = try Support.projectAccessToken()) rethrows -> [String: String] {
        try [
            "Accept": "application/vnd.github+json",
            "User-Agent": "James-Github-Playgrounds",
            "Authorization": "Bearer " + accessToken(),
        ]
    }

    public static func date(from string: String) -> Date? {
        ISO8601DateFormatter().date(from: string)
    }

}
