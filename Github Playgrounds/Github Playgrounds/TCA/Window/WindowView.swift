import SwiftUI
import ComposableArchitecture

struct WindowView: View {
    @Bindable var store: StoreOf<Window>
    
    var body: some View {
        NavigationSplitView {
            PageLoaderView(store: store.scope(state: \.userList, action: \.userList)) { store in
                UserListView(store: store)
                    .navigationDestination(item: $store.scope(state: \.selectedUser, action: \.selectedUser)) { store in
                        UserDetailsView(store: store)
                            .id(store.user.id)
                            .navigationDestination(item: $store.scope(state: \.selectedRepo, action: \.selectedRepo)) { store in
                                WebContentView(store: store)
                            }
                    }
            }
        } detail: {
            NavigationStack {
                Text("No selection")
            }
        }
    }
}

#Preview {
    let store = Store(initialState: .init()) {
        Window()
    }
    return WindowView(store: store)
}
