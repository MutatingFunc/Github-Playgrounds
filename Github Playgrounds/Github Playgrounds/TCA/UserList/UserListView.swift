import SwiftUI
import ComposableArchitecture
import GithubModels

struct UserListView: View {
    var store: StoreOf<UserList>
    
    var body: some View {
        List {
            Section {
                ForEach(store.scope(state: \.rows, action: \.rows)) { store in
                    UserListRowView(store: store)
                }
                if !store.reachedEnd && store.loadError == nil {
                    ProgressView("Loading…")
                        .frame(maxWidth: .infinity)
                        .task {
                            store.send(.loadPage)
                        }
                }
            } footer: {
                if let error = store.loadError {
                    ErrorView(description: "Error loading users", error: error) {
                        store.send(.loadPage)
                    }.padding(.horizontal)
                }
            }.headerProminence(.standard)
        }.navigationTitle("Users")
    }
}

#Preview {
    let store = Store(initialState: .init(users: (0...100).map { _ in User.preview() })) {
        UserList()
    }
    return NavigationStack {
        UserListView(store: store)
    }
}
