import Foundation
@testable import Pokedex

/// Mock implementation of HTTPClient for testing purposes
final class HTTPClientMock: HTTPClient {
    var mockData: Data?
    var mockError: ApiError?
    
    func get<T: Decodable>(_ url: URL) async throws -> T {
        // If a mock error is set, throw it
        if let mockError {
            throw mockError
        }
        
        // If no mock data is provided, throw no data error
        guard let mockData else {
            throw ApiError.noData
        }
        
        // Attempt to decode the mock data
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(T.self, from: mockData)
        } catch {
            throw ApiError.decodingError(error)
        }
    }
}
