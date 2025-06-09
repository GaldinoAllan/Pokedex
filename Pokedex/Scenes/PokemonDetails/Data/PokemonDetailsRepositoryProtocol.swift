import Foundation

/// Protocol that defines the interface for Pokémon Details related operations
///
/// This protocol follows the Repository pattern, abstracting the data source
/// and allowing different implementations (API, local database, cache, etc.)
protocol PokemonDetailRepositoryProtocol {
    /// Fetches the selected Pokémon Details
    ///
    /// - Parameters:
    ///   - id: Pokemon ID
    /// - Returns: Object of Pokemon Details
    /// - Throws: Network or data processing errors
    func fetchPokemonDetails(id: Int) async throws -> PokemonDetails
}
