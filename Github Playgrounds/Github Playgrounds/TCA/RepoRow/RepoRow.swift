import SwiftUI
import ComposableArchitecture
import GithubModels

@Reducer
struct RepoRow {
    @ObservableState
    struct State: Identifiable {
        var repo: User.Repository
        var id: User.Repository.ID { repo.id }
        
        var webContent: WebContent.State? { repo.url.map { .init(url: $0) } }
    }
    
    enum Action {
        case open
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .open:
                break
            }
            return .none
        }
    }
}

