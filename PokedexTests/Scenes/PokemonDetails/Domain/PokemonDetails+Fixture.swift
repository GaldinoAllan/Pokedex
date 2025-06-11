import Foundation
@testable import Pokedex

extension PokemonDetails {
    static func fixture(
        id: Int = 1,
        name: String = "bulbasaur",
        height: Int = 7,
        weight: Int = 69,
        abilities: [AbilityResource] = [
            AbilityResource(ability: NameAPIResource(name: "overgrow"))
        ],
        types: [TypeResource] = [
            TypeResource(type: NameAPIResource(name: "grass")),
            TypeResource(type: NameAPIResource(name: "poison"))
        ],
        stats: [StatResource] = [
            StatResource(baseStat: 45, stat: NameAPIResource(name: "hp"))
        ]
    ) -> Self {
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
    
    static var bulbasaur: PokemonDetails {
        .fixture(id: 1, name: "bulbasaur")
    }
    
    static var ivysaur: PokemonDetails {
        .fixture(id: 2, name: "ivysaur")
    }
    
    static var venusaur: PokemonDetails {
        .fixture(id: 3, name: "venusaur")
    }
}
