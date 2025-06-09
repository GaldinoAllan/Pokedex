import SwiftUI

struct PokemonDetailView: View {
    let pokemon: Pokemon
    @EnvironmentObject private var router: Router
    
    var body: some View {
        Text("Details screen for: \(pokemon.name)")
    }
}
