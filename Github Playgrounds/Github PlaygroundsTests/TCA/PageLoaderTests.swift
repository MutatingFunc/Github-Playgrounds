import XCTest
import ComposableArchitecture
@testable import Github_Playgrounds

@Reducer
struct MockReducer {
    @ObservableState
    struct State: Equatable {}
}

final class PageLoaderTests: XCTestCase {
    
    // Can't use TestStore as State contains non-Equatable Error values.
    // Regular-style unit testing is required.
    var store: StoreOf<PageLoader<MockReducer>>!
    
    override func setUp() {
        store = StoreOf<PageLoader<MockReducer>>(initialState: .loading) {
            PageLoader(success: MockReducer()) {
                MockReducer.State()
            }
        }
    }
    
    func testLoadSuccess() {
        store.send(.gotResult(.success(.init())))
        XCTAssert(store.state.is(\.success))
        store.send(.refresh)
        XCTAssert(store.state.is(\.loading))
    }
    
    func testLoadFailure() {
        store.send(.gotResult(.failure(CocoaError(.fileNoSuchFile))))
        XCTAssert(store.state.is(\.failure))
        store.send(.refresh)
        XCTAssert(store.state.is(\.loading))
    }
}
