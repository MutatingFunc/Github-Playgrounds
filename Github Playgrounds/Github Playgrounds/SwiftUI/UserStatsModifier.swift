import SwiftUI

extension View {
    func userStats(following: Int?, followers: Int?) -> some View {
        self.modifier(UserStatsModifier(following: following, followers: followers))
    }
}

private struct UserStatsModifier: ViewModifier {
    var following: Int?
    var followers: Int?
    
    func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            content
            
            let extras = Group {
                if let followers {
                    Text("\(followers) followers")
                } else {
                    Text("000 followers")
                        .redacted(reason: .placeholder)
                }
                if let following {
                    Text("\(following) followed")
                } else {
                    Text("000 followed")
                        .redacted(reason: .placeholder)
                }
            }
            .font(.callout)
            .accessibilityHidden(true)
            .multilineTextAlignment(.leading)
            
            ViewThatFits(in: .horizontal) {
                HStack {
                    extras
                }
                VStack {
                    extras
                }
            }
        }
        .accessibilityCustomContent("Followers", followers.map { String($0) } ?? "Loading…")
        .accessibilityCustomContent("followed", following.map { String($0) } ?? "Loading…")
    }
}

#Preview {
    Text("Hello world")
        .userStats(following: 42, followers: 42)
}
