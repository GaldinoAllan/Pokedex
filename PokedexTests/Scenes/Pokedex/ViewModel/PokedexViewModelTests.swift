import Foundation
import Testing
@testable import Pokedex

extension PokedexViewModelTests {
    typealias SUT = (
        sut: PokedexViewModel,
        useCaseMock: PokedexUseCaseMock
    )
    
    @MainActor func makeSUT() -> SUT {
        let useCaseMock = PokedexUseCaseMock()
        let viewModel = PokedexViewModel(useCase: useCaseMock)
        return (viewModel, useCaseMock)
    }
}

struct PokedexViewModelTests {
    
    // MARK: - Initial State Tests
    
    @Test("viewModel starts with idle state")
    func initialState() async {
        let args = await makeSUT()
        
        guard case .idle = await args.sut.state else {
            #expect(Bool(false), "Expected idle state")
            return
        }
        
        await #expect(args.sut.searchQuery .isEmpty)
        await #expect(args.sut.pokemons.isEmpty)
    }
    
    // MARK: - Load Initial State Tests
    
    @Test("loadInitialState success sets pokemon list")
    func loadInitialStateSuccess() async {
        let args = await makeSUT()
        let expectedPokemons: [Pokemon] = [.bulbasaur, .ivysaur]
        args.useCaseMock.mockResult = .success(expectedPokemons)
        
        await args.sut.loadInitialState()
        
        guard case .success(let pokemons) = await args.sut.state else {
            #expect(Bool(false), "Expected success state")
            return
        }
        
        #expect(pokemons.count == 2)
        #expect(pokemons[0].name == "Bulbasaur")
        #expect(args.useCaseMock.executeCallCount == 1)
    }
    
    @Test("loadInitialState failure sets error state")
    func loadInitialStateFailure() async {
        let args = await makeSUT()
        let expectedError: ApiError = .networkError(nil)
        args.useCaseMock.mockResult = .failure(expectedError)
        
        await args.sut.loadInitialState()
        
        guard case .failure(let error) = await args.sut.state else {
            #expect(Bool(false), "Expected failure state")
            return
        }
        
        #expect(error == expectedError)
    }
    
    // MARK: - Search Tests
    
    @Test("filteredPokemons returns all when search is empty")
    func filteredPokemonsEmptySearch() async {
        let args = await makeSUT()
        let pokemons: [Pokemon] = [.bulbasaur, .ivysaur]
        args.useCaseMock.mockResult = .success(pokemons)
        
        await args.sut.loadInitialState()
        
        await #expect(args.sut.pokemons.count == 2)
    }
    
    @Test("filteredPokemons filters by name")
    func filteredPokemonsWithSearch() async {
        let args = await makeSUT()
        let pokemons: [Pokemon] = [
            .bulbasaur,
            .ivysaur,
            .venusaur
        ]
        args.useCaseMock.mockResult = .success(pokemons)
        
        await args.sut.loadInitialState()
        
        await MainActor.run {
            args.sut.searchQuery = "ivy"
        }
        await #expect(args.sut.pokemons.count == 1)
        await #expect(args.sut.pokemons[0].name == "Ivysaur")
    }
    
    @Test("filteredPokemons returns empty when no match")
    func filteredPokemonsNoMatch() async {
        let args = await makeSUT()
        let pokemons: [Pokemon] = [.bulbasaur, .ivysaur]
        args.useCaseMock.mockResult = .success(pokemons)
        
        await args.sut.loadInitialState()
        
        await MainActor.run {
            args.sut.searchQuery = "Pikachu"
        }
        await #expect(args.sut.pokemons.isEmpty)
    }
}
