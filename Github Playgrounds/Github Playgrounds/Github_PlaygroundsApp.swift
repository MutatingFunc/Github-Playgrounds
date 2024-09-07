import SwiftUI
import ComposableArchitecture

@main
struct Github_PlaygroundsApp: App {
    var body: some Scene {
        WindowGroup {
            WindowView(
                store: .init(initialState: .init()) {
                    Window()
                }
            )
        }
    }
}
