import Foundation

@MainActor
final class PokemonDetailViewModel: ObservableObject {
    @Published private(set) var state: UIState<PokemonDetails> = .idle
    
    private let pokemon: Pokemon
    private let useCase: PokemonDetailsUseCaseProtocol
    
    init(pokemon: Pokemon, useCase: PokemonDetailsUseCaseProtocol) {
        self.pokemon = pokemon
        self.useCase = useCase
    }
    
    var pokemonName: String {
        pokemon.name
    }
    
    var pokemonId: String {
        pokemon.id.format03
    }
    
    var pokemonImageURL: URL? {
        pokemon.imageURL
    }
    
    func loadPokemonDetails() async {
        state = .loading
        let result = await useCase.execute(id: pokemon.id)
        
        switch result {
        case .success(let details):
            state = .success(data: details)
        case .failure(let error):
            state = .failure(error: error)
        }
    }
}
