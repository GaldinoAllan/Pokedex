import Foundation
import Testing
@testable import Pokedex

// MARK: makeSUT method
fileprivate extension PokemonDetailsUseCaseTests {
    typealias SUT = (
        sut: PokemonDetailsUseCase,
        repositoryMock: PokemonDetailRepositoryMock
    )
    
    func makeSUT() -> SUT {
        let repositoryMock = PokemonDetailRepositoryMock()
        let useCase = PokemonDetailsUseCase(repository: repositoryMock)
        return (useCase, repositoryMock)
    }
}

// MARK: Tests
struct PokemonDetailsUseCaseTests {
    @Test("use case returns pokemon details successfully")
    func useCaseSuccess() async throws {
        let args = makeSUT()
        
        let expectedPokemonDetails: PokemonDetails = .bulbasaur
        args.repositoryMock.mockPokemonDetail = expectedPokemonDetails
        
        let result = await args.sut.execute(id: 1)
        
        guard case .success(let pokemonDetails) = result else {
            #expect(Bool(false), "Expected success but got failure")
            return
        }
        
        #expect(pokemonDetails.id == 1)
        #expect(pokemonDetails.name == "bulbasaur")
        #expect(pokemonDetails.height == 7)
        #expect(pokemonDetails.weight == 69)
        #expect(pokemonDetails.abilities.count == 1)
        #expect(pokemonDetails.abilities.first?.ability.name == "overgrow")
    }
    
    @Test("use case propagates repository error")
    func useCaseError() async {
        let args = makeSUT()
        
        args.repositoryMock.mockError = .networkError(nil)
        
        let result = await args.sut.execute(id: 1)
        
        guard case .failure(let error) = result else {
            #expect(Bool(false), "Expected failure but got success")
            return
        }
        
        #expect(error == .networkError(nil))
    }
    
    @Test("use case handles server error correctly")
    func useCaseServerError() async {
        let args = makeSUT()
        
        args.repositoryMock.mockError = .serverError(statusCode: 404)
        
        let result = await args.sut.execute(id: 9999)
        
        guard case .failure(let error) = result else {
            #expect(Bool(false), "Expected failure but got success")
            return
        }
        
        #expect(error == .serverError(statusCode: 404))
    }
}
