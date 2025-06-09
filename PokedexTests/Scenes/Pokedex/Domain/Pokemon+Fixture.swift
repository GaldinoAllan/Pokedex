import Foundation
@testable import Pokedex

extension Pokemon {
    static func fixture(id: Int = 1, name: String = "Bulbasaur") -> Self {
        Pokemon(id: id, name: name)
    }
    
    static var bulbasaur: Pokemon {
        .fixture(id: 1, name: "Bulbasaur")
    }
    
    static var ivysaur: Pokemon {
        .fixture(id: 2, name: "Ivysaur")
    }
    
    static var venusaur: Pokemon {
        .fixture(id: 3, name: "Venusaur")
    }
}
