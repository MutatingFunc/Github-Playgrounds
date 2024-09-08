import SwiftUI
import ComposableArchitecture

@Reducer
struct UserDetails {
    @ObservableState
    struct State: Identifiable {
        @Shared var user: User
        var isLoadingRepos = false
        var rows: IdentifiedArrayOf<RepoRow.State> = []
        var reposLoadError: Error? = nil
        var detailsLoadError: Error? = nil
        var loadedAvatar: Result<Image, Error>?
        
        var id: User.ID { user.id }
    }
    
    enum Action {
        case loadDetails
        case loadedDetails(Result<User.Details, Error>)
        case loadRepos
        case loadedRepos(Result<[User.Repository], Error>)
        case repoRow(IdentifiedActionOf<RepoRow>)
    }
    
    @Dependency(\.github) private var github
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            case .loadDetails:
                guard state.user.details == nil else { return .none }
                state.isLoadingRepos = true
                return .run { [user = state.user] send in
                    let details = await Task {
                        try await github.details(for: user)
                    }.result
                    await send(.loadedDetails(details))
                }
            case .loadedDetails(.success(let details)):
                state.user.details = details
                state.isLoadingRepos = false
            case .loadedDetails(.failure(let error)):
                state.detailsLoadError = error
                state.isLoadingRepos = false
                
            case .loadRepos:
                guard state.user.repos.isEmpty else {
                    return .run { [repos = state.user.repos] send in
                        await send(.loadedRepos(.success(repos)))
                    }
                }
                return .run { [user = state.user] send in
                    let repos = await Task {
                        try await github.repos(for: user)
                    }.result
                    await send(.loadedRepos(repos))
                }
            case .loadedRepos(.success(let repos)):
                state.user.repos = repos
                state.rows = IdentifiedArray(
                    uniqueElements: repos.map { repo in
                        RepoRow.State(repo: repo)
                    }
                )
            case .loadedRepos(.failure(let error)):
                state.reposLoadError = error
                
            case .repoRow:
                break
                
            }
            return .none
        }.forEach(\.rows, action: \.repoRow) {
            RepoRow()
        }
    }
}

