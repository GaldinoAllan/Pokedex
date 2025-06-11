import Foundation
@testable import Pokedex

/// Mock implementation of FetchPokemonDetailsUseCase for testing purposes
final class PokemonDetailsUseCaseMock: PokemonDetailsUseCaseProtocol {
    /// The result to return when execute is called
    var mockResult: Result<PokemonDetails, ApiError> = .success(PokemonDetails.fixture())
    
    /// Tracks how many times execute was called
    private(set) var executeCallCount = 0
    
    /// Stores the parameters passed to the last execute call
    private(set) var lastExecuteParams: Int?
    
    func execute(id: Int) async -> Result<PokemonDetails, ApiError> {
        executeCallCount += 1
        lastExecuteParams = id
        return mockResult
    }
}
