import XCTest
import ComposableArchitecture
@testable import Github_Playgrounds

final class UserListTests: XCTestCase {
    
    // Can't use TestStore as State contains non-Equatable Error values.
    // Regular-style unit testing is required.
    var store: StoreOf<UserList>!
    
    override func setUp() {
        store = StoreOf<UserList>(initialState: .init(users: [User]())) {
            UserList()
        }
    }
    
    func testLoad() {
        XCTAssertEqual(store.rows.count, 0)
        
        store.send(.loadedUsers([.preview()], nextPage: Page(url: URL(string: "about:blank")!)))
        XCTAssertEqual(store.rows.count, 1)
        XCTAssertFalse(store.reachedEnd)
        
        store.send(.loadedUsers([.preview()], nextPage: nil))
        XCTAssertEqual(store.rows.count, 2)
        XCTAssertTrue(store.reachedEnd)
    }
    
    func testLoadFailure() {
        XCTAssertNil(store.loadError)
        store.send(.gotError(CocoaError(.fileNoSuchFile)))
        XCTAssertNotNil(store.loadError)
        store.send(.loadPage)
        XCTAssertNil(store.loadError)
    }
}
