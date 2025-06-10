import SwiftUI

struct LoadingView: View {
    var message: String? = nil
    
    var body: some View {
        VStack {
            ProgressView()
                .scaleEffect(1.5)
            Text(message ?? .empty)
                .foregroundColor(.secondary)
                .padding(.top)
        }
    }
}
