import Foundation
import Testing
@testable import Pokedex

// MARK: makeSUT method
fileprivate extension PokedexRepositoryTests {
    typealias MakeSUTReturn = (
        sut: PokedexRepository,
        httpClientMock: HTTPClientMock
    )
    
    func makeSUT() -> MakeSUTReturn {
        let client = HTTPClientMock()
        let sut = PokedexRepository(client: client)
        
        return (sut, client)
    }
}

// MARK: Tests
struct PokedexRepositoryTests {
    @Test("fetchPokedex successfully decodes valid response")
    func successfulDecoding() async throws {
        let args = makeSUT()
        args.httpClientMock.mockData = """
        {
            "results": [
                { "name": "bulbasaur", "url": "https://pokeapi.co/api/v2/pokemon/1/" },
                { "name": "ivysaur", "url": "https://pokeapi.co/api/v2/pokemon/2/" }
            ]
        }
        """.data(using: .utf8)
        
        let result = try await args.sut.fetchPokedex(offset: 0, limit: 2)
        
        #expect(result.count == 2)
        #expect(result.first?.name == "Bulbasaur")
        #expect(result.first?.id == 1)
        #expect(result.last?.name == "Ivysaur")
        #expect(result.last?.id == 2)
    }
    
    @Test("fetchPokedex throws decoding error for invalid JSON")
    func invalidJSONDecoding() async {
        let args = makeSUT()
        args.httpClientMock.mockData = Data("invalid".utf8)
        
        await #expect(throws: ApiError.decodingError(nil)) {
            try await args.sut.fetchPokedex(offset: 0, limit: 1)
        }
    }
    
    @Test("fetchPokedex throws no data error when no mock data is provided")
    func noDataError() async {
        let args = makeSUT()
        // No mock data set
        
        await #expect(throws: ApiError.noData) {
            try await args.sut.fetchPokedex(offset: 0, limit: 1)
        }
    }
    
    @Test("fetchPokedex throws network error when HTTPClient throws network error")
    func networkError() async {
        let args = makeSUT()
        args.httpClientMock.mockError = .networkError(URLError(.notConnectedToInternet))
        
        await #expect(throws: ApiError.networkError(nil)) {
            try await args.sut.fetchPokedex(offset: 0, limit: 1)
        }
    }
}
