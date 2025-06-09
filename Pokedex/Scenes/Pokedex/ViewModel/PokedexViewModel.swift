import Foundation

@MainActor
final class PokedexViewModel: ObservableObject {
    @Published var searchQuery: String = .empty
    @Published private(set) var state: UIState<[Pokemon]> = .idle
    
    private let useCase: PokedexUseCaseProtocol
    private var currentOffset: Int = .zero
    private let limit = 15
    private var canLoadMore = true
    private var isLoading = false
    
    init(useCase: PokedexUseCaseProtocol) {
        self.useCase = useCase
    }
    
    var pokemons: [Pokemon] {
        guard case .success(let data) = state else { return [] }
        if searchQuery.isEmpty {
            return data
        }
        return data.filter { $0.name.lowercased().contains(searchQuery.lowercased()) }
    }
    
    func loadInitialState() async {
        resetPaginationState()
        await executeFetchPokemonListUseCase()
    }
    
    func loadMoreIfNeeded(currentItem: Pokemon?) async {
        guard shouldLoadMore(for: currentItem) else { return }
        await executeFetchPokemonListUseCase()
    }
}

// MARK: - Private Methods
private extension PokedexViewModel {
    func resetPaginationState() {
        state = .loading
        currentOffset = .zero
        canLoadMore = true
        isLoading = false
    }
    
    func shouldLoadMore(for currentItem: Pokemon?) -> Bool {
        guard let currentItem,
              canLoadMore,
              !isLoading,
              case .success(let currentList) = state,
              currentList.last?.id == currentItem.id else {
            return false
        }
        return true
    }
    
    func executeFetchPokemonListUseCase() async {
        isLoading = true
        defer { isLoading = false }
        let result = await useCase.execute(offset: currentOffset, limit: limit)
        switch result {
        case .success(let pokemons):
            handleFetchSuccess(pokemons)
        case .failure(let apiError):
            handleFetchFailure(apiError)
        }
    }
    
    func handleFetchSuccess(_ newPokemons: [Pokemon]) {
        updatePaginationState(with: newPokemons)
        updateUIState(with: newPokemons)
    }
    
    func handleFetchFailure(_ error: ApiError) {
        state = .failure(error: error)
    }
    
    func updatePaginationState(with newPokemons: [Pokemon]) {
        currentOffset += newPokemons.count
        canLoadMore = newPokemons.count == limit
    }
    
    func updateUIState(with newPokemons: [Pokemon]) {
        if newPokemons.isEmpty {
            state = .failure(error: ApiError.noData)
        } else if isInitialLoad() {
            state = .success(data: newPokemons)
        } else {
            appendToExistingPokemons(newPokemons)
        }
    }
    
    func isInitialLoad() -> Bool {
        currentOffset <= limit
    }
    
    func appendToExistingPokemons(_ newPokemons: [Pokemon]) {
        if case .success(let existingPokemons) = state {
            let allPokemons = existingPokemons + newPokemons
            state = .success(data: allPokemons)
        } else {
            state = .success(data: newPokemons)
        }
    }
}
