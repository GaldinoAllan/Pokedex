import Foundation

/// Protocol that defines the use case for fetching the Pokedex
///
/// This protocol implements the Use Case pattern from Clean Architecture,
/// encapsulating a specific business rule: fetching Pokedex
protocol PokedexUseCaseProtocol {
    /// Executes the Pokedex fetch with pagination
    ///
    /// - Parameters:
    ///   - offset: Offset for pagination (how many to skip)
    ///   - limit: Maximum number of Pokémon to return
    /// - Returns: Result containing either Pokemon array or ApiError
    func execute(offset: Int, limit: Int) async -> Result<[Pokemon], ApiError>
}
