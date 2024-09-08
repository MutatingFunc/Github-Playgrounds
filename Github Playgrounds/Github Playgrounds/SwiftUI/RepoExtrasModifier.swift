import SwiftUI
import Tooltips

extension View {
    func repoStats(stars: Int, watchers: Int, forks: Int) -> some View {
        self.modifier(RepoStatsModifier(stars: stars, watchers: watchers, forks: forks))
    }
}

private struct RepoStatsModifier: ViewModifier {
    var stars: Int
    var watchers: Int
    var forks: Int
    
    func body(content: Content) -> some View {
        VStack {
            content
            
            let extras = Group {
                HStack {
                    Text("\(stars)")
                    Label("Stars", systemImage: "star.fill")
                }
                .foregroundStyle(.yellow)
                .tooltip("Stars")
                HStack {
                    Text("\(watchers)")
                    Label("Watchers", systemImage: "eyes")
                }
                .foregroundStyle(.blue)
                .tooltip("Watchers")
                HStack {
                    Text("\(forks)")
                    Label("Forks", systemImage: "tuningfork")
                }
                .foregroundStyle(.green)
                .tooltip("Forks")
            }
            .frame(maxWidth: .infinity)
            .labelStyle(.iconOnly)
            .font(.caption)
            .foregroundStyle(.secondary)
            .accessibilityHidden(true)
            
            ViewThatFits(in: .horizontal) {
                HStack {
                    extras
                }
                VStack {
                    extras
                }
            }
        }
        .accessibilityCustomContent("Stars", Text("\(stars)"), importance: .high)
        .accessibilityCustomContent("Watchers", "\(watchers)")
        .accessibilityCustomContent("Forks", "\(forks)")
    }
}

#Preview {
    List {
        Text("Hello world")
            .repoStats(stars: 42, watchers: 42, forks: 42)
    }
}
