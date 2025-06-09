import Foundation

/// implementation of PokemonDetailsRepository using PokéAPI
///
/// This class connects to the public PokéAPI to fetch Pokémon data
/// and transforms it into application domain entities
final class PokemonDetailsRepository: PokemonDetailRepositoryProtocol {
    private let client: HTTPClient
    
    init(client: HTTPClient = URLSessionHTTPClient()) {
        self.client = client
    }
    
    func fetchPokemonDetails(id: Int) async throws -> PokemonDetails {
        guard let url = URL(string: "\(API.pokemon)/\(id)") else {
            throw ApiError.invalidURL
        }
        return try await client.get(url)
    }
}
