import SwiftUI
import ComposableArchitecture

@Reducer
struct UserList {
    @ObservableState
    struct State {
        var rows: IdentifiedArrayOf<UserListRow.State>
        init(users: [User]) {
            self.rows = IdentifiedArray(
                uniqueElements: users.map { user in UserListRow.State(user: .init(user)) }
            )
        }
    }
    
    enum Action {
        case rows(IdentifiedActionOf<UserListRow>)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .rows:
                break
            }
            return .none
        }.forEach(\.rows, action: \.rows) {
            UserListRow()
        }
    }
}
