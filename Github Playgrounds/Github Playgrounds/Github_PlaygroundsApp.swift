import SwiftUI
import ComposableArchitecture

@main
struct Github_PlaygroundsApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                WindowView(
                    store: .init(initialState: .init()) {
                        Window()
                    }
                )
            }
        }
    }
}
