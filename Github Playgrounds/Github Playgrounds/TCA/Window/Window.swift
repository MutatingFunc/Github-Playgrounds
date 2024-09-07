import SwiftUI
import ComposableArchitecture

@Reducer
struct Window {
    @ObservableState
    struct State {
        var userList: PageLoader<UserList>.State = .init()
    }
    
    enum Action {
        case userList(PageLoader<UserList>.Action)
    }
    
    @Dependency(\.github) private var github
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .userList:
                break
            }
            return .none
        }
        Scope(state: \.userList, action: \.userList) {
            PageLoader(success: UserList()) {
                .init(users: try await github.users())
            }
        }
    }
}

