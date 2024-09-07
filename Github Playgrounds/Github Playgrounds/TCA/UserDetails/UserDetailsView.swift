import SwiftUI
import ComposableArchitecture

struct UserDetailsView: View {
    var store: StoreOf<UserDetails>
    
    var body: some View {
        let details = store.user.details
        List {
            ForEach(store.repos) { store in
                RepoRow(store)
            }
        }.safeAreaInset(edge: .top) {
            VStack(spacing: 0) {
                HStack {
                    AvatarView(avatar: store.loadedAvatar, imageSize: 64)
                    VStack(alignment: .leading) {
                        Group {
                            if let fullName = details?.fullName {
                                Text(fullName)
                            } else {
                                Text("Anonymous")
                                    .redacted(reason: .placeholder)
                            }
                        }
                        .font(.title)
                        HStack {
                            if let followCount = details?.followCount {
                                Text("\(followCount) following")
                            } else {
                                Text("000 following")
                                    .redacted(reason: .placeholder)
                            }
                            if let followerCount = details?.followerCount {
                                Text("\(followerCount) followers")
                            } else {
                                Text("000 followers")
                                    .redacted(reason: .placeholder)
                            }
                        }.font(.callout)
                    }
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()
                .background(.regularMaterial, ignoresSafeAreaEdges: .all)
                Divider().edgesIgnoringSafeArea(.all)
            }
        }.navigationTitle(store.user.username)
    }
}

#Preview {
    let store = Store(initialState: .init(loadedAvatar: .init(nil))) {
        UserDetails()
    }
    return NavigationStack {
        UserDetailsView(store: store)
    }
}
