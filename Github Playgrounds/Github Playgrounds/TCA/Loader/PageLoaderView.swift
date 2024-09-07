import SwiftUI
import ComposableArchitecture

struct PageLoaderView<Success: Reducer, Content: View>: View {
    var store: StoreOf<PageLoader<Success>>
    @ViewBuilder var content: (StoreOf<Success>) -> Content
    
    var body: some View {
        switch store.state {
        case .loading:
            ProgressView("Loading…")
                .task {
                    store.send(.refresh)
                }
        case .success:
            content(store.scope(state: \.success, action: \.success))
//                .refreshable {
//                    store.send(.refresh)
//                }
        case .failure(let error):
            ScrollView {
                Text("Load failed with error:\n\(error)")
                    .frame(alignment: .leading)
                    .multilineTextAlignment(.leading)
            }.safeAreaInset(edge: .bottom) {
                Button("Retry") {
                    store.send(.refresh)
                }.buttonStyle(.borderedProminent)
            }
        }
    }
}

#Preview {
    let store = Store(initialState: .init()) {
        PageLoader(success: UserList()) {
            .init(users: [User.preview()])
        }
    }
    return PageLoaderView(store: store) { users in
        Text("Loaded!")
    }
}
