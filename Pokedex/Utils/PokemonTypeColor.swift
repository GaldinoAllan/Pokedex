import SwiftUI

/// Enum to define the Pokemon colors by type
enum PokemonTypeColor {
    /// Returns the color associated with this Pokemon type
    static func color(for type: String) -> Color {
        switch type.lowercased() {
        case "fire": return .red
        case "water": return .blue
        case "grass": return .green
        case "electric": return .yellow
        case "ice": return .cyan
        case "fighting": return .orange
        case "poison": return .purple
        case "ground": return .brown
        case "flying": return .indigo
        case "psychic": return .pink
        case "bug": return .green.opacity(0.7)
        case "ghost": return .purple
        case "steel": return .gray
        case "rock": return Color(.systemGray2)
        case "dragon": return Color(.systemTeal)
        case "dark": return Color(.darkGray)
        case "fairy": return Color(.systemPink)
        case "normal": return Color(.systemGray)
        default: return Color(.systemGray4)
        }
    }
}
