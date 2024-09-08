import SwiftUI
import ComposableArchitecture

@Reducer
struct UserListRow {
    @ObservableState
    struct State: Identifiable {
        var id: User.ID { user.id }
        var user: User { userDetails.user }
        var loadedAvatar: Result<Image, Error>? { userDetails.loadedAvatar }
        var userDetails: UserDetails.State
        init(user: User, loadedAvatar: Result<Image, Error>? = nil) {
            self.userDetails = .init(user: Shared(user), loadedAvatar: loadedAvatar, repos: [])
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
                state.userDetails.loadedAvatar = result
            case .select:
                break
            }
            return .none
        }
    }
}
