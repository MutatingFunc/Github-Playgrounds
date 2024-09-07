import SwiftUI
import ComposableArchitecture

struct WindowView: View {
    var store: StoreOf<Window>
    
    var body: some View {
        PageLoaderView(store: store.scope(state: \.userList, action: \.userList)) { store in
            UserListView(store: store)
        }
    }
}

#Preview {
    let store = Store(initialState: .init()) {
        Window()
    }
    return WindowView(store: store)
}
