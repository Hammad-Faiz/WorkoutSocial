import SwiftUI

struct PostCardView: View {
  @ObservedObject var post: WorkoutPost

  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      HStack(spacing: 10) {
        Image(systemName: "person.crop.circle.fill")
          .resizable()
          .frame(width: 30, height: 30)
          .foregroundColor(.blue)

        VStack(alignment: .leading, spacing: 2) {
          Text(post.username)
            .font(.headline)
          Text(post.timestamp.formatted(.relative(presentation: .named)))
            .font(.caption)
            .foregroundColor(.gray)
        }
      }

      Image(uiImage: post.image)
        .resizable()
        .scaledToFit()
        .cornerRadius(10)

      Text(post.caption)
        .font(.body)
        .padding(.horizontal, 4)

      Button(action: {
        post.isLiked.toggle()
      }) {
        HStack {
          Image(systemName: post.isLiked ? "heart.fill" : "heart")
            .foregroundColor(post.isLiked ? .red : .secondary)
          Text("Like")
        }
      }
      .font(.caption)
      .padding(.top, 4)
    }
    .padding()
    .background(Color(.systemBackground).opacity(0.95))
    .cornerRadius(16)
    .shadow(radius: 2)
    .padding(.horizontal)
  }
}
