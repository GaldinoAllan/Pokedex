import Foundation

/// Enum that defines all possible destinations in the app
/// 
/// This enum centralizes all navigation destinations, making it easier
/// to manage navigation and ensure type safety
enum AppDestination: Hashable {
    /// Navigate to main Pokedex Screen
    case pokedex
    
    // Other destinations can be added here:
    // case pokemonDetails
    // case favorites
}

// MARK: - Hashable Implementation
extension AppDestination {
    func hash(into hasher: inout Hasher) {
        switch self {
        case .pokedex:
            hasher.combine("pokedex")
        }
    }
}
