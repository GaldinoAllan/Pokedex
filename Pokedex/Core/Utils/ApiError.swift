import Foundation

/// Custom API errors enum that provides specific error cases for different API failures,
/// making it easier to handle and display appropriate error messages
enum ApiError: Error, Equatable {
    /// JSON decoding failed due to invalid or bad data
    ///
    /// - Parameter error: Exact error that occured for more context
    case decodingError(_ error: Error?)
    
    /// Network request failed (no internet, timeout, etc.)
    ///
    /// - Parameter error: Exact error that occured for more context
    case networkError(_ error: Error?)
    
    /// Invalid URL provided for the request
    case invalidURL
    
    /// Server returned an error response
    ///
    /// - Parameter statusCode: Exact status for the errors status >= 400
    case serverError(statusCode: Int)
    
    /// No data received from the server
    case noData
    
    /// Unknown error occurred
    ///
    /// - Parameter error: Exact error that occured for more context
    case unknown(_ error: Error?)
    
    // MARK: - Equatable Implementation
    /// Error is not Equatable, thats why we need this implementation
    static func == (lhs: ApiError, rhs: ApiError) -> Bool {
        switch (lhs, rhs) {
        case (.decodingError, .decodingError),
             (.networkError, .networkError),
             (.invalidURL, .invalidURL),
             (.noData, .noData),
             (.serverError, .serverError),
             (.unknown, .unknown):
            return true
        default:
            return false
        }
    }
}
