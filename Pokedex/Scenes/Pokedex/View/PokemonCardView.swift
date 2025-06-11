import SwiftUI

struct PokemonCardView: View {
    let pokemon: Pokemon
    
    var body: some View {
        HStack(spacing: Layout.Spacing.medium) {
            PokeAsyncImage(url: pokemon.imageURL, size: Layout.Frame.pokemonCardImageSize)
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
        .cornerRadius(Layout.CornerRadius.medium)
        .shadow(
            color: .black.opacity(Layout.Shadow.opacity), 
            radius: Layout.Shadow.radius, 
            x: Layout.Shadow.offsetX, 
            y: Layout.Shadow.offsetY
        )
    }
}

#Preview {
    PokemonCardView(pokemon: Pokemon(id: 1, name: "Bulbasaur"))
}
