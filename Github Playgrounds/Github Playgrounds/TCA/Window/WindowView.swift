import SwiftUI
import ComposableArchitecture

struct WindowView: View {
    @Bindable var store: StoreOf<Window>
    
    var body: some View {
        NavigationStack(
            path: $store.scope(state: \.path, action: \.path)
        ) {
            PageLoaderView(store: store.scope(state: \.userList, action: \.userList)) { store in
                UserListView(store: store)
            }
        } destination: { store in
            switch store.case {
            case .showUser(let store):
                UserDetailsView(store: store)
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
