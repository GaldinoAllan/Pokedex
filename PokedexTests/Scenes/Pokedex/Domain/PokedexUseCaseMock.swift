import Foundation
@testable import Pokedex

/// Mock implementation of PokedexUseCaseProtocol for testing purposes
final class PokedexUseCaseMock: PokedexUseCaseProtocol {
    /// The result to return when execute is called
    var mockResult: Result<[Pokemon], ApiError> = .success([])
    
    /// Tracks how many times execute was called
    private(set) var executeCallCount = 0
    
    /// Stores the parameters passed to the last execute call
    private(set) var lastExecuteParams: (offset: Int, limit: Int)?
    
    func execute(offset: Int, limit: Int) async -> Result<[Pokemon], ApiError> {
        executeCallCount += 1
        lastExecuteParams = (offset: offset, limit: limit)
        return mockResult
    }
}

