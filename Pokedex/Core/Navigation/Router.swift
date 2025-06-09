import SwiftUI

/// Router that manages navigation throughout the app
///
/// This class centralizes navigation logic, making it easier to manage complex navigation flows
@MainActor
final class Router: ObservableObject {
    /// Navigation path for managing the navigation stack
    @Published var navigationPath = NavigationPath()
    
    /// Navigates to a specific destination
    ///
    /// - Parameter destination: The destination to navigate to
    func navigate(to destination: AppDestination) {
        navigationPath.append(destination)
    }
    
    // Other methods could be added but they are not in use in the current app, for example:
    // func navigateBack()
    // func navigateToRoot()
}
