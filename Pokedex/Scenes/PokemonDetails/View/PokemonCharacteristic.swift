import SwiftUI

struct PokemonCharacteristic: View {
        let characteristicTitle: String
        let characteristicText: String?
        let characteristicLabel: String?
        let characteristicLabelImage: String?
        
        init(
            characteristicTitle: String,
            characteristicText: String? = nil,
            characteristicLabel: String? = nil,
            characteristicLabelImage: String? = nil
        ) {
            self.characteristicTitle = characteristicTitle
            self.characteristicText = characteristicText
            self.characteristicLabel = characteristicLabel
            self.characteristicLabelImage = characteristicLabelImage
        }
        
    var body: some View {
        VStack(spacing: 4) {
            if let characteristicLabel, let characteristicLabelImage {
                Label(characteristicLabel, systemImage: characteristicLabelImage)
                    .font(.callout)
                    .multilineTextAlignment(.center)
            }
            if let characteristicText {
                Text(characteristicText)
                    .font(.callout)
                    .multilineTextAlignment(.leading)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
            }
            Text(characteristicTitle)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}
