import Foundation
import Testing
@testable import Pokedex

// MARK: makeSUT method
fileprivate extension PokemonDetailRepositoryTests {
    typealias MakeSUTReturn = (
        sut: PokemonDetailsRepository,
        httpClientMock: HTTPClientMock
    )
    
    func makeSUT() -> MakeSUTReturn {
        let client = HTTPClientMock()
        let sut = PokemonDetailsRepository(client: client)
        
        return (sut, client)
    }
}

// MARK: Tests
struct PokemonDetailRepositoryTests {
    @Test("fetchPokemonDetails successfully decodes valid response")
    func successfulDecoding() async throws {
        let args = makeSUT()
        args.httpClientMock.mockData = """
        {
            "id": 1,
            "name": "bulbasaur",
            "height": 7,
            "weight": 69,
            "abilities": [
                {
                    "ability": {
                        "name": "overgrow"
                    }
                }
            ],
            "types": [
                {
                    "type": {
                        "name": "grass"
                    }
                },
                {
                    "type": {
                        "name": "poison"
                    }
                }
            ],
            "stats": [
                {
                    "base_stat": 45,
                    "stat": {
                        "name": "hp"
                    }
                }
            ]
        }
        """.data(using: .utf8)
        
        let result = try await args.sut.fetchPokemonDetails(id: 1)
        
        #expect(result.id == 1)
        #expect(result.name == "bulbasaur")
        #expect(result.height == 7)
        #expect(result.weight == 69)
        #expect(result.abilities.count == 1)
        #expect(result.abilities.first?.ability.name == "overgrow")
        #expect(result.types.count == 2)
        #expect(result.types.first?.type.name == "grass")
        #expect(result.stats.count == 1)
        #expect(result.stats.first?.baseStat == 45)
    }
    
    @Test("fetchPokemonDetails throws decoding error for invalid JSON")
    func invalidJSONDecoding() async {
        let args = makeSUT()
        args.httpClientMock.mockData = Data("invalid".utf8)
        
        await #expect(throws: ApiError.decodingError(nil)) {
            try await args.sut.fetchPokemonDetails(id: 1)
        }
    }
    
    @Test("fetchPokemonDetails throws no data error when no mock data is provided")
    func noDataError() async {
        let args = makeSUT()
        // No mock data set
        
        await #expect(throws: ApiError.noData) {
            try await args.sut.fetchPokemonDetails(id: 1)
        }
    }
    
    @Test("fetchPokemonDetails throws network error when HTTPClient throws network error")
    func networkError() async {
        let args = makeSUT()
        args.httpClientMock.mockError = .networkError(URLError(.notConnectedToInternet))
        
        await #expect(throws: ApiError.networkError(nil)) {
            try await args.sut.fetchPokemonDetails(id: 1)
        }
    }
    
    @Test("fetchPokemonDetails throws server error when HTTPClient throws server error")
    func serverError() async {
        let args = makeSUT()
        args.httpClientMock.mockError = .serverError(statusCode: 404)
        
        await #expect(throws: ApiError.serverError(statusCode: 404)) {
            try await args.sut.fetchPokemonDetails(id: 1)
        }
    }
}

