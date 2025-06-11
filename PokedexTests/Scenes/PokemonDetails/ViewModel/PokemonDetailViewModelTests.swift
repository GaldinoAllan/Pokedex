import Foundation
import Testing
@testable import Pokedex

// MARK: - makeSUT method
fileprivate extension PokemonDetailViewModelTests {
    typealias SUT = (
        sut: PokemonDetailViewModel,
        useCaseMock: PokemonDetailsUseCaseMock
    )
    
    @MainActor func makeSUT(pokemon: Pokemon = .fixture()) -> SUT {
        let useCaseMock = PokemonDetailsUseCaseMock()
        let viewModel = PokemonDetailViewModel(pokemon: pokemon, useCase: useCaseMock)
        return (viewModel, useCaseMock)
    }
}

// MARK: - Tests
struct PokemonDetailViewModelTests {
    @Test("pokemon properties return correct values")
    func pokemonPropertiesReturnCorrectValues() async {
        let pokemon = Pokemon.fixture(id: 25, name: "Pikachu")
        let args = await makeSUT(pokemon: pokemon)
        
        await #expect(args.sut.pokemonName == "Pikachu")
        await #expect(args.sut.pokemonId == "#025")
        await #expect(args.sut.pokemonImageURL == API.pokemonImageURL(id: 25))
    }
    
    @Test("loadPokemonDetails success updates state correctly")
    func loadPokemonDetailsSuccessUpdatesState() async {
        let args = await makeSUT()
        let expectedDetails = PokemonDetails.fixture(name: "bulbasaur")
        args.useCaseMock.mockResult = .success(expectedDetails)
        
        await args.sut.loadPokemonDetails()
        
        #expect(args.useCaseMock.executeCallCount == 1)
        
        if case .success(let data) = await args.sut.state {
            #expect(data.name == "bulbasaur")
        } else {
            Issue.record("Expected success state")
        }
    }
    
    @Test("loadPokemonDetails failure updates state correctly")
    func loadPokemonDetailsFailureUpdatesState() async {
        let args = await makeSUT()
        let expectedError = ApiError.decodingError(nil)
        args.useCaseMock.mockResult = .failure(expectedError)
        
        await args.sut.loadPokemonDetails()
        
        #expect(args.useCaseMock.executeCallCount == 1)
        
        if case .failure = await args.sut.state {
            // Success - failure state was set
        } else {
            Issue.record("Expected failure state")
        }
    }
    
    @Test("loadPokemonDetails calls useCase with correct pokemon id")
    func loadPokemonDetailsCallsUseCaseWithCorrectId() async {
        let pokemon = Pokemon.fixture(id: 150)
        let args = await makeSUT(pokemon: pokemon)
        
        await args.sut.loadPokemonDetails()
        
        #expect(args.useCaseMock.lastExecuteParams == 150)
    }
}
