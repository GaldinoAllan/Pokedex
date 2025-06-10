import Foundation

extension PokemonDetailsResponse {
    func toPokemonDetails() -> PokemonDetails {
        PokemonDetails(
            id: id,
            abilities: abilities,
            name: name,
            height: height,
            weight: weight,
            types: types,
            stats: stats
        )
    }
}
