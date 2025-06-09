import SwiftUI

@main
struct PokedexApp: App {
    @StateObject private var router = Router()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navigationPath) {
                // Start directly with PokedexView as the root view
                NavigationFactory.createView(for: .pokedex)
                    .navigationDestination(for: AppDestination.self) { destination in
                        NavigationFactory.createView(for: destination)
                    }
            }
            .environmentObject(router)
        }
    }
}
