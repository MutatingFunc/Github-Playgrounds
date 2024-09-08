import SwiftUI
import ComposableArchitecture
import GithubModels

@Reducer
struct UserDetails {
    @ObservableState
    struct State: Identifiable {
        @Shared var user: User
        var detailsLoadError: Error?
        var loadedAvatar: Result<Image, Error>?
        
        var reachedReposEnd: Bool
        var nextReposPage: GithubPage?
        var reposLoadError: Error?
        var rows: IdentifiedArrayOf<RepoRow.State>
        
        var id: User.ID { user.id }
        
        init(
            user: Shared<User>,
            detailsLoadError: Error? = nil,
            loadedAvatar: Result<Image, Error>? = nil,
            reachedReposEnd: Bool = false,
            nextReposPage: GithubPage? = nil,
            reposLoadError: Error? = nil,
            repos: [User.Repository] = []
        ) {
            self._user = user
            self.detailsLoadError = detailsLoadError
            self.loadedAvatar = loadedAvatar
            self.reachedReposEnd = reachedReposEnd
            self.nextReposPage = nextReposPage
            self.reposLoadError = reposLoadError
            self.rows = IdentifiedArray(uniqueElements: repos.map { repo in
                RepoRow.State(repo: repo)
            })
        }
    }
    
    enum Action {
        case loadDetails
        case loadedDetails(Result<User.Details, Error>)
        case loadReposPage
        case loadedRepos([User.Repository], nextPage: GithubPage?)
        case gotReposError(Error)
        case repoRow(IdentifiedActionOf<RepoRow>)
    }
    
    @Dependency(\.github) private var github
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            case .loadDetails:
                state.detailsLoadError = nil
                if state.user.details == nil {
                    return .run { [user = state.user] send in
                        let details = await Task {
                            try await github.details(for: user)
                        }.result
                        await send(.loadedDetails(details))
                    }
                }
            case .loadedDetails(.success(let details)):
                state.user.details = details
            case .loadedDetails(.failure(let error)):
                state.detailsLoadError = error
                
            case .loadReposPage:
                state.reposLoadError = nil
                if !state.reachedReposEnd {
                    return .run { [user = state.user, nextPage = state.nextReposPage] send in
                        do {
                            let (repos, nextPage) = try await github.repos(for: user, page: nextPage)
                            await send(.loadedRepos(repos, nextPage: nextPage))
                        } catch {
                            await send(.gotReposError(error))
                        }
                    }
                }
            case .loadedRepos(let repos, nextPage: let nextPage):
                state.rows.append(
                    contentsOf: repos.map { repo in
                        RepoRow.State(repo: repo)
                    }
                )
                state.nextReposPage = nextPage
                if nextPage == nil {
                    state.reachedReposEnd = true
                }
            case .gotReposError(let error):
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

