import SwiftUI

struct ErrorView: View {
    var description: LocalizedStringKey
    var error: Error
    
    var body: some View {
        GroupBox(description) {
#if DEBUG
            Text("\(error)")
#else
            Text(error.localizedDescription)
#endif
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

#Preview {
    ErrorView(description: "Test", error: CocoaError(.fileNoSuchFile))
}
