import Foundation
@testable import Pokedex

/// Mock implementation of PokedexRepositoryProtocol for testing purposes
final class PokedexRepositoryMock: PokedexRepositoryProtocol {
    
    /// Mock data to return when fetchPokedex is called
    var mockPokemons: [Pokemon] = []
    
    /// Mock error to throw when fetchPokedex is called
    var mockError: ApiError?
    
    func fetchPokedex(offset: Int, limit: Int) async throws -> [Pokemon] {
        if let mockError {
            throw mockError
        }
        return mockPokemons
    }
}

