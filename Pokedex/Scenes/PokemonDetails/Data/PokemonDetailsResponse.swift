import Foundation

/// Model that represents the API response when fetching Pokémon details
///
/// This struct directly maps the JSON structure returned by PokéAPI
/// when we make a request to get the Pokémon details
struct PokemonDetailsResponse: Decodable {
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

/// This struct defines a Pokémon statistic
struct StatResource: Decodable, Equatable {
    let baseStat: Int
    let stat: NameAPIResource
}

/// This struct defines the Pokémon ability
struct AbilityResource: Decodable, Equatable {
    let ability: NameAPIResource
}

/// This struct defines the Pokémon type
struct TypeResource: Decodable, Equatable {
    let type: NameAPIResource
}

/// This struct is a simple struct with a name that is re-used for Stat, Ability and Type
struct NameAPIResource: Decodable, Equatable {
    let name: String
}
