import Foundation

/// Enum that represents different states of the UI during asynchronous operations
///
/// This enum is used to manage UI states in operations that can fail,
/// such as network requests, following the common pattern in reactive architectures
///
/// - idle: Initial state, no operation has been started
/// - loading: Operation in progress
/// - success: Operation completed successfully, contains the data
/// - failure: Operation failed, contains the ApiError
enum UIState<T> {
    case idle
    case loading
    case success(data: T)
    case failure(error: ApiError)
}
