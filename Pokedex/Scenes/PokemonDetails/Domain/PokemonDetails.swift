import Foundation

/// Entity that represents the details of a Pokémon in the application domain
///
/// This struct defines the internal representation of a Pokémon
/// independent of how the data is obtained from the API
/// Conforms to Equatable for testing
struct PokemonDetails: Decodable, Equatable {
    /// Unique identifier of the Pokémon (Pokédex number)
    let id: Int
    
    /// Pokémon abilities
    let abilities: [AbilityResource]
    
    /// Pokémon name
    let name: String
    
    /// Pokémon height
    let height: Int
    
    /// Pokémon weight
    let weight: Int
    
    /// Pokémon array of types
    let types: [TypeResource]
    
    /// Pokémon array of statistics
    let stats: [StatResource]
}
