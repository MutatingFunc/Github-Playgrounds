import XCTest
import ComposableArchitecture
import SnapshotTesting
import SwiftUI
@testable import Github_Playgrounds

final class UserDetailsSnapshotTests: XCTestCase {
    
    func testUserDetailsView() {
        let user: User = .preview()
        let store = Store(initialState: .init(user: .init(user), loadedAvatar: nil)) {
            UserDetails()
        }
        let view = NavigationStack {
            UserDetailsView(store: store)
        }
        store.send(.loadedRepos(.success(user.repos)))
        assertSnapshotOnDefaultDevices(view)
    }
    
    func testUserDetailsView_Loading() {
        let store = Store(initialState: .init(user: .init(.preview()), loadedAvatar: nil)) {
            UserDetails()
        }
        let view = NavigationStack {
            UserDetailsView(store: store)
        }
        assertSnapshotOnDefaultDevices(view)
    }
    
    func testUserDetailsView_Errors() {
        let store = Store(
            initialState: .init(
                user: .init(.preview()),
                reposLoadError: CocoaError(.fileNoSuchFile),
                detailsLoadError: CocoaError(.fileNoSuchFile),
                loadedAvatar: nil
            )
        ) {
            UserDetails()
        }
        let view = NavigationStack {
            UserDetailsView(store: store)
        }
        assertSnapshotOnDefaultDevices(view)
    }
}
