import SwiftUI
import ComposableArchitecture

struct UserListRowView: View {
    var store: StoreOf<UserListRow>
    
    var body: some View {
        Button {
            store.send(.select)
        } label: {
            HStack {
                AvatarView(avatar: store.loadedAvatar, imageSize: 48)
                Text(store.user.username)
                    .font(.title)
            }
        }.task(id: store.user.id) {
            store.send(.loadAvatar)
        }.buttonStyle(.plain)
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
