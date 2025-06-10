import SwiftUI

struct PokemonDetailContentView: View {
    let pokemon: PokemonDetails
    
    var body: some View {
        ZStack {
            pokemon.primaryColor.ignoresSafeArea()
            VStack {
                headerSection
                contentSection
            }
            PokeAsyncImage(url: pokemon.imageURL, size: 250)
                .offset(y: -200)
        }
    }
}

// MARK: - Private Views
private extension PokemonDetailContentView {
    var headerSection: some View {
        ZStack {
            Image("pokeball_background")
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 250)
                .opacity(0.1)
                .offset(x: 70, y: 0)
        }
        .background(pokemon.primaryColor)
    }
    
    var contentSection: some View {
        VStack(spacing: 8) {
            typesSection
            aboutSection
            Spacer()
            statsSection
        }
        .padding()
        .padding(.top, 40)
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(Color(.systemBackground))
                .padding(4)
        )
    }

    var typesSection: some View {
        HStack(spacing: 12) {
            ForEach(pokemon.types, id: \.type.name) { type in
                typeBadge(for: type)
            }
        }
    }

    var aboutSection: some View {
        VStack(spacing: 16) {
            sectionTitle("About")
            HStack(alignment: .top) {
                PokemonCharacteristic(
                    characteristicTitle: "Weight",
                    characteristicLabel: pokemon.formattedWeight,
                    characteristicLabelImage: "scalemass"
                )
                .frame(maxWidth: .infinity)
                
                PokemonCharacteristic(
                    characteristicTitle: "Height",
                    characteristicLabel: pokemon.formattedHeight,
                    characteristicLabelImage: "ruler"
                )
                .frame(maxWidth: .infinity)
                
                PokemonCharacteristic(
                    characteristicTitle: "Moves",
                    characteristicText: pokemon.abilities.map { $0.ability.name.capitalized }.joined(separator: "\n")
                )
                .frame(maxWidth: .infinity)
            }
        }
        .padding()
    }

    var statsSection: some View {
        VStack(spacing: 12) {
            sectionTitle("Base Stats")
            VStack(spacing: .zero) {
                ForEach(pokemon.stats, id: \.stat.name) { stat in
                    statRow(for: stat)
                }
            }
        }
        .padding()
    }
    
    // MARK: - Helper Views
    func sectionTitle(_ title: String) -> some View {
        Text(title)
            .font(.title2.bold())
            .foregroundColor(pokemon.primaryColor)
    }
    
    func typeBadge(for type: TypeResource) -> some View {
        Text(type.type.name.capitalized)
            .font(.subheadline.bold())
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(type.color)
            .foregroundColor(.white)
            .cornerRadius(20)
    }
    
    func statRow(for stat: StatResource) -> some View {
        HStack(spacing: 12) {
            Text(stat.shortName)
                .fontWeight(.bold)
                .font(.footnote)
                .frame(minWidth: 50, alignment: .trailing)
                .foregroundColor(pokemon.primaryColor)
            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .frame(width: 1, height: 20)
            Text(String(format: "%03d", stat.baseStat))
                .monospacedDigit()
                .font(.footnote)
                .frame(width: 40, alignment: .leading)
            ProgressView(value: Double(stat.baseStat), total: 256)
                .progressViewStyle(LinearProgressViewStyle(tint: pokemon.primaryColor))
                .frame(height: 8)
        }
    }
}

#Preview {
    NavigationStack {
        PokemonDetailContentView(
            pokemon: PokemonDetails(
                id: 1,
                abilities: [AbilityResource(ability: NameAPIResource(name: "Chlorophyll")), AbilityResource(ability: NameAPIResource(name: "Overgrow"))],
                name: "Bulbasaur",
                height: 7,
                weight: 69,
                types: [TypeResource(type: NameAPIResource(name: "Grass")), TypeResource(type: NameAPIResource(name: "Poison"))],
                stats: [
                    StatResource(baseStat: 45, stat: NameAPIResource(name: "hp")),
                    StatResource(baseStat: 49, stat: NameAPIResource(name: "attack")),
                    StatResource(baseStat: 49, stat: NameAPIResource(name: "defense")),
                    StatResource(baseStat: 65, stat: NameAPIResource(name: "special-attack")),
                    StatResource(baseStat: 65, stat: NameAPIResource(name: "special-defense")),
                    StatResource(baseStat: 45, stat: NameAPIResource(name: "speed")),
                ]
            )
        )
    }
    .environmentObject(Router())
}
