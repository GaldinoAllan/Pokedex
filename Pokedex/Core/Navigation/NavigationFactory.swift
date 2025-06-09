import SwiftUI

/// Factory responsible for creating views based on navigation destinations
/// 
/// This struct centralizes view creation logic, making it easier to manage
/// dependencies and ensure consistent view initialization
struct NavigationFactory {
    
    /// Creates a view for the given destination
    /// 
    /// - Parameter destination: The destination to create a view for
    /// - Returns: A view corresponding to the destination
    @ViewBuilder
    static func createView(for destination: AppDestination) -> some View {
        switch destination {
        case .pokedex:
            PokedexView()
        }
    }
}
