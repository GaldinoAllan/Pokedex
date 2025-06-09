import Foundation

struct PokemonDetails: Decodable, Equatable {
    let id: Int
    let abilities: [AbilityResource]
    let name: String
    let height: Int
    let weight: Int
    let types: [TypeResource]
    let stats: [StatResource]
    
    struct StatResource: Decodable, Equatable {
        let baseStat: Int
        let stat: NameAPIResource
    }

    struct AbilityResource: Decodable, Equatable {
        let ability: NameAPIResource
    }

    struct TypeResource: Decodable, Equatable {
        let type: NameAPIResource
    }

    struct NameAPIResource: Decodable, Equatable {
        let name: String
    }
}
