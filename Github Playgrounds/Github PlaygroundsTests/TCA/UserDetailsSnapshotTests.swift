import XCTest
import ComposableArchitecture
import SnapshotTesting
import SwiftUI
@testable import Github_Playgrounds

final class UserDetailsSnapshotTests: XCTestCase {
    
    func testUserDetailsView() {
        let store = Store(
            initialState: .init(
                user: .init(.preview()),
                repos: (0...100).map { _ in .preview() }
            )
        ) {
            UserDetails()
        }
        let view = NavigationStack {
            UserDetailsView(store: store)
        }
        assertSnapshotOnDefaultDevices(view)
    }
    
    func testUserDetailsView_Loading() {
        let store = Store(
            initialState: .init(
                user: .init(.preview())
            )
        ) {
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
                user: .init(.preview(details: nil)),
                detailsLoadError: CocoaError(.fileNoSuchFile),
                reposLoadError: CocoaError(.fileNoSuchFile)
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
