import Foundation

@MainActor
final class PokedexViewModel: ObservableObject {
    @Published var searchQuery: String = .empty
    @Published private(set) var state: UIState<[Pokemon]> = .idle
    
    private let useCase: PokedexUseCaseProtocol
    
    init(useCase: PokedexUseCaseProtocol) {
        self.useCase = useCase
    }
    
    var pokemons: [Pokemon] = []
    
    func loadInitialState() { }
}
