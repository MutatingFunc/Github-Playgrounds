import XCTest
import ComposableArchitecture
import SnapshotTesting
import SwiftUI
import GithubModels
@testable import Github_Playgrounds

final class UserListSnapshotTests: XCTestCase {
    
    func testUserListView() {
        let store = Store(initialState: .init(users: (0...100).map { _ in User.preview() })) {
            UserList()
        }
        let view = NavigationStack {
            UserListView(store: store)
        }
        assertSnapshotOnDefaultDevices(view)
    }
}
