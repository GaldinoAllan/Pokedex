import SwiftUI

// MARK: - Pokemon Type Colors Extension
extension TypeResource {
    /// Returns the color associated with this Pokemon type
    var color: Color {
        PokemonTypeColor.color(for: type.name.lowercased())
    }
}

// MARK: - Pokemon Details Color Extension  
extension PokemonDetails {
    /// Computed URL for the Pokémon image
    ///
    /// - Returns: Optional URL for the image, based on the ID
    /// - Note: Uses the API utility function to generate the URL
    var imageURL: URL? { API.pokemonImageURL(id: id) }
    
    /// Returns the primary color of the Pokemon based on its first type
    var primaryColor: Color {
        types.first?.color ?? .gray
    }
    
    /// Returns all type colors for this Pokemon
    var typeColors: [Color] {
        types.map { $0.color }
    }
    
    /// Formatted height in meters
    var formattedHeight: String {
        "\(String(format: "%.1f", Double(height) / 10)) m"
    }
    
    /// Formatted weight in kilograms
    var formattedWeight: String {
        "\(String(format: "%.1f", Double(weight) / 10)) kg"
    }
}

// MARK: - StatResource Extension
extension StatResource {
    /// Short name for the stat (like HP, ATK, DEF, etc.)
    var shortName: String {
        switch stat.name.lowercased() {
        case "hp": return "HP"
        case "attack": return "ATK"
        case "defense": return "DEF"
        case "special-attack": return "SATK"
        case "special-defense": return "SDEF"
        case "speed": return "SPD"
        default: return stat.name.uppercased()
        }
    }
}
