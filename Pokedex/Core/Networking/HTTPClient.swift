import Foundation

/// Protocol that defines the interface for performing HTTP requests
///
/// This protocol abstracts network operations, allowing different implementations
/// for URLSession or Alamofire and facilitating testing with mocks
protocol HTTPClient {
    // Improvement for the future: add only one method for any HTTP method
    // with a ApiEndpoint parameter that provides all the information needed

    /// Performs a GET request to the specified URL
    ///
    /// - Parameter url: The target URL for the request
    /// - Returns: A decoded object of the specified type
    /// - Throws: Network or decoding errors
    ///
    /// - Note: The return type must conform to the Decodable protocol
    func get<T: Decodable>(_ url: URL) async throws -> T
    
    // Other HTTP Methods can be added here:
    // func post<T: Decodable>(_ url: URL) async throws -> T
    // func patch<T: Decodable>(_ url: URL) async throws -> T
}

/// Concrete implementation of HTTPClient using URLSession
///
/// This class uses the default iOS URLSession to perform HTTP requests
/// and automatically decodes JSON responses to the specified type
final class URLSessionHTTPClient: HTTPClient {
    func get<T: Decodable>(_ url: URL) async throws -> T {
        Logger.network("🚀 Starting GET request to: \(url.absoluteString)")
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            // Check for HTTP errors
            if let httpResponse = response as? HTTPURLResponse {
                Logger.network("📡 Response received - Status: \(httpResponse.statusCode)")
                
                if httpResponse.statusCode >= 400 {
                    Logger.error("❌ HTTP Error: \(httpResponse.statusCode)")
                    throw ApiError.serverError(statusCode: httpResponse.statusCode)
                }
            }
            
            Logger.network("📦 Data received - Size: \(data.count) bytes")
            
            // Attempt to decode the data
            do {
                let decoder = JSONDecoder()
                // Automatically convert from snake_case to camelCase preventing the need of CodingKeys implementation
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decodedObject = try decoder.decode(T.self, from: data)
                Logger.success("✅ Successfully decoded \(T.self)")
                return decodedObject
            } catch {
                Logger.error("❌ Decoding failed for \(T.self): \(error.localizedDescription)")
                throw ApiError.decodingError(error)
            }
            
        } catch let error as ApiError {
            Logger.error("❌ ApiError: \(error)")
            throw error
        } catch {
            Logger.error("❌ Network error: \(error.localizedDescription)")
            throw ApiError.networkError(error)
        }
    }
}
