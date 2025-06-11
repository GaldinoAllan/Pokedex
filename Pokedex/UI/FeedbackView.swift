import SwiftUI

struct FeedbackView: View {
    var imageName: String = "exclamationmark.triangle"
    var title: String = "Oops! Something went wrong"
    var description: String = "Sorry, couldn't reach what you were looking for at this moment, try again later"
    var buttonTitle: String = "Try Again"
    var onButtonTap: () -> Void
    
    var body: some View {
        VStack(spacing: Layout.Spacing.large) {
            Image(systemName: imageName)
                .font(.system(size: Layout.Frame.iconSize))
                .foregroundColor(.orange)
            
            Text(title)
                .font(.headline)
            
            Text(description)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
            
            Button(buttonTitle) {
                onButtonTap()
            }
            .buttonStyle(.borderedProminent)
        }
    }
}