import SwiftUI
import ComposableArchitecture

@Reducer
struct Window {
    @ObservableState
    struct State {
        var userList: PageLoader<UserList>.State = .init()
        
        var columnVisibility: NavigationSplitViewVisibility = .automatic
        
        @Presents var selectedUser: UserDetails.State? = nil
        @Presents var selectedRepo: WebContent.State? = nil
    }
    
    enum Action {
        case userList(PageLoader<UserList>.Action)
        case columnVisibilityChanged(NavigationSplitViewVisibility)
        case resetColumns
        
        case selectedUser(PresentationAction<UserDetails.Action>)
        case selectedRepo(PresentationAction<WebContent.Action>)
    }
    
    @Dependency(\.github) private var github
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .userList(.success(.rows(.element(id: let id, action: .select)))):
                state.selectedUser = state.userList.success?.rows[id: id]?.userDetails
                state.selectedRepo = nil
                
                // Workaround for TCA not dismissing primary column on row selection.
                // NavigationLink does this automatically, but I can't use it with TCA.
                state.columnVisibility = .detailOnly
                return .run { send in
                    await send(.resetColumns)
                }
            case .resetColumns:
                state.columnVisibility = .automatic
                
            case .selectedUser(.presented(.repoRow(.element(id: let id, action: .open)))):
                state.selectedRepo = state.selectedUser?.rows[id: id]?.webContent
            case .columnVisibilityChanged(let newValue):
                state.columnVisibility = newValue
            case .userList, .selectedUser, .selectedRepo:
                break
            }
            return .none
        }
        .ifLet(\.$selectedUser, action: \.selectedUser) {
            UserDetails()
        }
        .ifLet(\.$selectedRepo, action: \.selectedRepo) {
            WebContent()
        }
        Scope(state: \.userList, action: \.userList) {
            PageLoader(success: UserList()) {
                .init(users: try await github.users())
            }
        }
    }
    
}

