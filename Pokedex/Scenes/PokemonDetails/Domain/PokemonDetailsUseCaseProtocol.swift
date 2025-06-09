import Foundation

/// Protocol that defines the use case for fetching the Pokémon Details
///
/// This protocol implements the Use Case pattern from Clean Architecture,
/// encapsulating a specific business rule: fetching Pokémon Details
protocol PokemonDetailsUseCaseProtocol {
    /// Executes the Pokémon fetch with pagination
    ///
    /// - Parameters:
    ///   - id: ID of the selected Pokemon
    /// - Returns: Result containing either Pokemon Details or ApiError
    func execute(id: Int) async -> Result<PokemonDetails, ApiError>
}
