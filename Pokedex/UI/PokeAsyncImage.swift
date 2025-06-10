import SwiftUI

struct PokeAsyncImage: View {
    let url: URL?
    let size: CGFloat
    
    init(url: URL?, size: CGFloat = 200) {
        self.url = url
        self.size = size
    }
    
    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .success(let image):
                image.resizable().scaledToFit()
            case .failure(_):
                Image(systemName: "photo").foregroundColor(.gray)
            case .empty:
                ProgressView()
            @unknown default:
                EmptyView()
            }
        }
        .frame(width: size, height: size)
    }
}
#Preview {
    VStack(spacing: 20) {
        PokeAsyncImage(url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"))
    }
    .padding()
}
