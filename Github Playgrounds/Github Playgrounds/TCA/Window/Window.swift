import SwiftUI
import ComposableArchitecture

@Reducer
struct Window {
    @ObservableState
    struct State {
        var path = StackState<Path.State>()
        
        var userList: PageLoader<UserList>.State = .init()
    }
    
    @Reducer
    enum Path {
      case showUser(UserDetails)
    }
    
    enum Action {
        case userList(PageLoader<UserList>.Action)
        case path(StackActionOf<Path>)
    }
    
    @Dependency(\.github) private var github
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .userList:
                break
            case .path:
                break
            }
            return .none
        }
        .forEach(\.path, action: \.path)
        Scope(state: \.userList, action: \.userList) {
            PageLoader(success: UserList()) {
                .init(users: try await github.users())
            }
        }
    }
}

