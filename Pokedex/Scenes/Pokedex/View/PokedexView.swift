import SwiftUI

struct PokedexView: View {
    @StateObject var viewModel: PokedexViewModel
    @State private var sortByName = false
    @EnvironmentObject private var router: Router
    
    var body: some View {
        VStack(spacing: 0) {
            header
            searchBar
            pokemonList
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .background(Color(.systemRed))
        .ignoresSafeArea(edges: .bottom)
        .task {
            await viewModel.loadInitialState()
        }
        .navigationBarHidden(true)
    }
    
    private var header: some View {
        HStack {
            Text("Pokédex")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(Color(.white))
            Spacer()
        }
        .padding()
        .background(Color(.systemRed))
    }
    
    private var searchBar: some View {
        HStack(spacing: 12) {
            TextField("Search Pokémon", text: $viewModel.searchQuery)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button {
                sortByName.toggle()
            } label: {
                Image(systemName: sortByName ? "textformat" : "number")
                    .foregroundColor(.primary)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .clipShape(.circle)
            }
        }
        .padding(.horizontal)
        .background(Color(.systemRed))
    }
    
    private var pokemonList: some View {
        ZStack {
            listContentView
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemRed))
        .padding(.horizontal, 4)
        .padding(.top, 16)
    }
    
    private func sorted(_ pokemons: [Pokemon]) -> [Pokemon] {
        sortByName ? pokemons.sorted { $0.name < $1.name } : pokemons.sorted { $0.id < $1.id }
    }
}

private extension PokedexView {
    var listContentView: some View {
        ZStack {
            switch viewModel.state {
            case .idle:
                EmptyView()
            case .loading:
                LoadingView(message: "Loading Pokémon...")
            case .failure:
                FeedbackView(description: "Sorry, couldn't load the Pokémon list at this moment, try again later") {
                    Task {
                        await viewModel.loadInitialState()
                    }
                }
            case .success:
                pokemonListView
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
        .clipShape(RoundedCorner(radius: 30, corners: [.topLeft, .topRight]))
    }
    
    var pokemonListView: some View {
        List(sorted(viewModel.pokemons)) { pokemon in
            Button {
                router.navigate(to: .pokemonDetail(pokemon: pokemon))
            } label: {
                PokemonCardView(pokemon: pokemon)
                    .onAppear {
                        Task {
                            await viewModel.loadMoreIfNeeded(currentItem: pokemon)
                        }
                    }
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.inset)
    }
}

#Preview {
    NavigationStack {
        PokedexView(
            viewModel: PokedexViewModel(useCase: PokedexUseCase(repository: PokedexRepository()))
        )
        .environmentObject(Router())
    }
}
