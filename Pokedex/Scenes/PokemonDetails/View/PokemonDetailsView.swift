import SwiftUI

struct PokemonDetailView: View {
    let pokemon: Pokemon
    @StateObject var viewModel: PokemonDetailViewModel
    @EnvironmentObject private var router: Router
    
    // MARK: - Constants
    private enum Constants {
        static let loadingMessage = "Loading Pokémon details..."
        static let errorMessageFormat = "Sorry, couldn't load the details for %@ at this moment, try again later"
        static let backButtonIcon = "arrow.left"
    }
    
    var body: some View {
        ZStack {
            switch viewModel.state {
            case .idle:
                EmptyView()
            case .loading:
                LoadingView(message: Constants.loadingMessage)
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
        String(format: Constants.errorMessageFormat, pokemon.name)
    }
    
    private var backButton: some View {
        Button(action: router.navigateBack) {
            Image(systemName: Constants.backButtonIcon)
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
