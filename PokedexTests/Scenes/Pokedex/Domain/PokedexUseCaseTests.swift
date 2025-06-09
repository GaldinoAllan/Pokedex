import Foundation
import Testing
@testable import Pokedex

// MARK: makeSUT method
fileprivate extension PokedexUseCaseTests {
    typealias SUT = (
        sut: PokedexUseCase,
        repositoryMock: PokedexRepositoryMock
    )
    
    func makeSUT() -> SUT {
        let repositoryMock = PokedexRepositoryMock()
        let useCase = PokedexUseCase(repository: repositoryMock)
        return (useCase, repositoryMock)
    }
}

// MARK: Tests
struct PokedexUseCaseTests {
    @Test("use case returns pokemon successfully")
    func useCaseSuccess() async throws {
        let args = makeSUT()
        
        let expectedPokemons: [Pokemon] = [
            .bulbasaur,
            .ivysaur
        ]
        args.repositoryMock.mockPokemons = expectedPokemons
        
        let result = await args.sut.execute(offset: 0, limit: 2)
        
        guard case .success(let pokemons) = result else {
            #expect(Bool(false), "Expected success but got failure")
            return
        }
        
        #expect(pokemons.count == 2)
        #expect(pokemons[0].name == "Bulbasaur")
        #expect(pokemons[1].name == "Ivysaur")
    }
    
    @Test("use case propagates repository error")
    func useCaseError() async {
        let args = makeSUT()
        
        args.repositoryMock.mockError = .networkError(nil)
        
        let result = await args.sut.execute(offset: 0, limit: 2)
        
        guard case .failure(let error) = result else {
            #expect(Bool(false), "Expected failure but got success")
            return
        }
        
        #expect(error == .networkError(nil))
    }
}
