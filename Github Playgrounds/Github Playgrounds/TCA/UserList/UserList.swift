import SwiftUI
import ComposableArchitecture

@Reducer
struct UserList {
    @ObservableState
    struct State {
        var reachedEnd = false
        var nextPage: Page? = nil
        var loadError: Error? = nil
        var rows: IdentifiedArrayOf<UserListRow.State>
        init(users: [User]) {
            self.rows = IdentifiedArray(
                uniqueElements: users.map { user in UserListRow.State(user: user) }
            )
        }
    }
    
    enum Action {
        case loadPage
        case loadedUsers([User], nextPage: Page?)
        case gotError(Error)
        case rows(IdentifiedActionOf<UserListRow>)
    }
    
    @Dependency(\.github) private var github
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .loadPage:
                state.loadError = nil
                if !state.reachedEnd {
                    return .run { [nextPage = state.nextPage] send in
                        do {
                            let (users, nextPage) = try await github.users(page: nextPage)
                            await send(.loadedUsers(users, nextPage: nextPage))
                        } catch {
                            await send(.gotError(error))
                        }
                    }
                }
            case .loadedUsers(let users, nextPage: let nextPage):
                state.rows.append(
                    contentsOf: users.map { .init(user: $0) }
                )
                state.nextPage = nextPage
                if nextPage == nil {
                    state.reachedEnd = true
                }
            case .gotError(let error):
                state.loadError = error
            case .rows:
                break
            }
            return .none
        }.forEach(\.rows, action: \.rows) {
            UserListRow()
        }
    }
}
