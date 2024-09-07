import SwiftUI
import ComposableArchitecture

@Reducer
struct UserListRow {
    @ObservableState
    struct State: Identifiable {
        var id: User.ID { user.id }
        var user: User
        var loadedAvatar: Result<Image, Error>?
        var userDetails: UserDetails.State {
            .init(user: user, loadedAvatar: loadedAvatar)
        }
    }
    
    enum Action {
        case loadAvatar
        case loadedAvatar(Result<Image, Error>)
        
        // Nav
        case select
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .loadAvatar:
                return .run { [user = state.user] send in
                    let loadedAvatar = await Task { try await user.avatar() }.result
                    await send(.loadedAvatar(loadedAvatar))
                }
            case .loadedAvatar(let result):
                state.loadedAvatar = result
            case .select:
                break
            }
            return .none
        }
    }
}
