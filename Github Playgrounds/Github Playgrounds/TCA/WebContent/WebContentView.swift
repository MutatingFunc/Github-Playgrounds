import SwiftUI
import ComposableArchitecture

struct WebContentView: View {
    var store: StoreOf<WebContent>
    
    var body: some View {
        SafariVC(url: store.url)
            .ignoresSafeArea(.all)
            .toolbar(.hidden, for: .navigationBar)
    }
}
