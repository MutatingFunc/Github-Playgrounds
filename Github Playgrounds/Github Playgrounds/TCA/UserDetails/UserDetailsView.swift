import SwiftUI
import ComposableArchitecture
import Tooltips
import GithubModels

struct UserDetailsView: View {
    @Bindable var store: StoreOf<UserDetails>
    
    var body: some View {
            VStack(spacing: 0) {
                HStack {
                    AvatarView(avatar: store.loadedAvatar, imageSize: 64)
                        .accessibilityHidden(true)
                    Group {
                        if let error = store.detailsLoadError {
                            ErrorView(description: "Failed to load user details", error: error) {
                                store.send(.loadDetails)
                            }
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
                        if !store.reachedReposEnd && store.detailsLoadError == nil {
                            ProgressView("Loading…")
                                .frame(maxWidth: .infinity)
                                .task {
                                    store.send(.loadReposPage)
                                }
                        }
                    } footer: {
                        if let error = store.reposLoadError {
                            ErrorView(description: "Failed to load repositories", error: error) {
                                store.send(.loadReposPage)
                            }
                            .padding(.horizontal)
                        }
                    }.headerProminence(.standard)
                }
            }
            .navigationTitle(store.user.username)
            .navigationBarTitleDisplayMode(.inline)
            .task(id: store.user.id) {
                store.send(.loadDetails)
            }
    }
}

#Preview {
    let store = Store(
        initialState: .init(
            user: .init(.preview()),
            repos: (0...100).map { _ in .preview() }
        )
    ) {
        UserDetails()
    }
    return NavigationStack {
        UserDetailsView(store: store)
    }
}

#Preview("With Error") {
    let store = Store(
        initialState: .init(
            user: .init(.preview(details: nil))
        )
    ) {
        UserDetails()
    } withDependencies: { dependencies in
        dependencies.github = GithubPreview(error: CocoaError(.fileNoSuchFile))
    }
    return NavigationStack {
        UserDetailsView(store: store)
    }.tooltipHost()
}
