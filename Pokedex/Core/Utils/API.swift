import Foundation

/// Enum that centralizes PokéAPI configurations and URLs
///
/// This structure organizes all constants related to the external API,
/// facilitating maintenance and avoiding hardcoded URLs throughout the code.
enum API {
    /// Base URL for PokéAPI v2
    static let baseURL = "https://pokeapi.co/api/v2"
    
    /// Endpoint for fetching Pokémon list
    static let pokemon = baseURL + "/pokemon"
    
    /// Generates URL for a specific Pokémon image
    ///
    /// - Parameter id: Pokémon numeric ID
    /// - Returns: Optional URL for the Pokémon image
    static func pokemonImageURL(id: Int) -> URL? {
        URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/\(id).png")
    }
}
