import Foundation

/// Model that represents the API response when fetching Pokémon list
///
/// This struct directly maps the JSON structure returned by PokéAPI
/// when we make a request to list Pokémon with pagination
struct PokedexResponse: Decodable {
    /// Array of results containing the Pokémon information from the PokeAPI
    let results: [PokemonResult]
}

/// Model that represents an individual Pokémon in the Pokémon list as it comes from the PokeAPI
struct PokemonResult: Decodable {
    let name: String
    let url: String
}
