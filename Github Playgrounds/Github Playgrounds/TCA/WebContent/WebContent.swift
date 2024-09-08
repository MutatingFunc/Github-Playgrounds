import SwiftUI
import ComposableArchitecture

@Reducer
struct WebContent {
    @ObservableState
    struct State {
        var url: URL
    }
    enum Action {
        case close
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .close:
                break
            }
            return .none
        }
    }
}
