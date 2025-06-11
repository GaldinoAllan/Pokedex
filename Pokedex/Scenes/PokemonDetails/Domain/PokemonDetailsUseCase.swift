import Foundation

/// Default implementation of the FetchPokemonDetailsUseCaseProtocol
///
/// This class coordinates the execution of the business rule to fetch Pokémon Details,
/// delegating the actual operation to the appropriate repository
final class PokemonDetailsUseCase: PokemonDetailsUseCaseProtocol {
    private let repository: PokemonDetailRepositoryProtocol
    
    init(repository: PokemonDetailRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(id: Int) async -> Result<PokemonDetails, ApiError> {
        do {
            let pokemonDetails = try await repository.fetchPokemonDetails(id: id)
            return .success(pokemonDetails)
        } catch let error as ApiError {
            return .failure(error)
        } catch {
            return .failure(ApiError.unknown(error))
        }
    }
}
