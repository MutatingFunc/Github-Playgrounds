import SwiftUI
import ComposableArchitecture

struct UserListView: View {
    var store: StoreOf<UserList>
    
    var body: some View {
        List {
            ForEach(store.scope(state: \.rows, action: \.rows)) { store in
                UserListRowView(store: store)
            }
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
