import SwiftUI

struct AvatarView: View {
    var avatar: Result<Image, Error>?
    @ScaledMetric var imageSize: CGFloat = 48
    
    var body: some View {
        Group {
            if let image = try? avatar?.get() {
                image.resizable()
            } else {
                Image(systemName: "person.fill").resizable()
            }
        }
        .background(.blue.gradient.secondary)
        .cornerRadius(imageSize/8)
        .frame(width: imageSize, height: imageSize)
    }
}

#Preview {
    AvatarView()
}
