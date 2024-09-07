import SwiftUI
import ComposableArchitecture

@Reducer
struct UserDetails {
    @ObservableState
    struct State {
        var user: User = .preview()
        var detailsLoadError: Error? = nil
        var reposLoadError: Error? = nil
        @Shared var loadedAvatar: Result<Image, Error>?
    }
    
    enum Action {
        case loadDetails
        case loadedDetails(Result<User.Details, Error>)
        case loadRepos
        case loadedRepos(Result<[User.Repository], Error>)
    }
    
    @Dependency(\.github) private var github
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            case .loadDetails:
                return .run { [user = state.user] send in
                    let details = await Task {
                        try await github.details(for: user)
                    }.result
                    await send(.loadedDetails(details))
                }
            case .loadedDetails(.success(let details)):
                state.user.details = details
            case .loadedDetails(.failure(let error)):
                state.detailsLoadError = error
                
            case .loadRepos:
                return .run { [user = state.user] send in
                    let repos = await Task {
                        try await github.repos(for: user)
                    }.result
                    await send(.loadedRepos(repos))
                }
            case .loadedRepos(.success(let repos)):
                state.user.repos = repos
            case .loadedRepos(.failure(let error)):
                state.reposLoadError = error
                
            }
            return .none
        }
    }
}

