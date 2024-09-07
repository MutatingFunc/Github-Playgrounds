import SwiftUI
import ComposableArchitecture

struct UserListRowView: View {
    var store: StoreOf<UserListRow>
    
    var body: some View {
        NavigationLink(
            state: Window.Path.State.showUser(store.userDetails)
        ) {
            AvatarView(avatar: store.loadedAvatar, imageSize: 48)
            Text(store.user.username)
                .font(.title)
        }.task {
            store.send(.loadAvatar)
        }
    }
}

#Preview {
    let store = StoreOf<UserListRow>(initialState: .init(user: .preview())) {
        UserListRow()
    }
    return List {
        UserListRowView(store: store)
    }
}
