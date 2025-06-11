import Foundation
@testable import Pokedex

/// Mock implementation of PokemonRepository for testing purposes
final class PokemonDetailRepositoryMock: PokemonDetailRepositoryProtocol {
    
    /// Mock data to return when fetchPokemons is called
    var mockPokemonDetail: PokemonDetails? = nil
    
    /// Mock error to throw when fetchPokemons is called
    var mockError: ApiError?
    
    func fetchPokemonDetails(id: Int) async throws -> PokemonDetails {
        if let mockError {
            throw mockError
        }
        guard let mockPokemonDetail else { throw ApiError.noData }
        return mockPokemonDetail
    }
}
