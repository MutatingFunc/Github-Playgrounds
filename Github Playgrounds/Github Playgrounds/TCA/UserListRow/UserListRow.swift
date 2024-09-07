import SwiftUI
import ComposableArchitecture

@Reducer
struct UserListRow {
    @ObservableState
    struct State: Identifiable {
        var id: Int { user.id }
        var user: User = .preview()
        var loadedAvatar: Result<Image, Error>? = nil
    }
    
    enum Action {
        case loadAvatar
        case loadedAvatar(Result<Image, Error>)
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
            }
            return .none
        }
    }
}
