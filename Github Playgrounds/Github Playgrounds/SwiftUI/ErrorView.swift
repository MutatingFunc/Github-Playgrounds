import SwiftUI

struct ErrorView: View {
    var description: LocalizedStringKey
    var error: Error
    var retry: (() -> ())?
    
    var body: some View {
        GroupBox(description) {
            VStack(alignment: .leading) {
#if DEBUG
                Text("\(error)")
#else
                Text(error.localizedDescription)
#endif
                if let retry {
                    HStack {
                        Spacer()
                        Button {
                            retry()
                        } label: {
                            Spacer()
                            Text("Retry")
                            Spacer()
                        }
                        .buttonStyle(.bordered)
                        .foregroundStyle(.foreground)
                    }
                }
            }
        }.groupBoxStyle(ErrorGroupBoxStyle())
    }
}

struct ErrorGroupBoxStyle: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading) {
            configuration.label
                .bold()
            configuration.content
        }
        .multilineTextAlignment(.leading)
        .padding()
        .background(.red.gradient.secondary)
        .cornerRadius(8)
    }
}

#Preview("Retry") {
    ErrorView(description: "Test", error: CocoaError(.fileNoSuchFile)) {
        // Retry
    }
}

#Preview("No retry") {
    ErrorView(description: "Test", error: CocoaError(.fileNoSuchFile))
}
