import SwiftUI

struct FeedView: View {
  @EnvironmentObject var postStore: PostStore

  var body: some View {
    NavigationView {
      ZStack {
        Color.black.ignoresSafeArea()

        ScrollView {
          LazyVStack(spacing: 20) {
            ForEach(postStore.posts) { post in
              VStack(alignment: .leading, spacing: 12) {
                // Profile Info Row
                HStack(spacing: 12) {
                  Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 36, height: 36)
                    .foregroundColor(.white)

                  VStack(alignment: .leading, spacing: 2) {
                    Text(post.username)
                      .font(.subheadline)
                      .fontWeight(.semibold)
                      .foregroundColor(.white)

                    Text(post.timestamp, style: .relative)
                      .font(.caption)
                      .foregroundColor(.gray)
                  }

                  Spacer()
                }

                // Caption
                if !post.caption.isEmpty {
                  Text(post.caption)
                    .foregroundColor(.white)
                    .font(.body)
                }

                // Image + Like button
                ZStack(alignment: .bottomLeading) {
                  Image(uiImage: post.image)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(12)

                  Button(action: {
                    post.isLiked.toggle()
                  }) {
                    HStack {
                      Image(systemName: post.isLiked ? "heart.fill" : "heart")
                      Text("Like")
                    }
                    .padding(8)
                    .background(Color.black.opacity(0.6))
                    .foregroundColor(.white)
                    .font(.caption)
                    .cornerRadius(10)
                    .padding(8)
                  }
                }
              }
              .padding()
              .background(Color(.secondarySystemBackground))
              .cornerRadius(16)
              .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
              .padding(.horizontal)
            }
          }
          .padding(.top)
        }
      }
      .navigationTitle("WorkoutSocial")
      .navigationBarTitleDisplayMode(.inline)
      .navigationBarItems(
        trailing:
          Button(action: {
            // Navigate to profile or settings
          }) {
            Image(systemName: "person.crop.circle")
              .font(.title2)
              .foregroundColor(.white)
          }
      )
    }
  }
}
