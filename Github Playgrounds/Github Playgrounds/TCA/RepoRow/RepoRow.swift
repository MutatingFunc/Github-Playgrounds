import SwiftUI
import ComposableArchitecture

@Reducer
struct RepoRow {
    @ObservableState
    struct State: Identifiable {
        var repo: User.Repository
        var id: User.Repository.ID { repo.id }
    }
    
    enum Action {
        case open
    }
    
    @Dependency(\.openURL) private var openURL
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .open:
                if let url = state.repo.url {
                    return .run { send in
                        await openURL(url)
                    }
                } else {
                    // TODO
                }
            }
            return .none
        }
    }
}

