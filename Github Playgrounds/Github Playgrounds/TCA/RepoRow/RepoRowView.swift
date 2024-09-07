import SwiftUI
import ComposableArchitecture

struct RepoRowView: View {
    var store: StoreOf<RepoRow>
    
    var body: some View {
        let visual = VStack(alignment: .leading) {
            Group {
                let title = Group {
                    Text(store.repo.name)
                    if let language = store.repo.language {
                        Text(language)
                            .font(.caption)
                            .padding(2)
                            .padding(.horizontal, 4)
                            .background(.orange.tertiary)
                            .cornerRadius(8)
                    }
                }
                ViewThatFits(in: .horizontal) {
                    HStack {
                        title
                    }
                    VStack(alignment: .leading) {
                        title
                    }
                }
                if !store.repo.description.isEmpty {
                    Text(store.repo.description)
                        .foregroundStyle(.secondary)
                        .font(.caption)
                }
            }.frame(maxWidth: .infinity, alignment: .leading)
        }
            .accessibilityElement(children: .combine)
            .repoStats(
                stars: store.repo.starCount,
                watchers: store.repo.watcherCount,
                forks: store.repo.forkCount
            )
        Group {
            if let url = store.repo.url {
                Link(destination: url) {
                    HStack {
                        visual
                        Image(systemName: "arrow.up.right.square")
                            .accessibilityHidden(true)
                            .foregroundStyle(.tint)
                    }
                }
                .buttonStyle(.plain)
            } else {
                visual
            }
        }
    }
}

#Preview {
    let store = Store(initialState: .init(repo: .preview())) {
        RepoRow()
    }
    return List {
        RepoRowView(store: store)
    }
}
