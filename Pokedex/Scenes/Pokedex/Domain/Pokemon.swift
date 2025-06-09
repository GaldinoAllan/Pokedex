import Foundation

/// Entity that represents a Pokémon in the application domain
///
/// This struct defines the internal representation of a Pokémon,
/// independent of how the data is obtained from the API
/// Conforms to Identifiable for use in SwiftUI lists
/// Conforms to Equatable for testing
struct Pokemon: Identifiable, Equatable {
    /// Unique identifier of the Pokémon (Pokédex number)
    let id: Int
    
    /// Pokémon name
    let name: String
    
    /// Computed URL for the Pokémon image
    ///
    /// - Returns: Optional URL for the image, based on the ID
    /// - Note: Uses the API utility function to generate the URL
    var imageURL: URL? { API.pokemonImageURL(id: id) }
}
