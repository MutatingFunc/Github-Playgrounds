import SwiftUI
import ComposableArchitecture

struct UserDetailsView: View {
    @Bindable var store: StoreOf<UserDetails>
    
    var body: some View {
            VStack(spacing: 0) {
                HStack {
                    AvatarView(avatar: store.loadedAvatar, imageSize: 64)
                        .accessibilityHidden(true)
                    Group {
                        if let error = store.detailsLoadError {
                            ErrorView(description: "Error loading user details", error: error)
                        } else {
                            Group {
                                if let fullName = store.user.details?.fullName {
                                    Text(fullName)
                                } else {
                                    Text("Anonymous")
                                        .redacted(reason: .placeholder)
                                }
                            }
                            .font(.title)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .accessibilityIdentifier("Full Name")
                            .userStats(
                                following: store.user.details?.followingCount,
                                followers: store.user.details?.followersCount
                            )
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()
                .background(.bar, ignoresSafeAreaEdges: .all)
                Divider().edgesIgnoringSafeArea(.all)
                List {
                    Section {
                        ForEach(store.scope(state: \.rows, action: \.repoRow)) { store in
                            RepoRowView(store: store)
                        }
                        if store.isLoadingRepos {
                            ProgressView("Loading…")
                                .frame(maxWidth: .infinity)
                        }
                    } header: {
                        if let error = store.reposLoadError {
                            ErrorView(description: "Error loading repositories", error: error)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color(uiColor: .systemGroupedBackground))
                        }
                    }.headerProminence(.standard)
                }
            }
            .navigationTitle(store.user.username)
            .navigationBarTitleDisplayMode(.inline)
            .task(id: store.user.id) {
                store.send(.loadDetails)
                store.send(.loadRepos)
            }
    }
}

#Preview {
    let store = Store(initialState: .init(user: .init(.preview()), loadedAvatar: nil)) {
        UserDetails()
    }
    return NavigationStack {
        UserDetailsView(store: store)
    }
}

#Preview("With Error") {
    let store = Store(
        initialState: .init(
            user: .init(.preview()),
            reposLoadError: CocoaError(.fileNoSuchFile),
            detailsLoadError: CocoaError(.fileNoSuchFile),
            loadedAvatar: nil
        )
    ) {
        UserDetails()
    }
    return NavigationStack {
        UserDetailsView(store: store)
    }
}
