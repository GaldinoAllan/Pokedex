import SwiftUI

struct PokemonDetailView: View {
    let pokemon: Pokemon
    @StateObject var viewModel: PokemonDetailViewModel
    @EnvironmentObject private var router: Router
    
    var body: some View {
        ZStack {
            switch viewModel.state {
            case .idle:
                EmptyView()
            case .loading:
                LoadingView(message: "Loading Pokémon details...")
            case .failure:
                FeedbackView(description: errorMessage) {
                    Task { await viewModel.loadPokemonDetails() }
                }
                .padding()
            case .success(let pokemonDetails):
                PokemonDetailContentView(pokemon: pokemonDetails)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                backButton
            }
            ToolbarItem(placement: .principal) {
                pokemonNameTitle
            }
            ToolbarItem(placement: .topBarTrailing) {
                pokemonIdView
            }
        }
        .task {
            await viewModel.loadPokemonDetails()
        }
    }
    
    // MARK: - Private Properties
    private var errorMessage: String {
        "Sorry, couldn't load the details for \(pokemon.name) at this moment, try again later"
    }
    
    private var backButton: some View {
        Button(action: router.navigateBack) {
            Image(systemName: "arrow.left")
                .foregroundColor(.white)
        }
    }
    
    private var pokemonNameTitle: some View {
        HStack {
            Text(pokemon.name.capitalized)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
            Spacer()
        }
    }
    
    private var pokemonIdView: some View {
        Text(pokemon.id.format03)
            .font(.headline)
            .foregroundColor(.white)
    }
}

#Preview {
    NavigationStack {
        PokemonDetailView(
            pokemon: Pokemon(id: 1, name: "Bulbasaur"),
            viewModel: PokemonDetailViewModel(
                pokemon: Pokemon(id: 1, name: "Bulbasaur"),
                useCase: PokemonDetailsUseCase(repository: PokemonDetailsRepository())
            )
        )
    }
    .environmentObject(Router())
}
