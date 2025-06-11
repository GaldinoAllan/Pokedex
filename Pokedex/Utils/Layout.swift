import Foundation

/// Centralizes layout constants used throughout the app
/// 
/// This enum provides consistent spacing, padding, and sizing values
/// to maintain design consistency across all UI components
enum Layout {
    
    // MARK: - Spacing
    enum Spacing {
        static let extraSmall: CGFloat = 4
        static let small: CGFloat = 8
        static let medium: CGFloat = 12
        static let large: CGFloat = 16
        static let extraLarge: CGFloat = 20
        static let xxLarge: CGFloat = 30
        static let xxxLarge: CGFloat = 40
    }
    
    // MARK: - Corner Radius
    enum CornerRadius {
        static let small: CGFloat = 8
        static let medium: CGFloat = 12
        static let large: CGFloat = 20
        static let extraLarge: CGFloat = 30
    }
    
    // MARK: - Padding
    enum Padding {
        static let extraSmall: CGFloat = 4
        static let small: CGFloat = 8
        static let medium: CGFloat = 12
        static let large: CGFloat = 16
        static let extraLarge: CGFloat = 20
        static let xxLarge: CGFloat = 30
        static let xxxLarge: CGFloat = 40
    }
    
    // MARK: - Frame Sizes
    enum Frame {
        static let dividerWidth: CGFloat = 1
        static let smallHeight: CGFloat = 8
        static let smallWidth: CGFloat = 40
        static let mediumWidth: CGFloat = 50
        static let mediumHeight: CGFloat = 20
        static let iconSize: CGFloat = 50
        static let pokemonCardImageSize: CGFloat = 80
        static let defaultImageSize: CGFloat = 200
        static let pokemonDetailImageSize: CGFloat = 250
        static let pokeballBackgroundSize: CGFloat = 250
    }
    
    // MARK: - Shadow
    enum Shadow {
        static let radius: CGFloat = 4
        static let offsetX: CGFloat = 0
        static let offsetY: CGFloat = 2
        static let opacity: Double = 0.1
    }
    
    // MARK: - Opacity
    enum Opacity {
        static let light: Double = 0.1
        static let medium: Double = 0.3
    }
    
    // MARK: - Offset
    enum Offset {
        static let pokemonImageY: CGFloat = -200
        static let pokeballBackgroundX: CGFloat = 70
        static let pokeballBackgroundY: CGFloat = 0
    }
    
    // MARK: - Stats
    enum Stats {
        static let maxValue: Double = 256
    }
}
