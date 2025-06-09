import Foundation

/// Default implementation of the PokedexUseCase
///
/// This class coordinates the execution of the business rule to fetch Pokedex,
/// delegating the actual operation to the appropriate repository
final class PokedexUseCase: PokedexUseCaseProtocol {
    private let repository: PokedexRepositoryProtocol
    
    init(repository: PokedexRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(offset: Int, limit: Int) async -> Result<[Pokemon], ApiError> {
        do {
            let pokemons = try await repository.fetchPokedex(offset: offset, limit: limit)
            return pokemons.isEmpty ? .failure(.noData) : .success(pokemons)
        } catch let error as ApiError {
            return .failure(error)
        } catch {
            return .failure(ApiError.unknown(error))
        }
    }
}
