import SwiftUI
import ComposableArchitecture

@Reducer
struct PageLoader<Success: Reducer> {
    @ObservableState
    enum State {
        case loading
        case failure(Error)
        case success(Success.State)
        
        init() {
            self = .loading
        }
    }
    
    enum Action {
        case refresh
        case gotResult(Result<Success.State, Error>)
        case success(Success.Action)
    }
    
    var success: Success
    var fetch: @Sendable () async throws -> Success.State
    init(success: Success, fetch: @Sendable @escaping () async throws -> Success.State) {
        self.success = success
        self.fetch = fetch
    }
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .refresh:
                state = .loading
                return .run { send in
                    let result = await Task(operation: fetch).result
                    await send(.gotResult(result))
                }
                
            case .gotResult(.success(let success)):
                state = .success(success)
                
            case .gotResult(.failure(let error)):
                state = .failure(error)
                
            case .success:
                break
            }
            return .none
        }.ifCaseLet(\.success, action: \.success) {
            success
        }
    }
}
