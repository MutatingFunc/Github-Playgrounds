import SwiftUI
import ComposableArchitecture

struct UserListRowView: View {
    var store: StoreOf<UserListRow>
    
    var body: some View {
        HStack {
            AvatarView(avatar: store.loadedAvatar, imageSize: 48)
            Text(store.user.username)
                .font(.title)
        }.task {
            store.send(.loadAvatar)
        }
    }
}

#Preview {
    let store = StoreOf<UserListRow>(initialState: .init()) {
        UserListRow()
    }
    return List {
        UserListRowView(store: store)
    }
}
