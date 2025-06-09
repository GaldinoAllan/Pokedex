import Foundation

/// Default implementation of PokemonRepository using PokéAPI
///
/// This class connects to the public PokéAPI to fetch Pokémon data
/// and transforms it into the application domain entity
final class PokedexRepository: PokedexRepositoryProtocol {
    private let client: HTTPClient
    
    init(client: HTTPClient = URLSessionHTTPClient()) {
        self.client = client
    }
    
    func fetchPokedex(offset: Int, limit: Int) async throws -> [Pokemon] {
        guard let url = URL(string: "\(API.pokemon)?offset=\(offset)&limit=\(limit)") else {
            throw ApiError.invalidURL
        }
        
        let response: PokedexResponse = try await client.get(url)
        
        return response.results.enumerated().map { index, result in
            let id = offset + index + 1
            return Pokemon(id: id, name: result.name.capitalized)
        }
    }
}
