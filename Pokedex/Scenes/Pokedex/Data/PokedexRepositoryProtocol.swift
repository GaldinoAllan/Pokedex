import Foundation

/// Protocol that defines the interface for Pokémon list related operations
///
/// This protocol follows the Repository pattern, abstracting the data source
/// and allowing different implementations (API, local database, cache, etc.)
protocol PokedexRepositoryProtocol {
    /// Fetches a list of Pokémon with pagination
    ///
    /// - Parameters:
    ///   - offset: Number of items to skip (for pagination)
    ///   - limit: Maximum number of items to return
    /// - Returns: Array of Pokemon objects
    /// - Throws: Network or data processing errors
    ///
    /// - Note: Pokémon IDs are calculated based on offset + index + 1
    func fetchPokedex(offset: Int, limit: Int) async throws -> [Pokemon]
}
