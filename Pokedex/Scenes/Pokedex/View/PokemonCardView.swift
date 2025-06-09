import SwiftUI

struct PokemonCardView: View {
    let pokemon: Pokemon
    
    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: pokemon.imageURL) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                case .failure(_):
                    Image(systemName: "photo")
                        .font(.system(size: 40))
                        .foregroundColor(.gray)
                        .frame(width: 80, height: 80)
                case .empty:
                    ProgressView()
                        .frame(width: 80, height: 80)
                @unknown default:
                    EmptyView()
                }
            }
            Text(pokemon.name.capitalized)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.primary)   
            Spacer()
            Text("#\(String(format: "%03d", pokemon.id))")
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
