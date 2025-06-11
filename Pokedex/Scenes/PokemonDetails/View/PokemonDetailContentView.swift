import SwiftUI

struct PokemonDetailContentView: View {
    let pokemon: PokemonDetails
    
    // MARK: - Constants
    private enum Constants {
        static let pokeballBackgroundImage = "pokeball_background"
        static let aboutTitle = "About"
        static let baseStatsTitle = "Base Stats"
        static let weightTitle = "Weight"
        static let heightTitle = "Height"
        static let movesTitle = "Moves"
        static let weightIcon = "scalemass"
        static let heightIcon = "ruler"
        static let abilitiesSeparator = "\n"
        static let statValueFormat = "%03d"
    }
    
    var body: some View {
        ZStack {
            pokemon.primaryColor.ignoresSafeArea()
            VStack {
                headerSection
                contentSection
            }
            PokeAsyncImage(url: pokemon.imageURL, size: Layout.Frame.pokemonDetailImageSize)
                .offset(y: Layout.Offset.pokemonImageY)
        }
    }
}

// MARK: - Private Views
private extension PokemonDetailContentView {
    var headerSection: some View {
        ZStack {
            Image(Constants.pokeballBackgroundImage)
                .resizable()
                .scaledToFit()
                .frame(width: Layout.Frame.pokeballBackgroundSize, height: Layout.Frame.pokeballBackgroundSize)
                .opacity(Layout.Opacity.light)
                .offset(x: Layout.Offset.pokeballBackgroundX, y: Layout.Offset.pokeballBackgroundY)
        }
        .background(pokemon.primaryColor)
    }
    
    var contentSection: some View {
        VStack(spacing: Layout.Spacing.small) {
            typesSection
            aboutSection
            Spacer()
            statsSection
        }
        .padding()
        .padding(.top, Layout.Padding.xxxLarge)
        .background(
            RoundedRectangle(cornerRadius: Layout.CornerRadius.extraLarge)
                .fill(Color(.systemBackground))
                .padding(Layout.Padding.extraSmall)
        )
    }

    var typesSection: some View {
        HStack(spacing: Layout.Spacing.medium) {
            ForEach(pokemon.types, id: \.type.name) { type in
                typeBadge(for: type)
            }
        }
    }

    var aboutSection: some View {
        VStack(spacing: Layout.Spacing.large) {
            sectionTitle(Constants.aboutTitle)
            HStack(alignment: .top) {
                PokemonCharacteristic(
                    characteristicTitle: Constants.weightTitle,
                    characteristicLabel: pokemon.formattedWeight,
                    characteristicLabelImage: Constants.weightIcon
                )
                .frame(maxWidth: .infinity)
                
                PokemonCharacteristic(
                    characteristicTitle: Constants.heightTitle,
                    characteristicLabel: pokemon.formattedHeight,
                    characteristicLabelImage: Constants.heightIcon
                )
                .frame(maxWidth: .infinity)
                
                PokemonCharacteristic(
                    characteristicTitle: Constants.movesTitle,
                    characteristicText: pokemon.abilities.map { $0.ability.name.capitalized }.joined(separator: Constants.abilitiesSeparator)
                )
                .frame(maxWidth: .infinity)
            }
        }
        .padding()
    }

    var statsSection: some View {
        VStack(spacing: Layout.Spacing.medium) {
            sectionTitle(Constants.baseStatsTitle)
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
            .padding(.horizontal, Layout.Padding.large)
            .padding(.vertical, Layout.Padding.small)
            .background(type.color)
            .foregroundColor(.white)
            .cornerRadius(Layout.CornerRadius.large)
    }
    
    func statRow(for stat: StatResource) -> some View {
        HStack(spacing: Layout.Spacing.medium) {
            Text(stat.shortName)
                .fontWeight(.bold)
                .font(.footnote)
                .frame(minWidth: Layout.Frame.mediumWidth, alignment: .trailing)
                .foregroundColor(pokemon.primaryColor)
            Rectangle()
                .fill(Color.gray.opacity(Layout.Opacity.medium))
                .frame(width: Layout.Frame.dividerWidth, height: Layout.Frame.mediumHeight)
            Text(String(format: Constants.statValueFormat, stat.baseStat))
                .monospacedDigit()
                .font(.footnote)
                .frame(width: Layout.Frame.smallWidth, alignment: .leading)
            ProgressView(value: Double(stat.baseStat), total: Layout.Stats.maxValue)
                .progressViewStyle(LinearProgressViewStyle(tint: pokemon.primaryColor))
                .frame(height: Layout.Frame.smallHeight)
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
