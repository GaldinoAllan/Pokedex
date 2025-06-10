import SwiftUI

struct PokemonCardView: View {
    let pokemon: Pokemon
    
    var body: some View {
        HStack(spacing: 12) {
            PokeAsyncImage(url: pokemon.imageURL, size: 80)
            Text(pokemon.name.capitalized)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.primary)   
            Spacer()
            Text(pokemon.id.format03)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    PokemonCardView(pokemon: Pokemon(id: 1, name: "Bulbasaur"))
}
