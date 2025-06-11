import SwiftUI

struct LoadingView: View {
    var message: String? = nil
    
    // MARK: - Constants
    private enum Constants {
        static let progressViewScale: CGFloat = 1.5
    }
    
    var body: some View {
        VStack {
            ProgressView()
                .scaleEffect(Constants.progressViewScale)
            Text(message ?? .empty)
                .foregroundColor(.secondary)
                .padding(.top)
        }
    }
}
