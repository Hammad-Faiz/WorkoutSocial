import SwiftUI

struct FeedView: View {
  @EnvironmentObject var postStore: PostStore

  var body: some View {
    NavigationView {
      ScrollView {
        LazyVStack(spacing: 20) {
          ForEach(postStore.posts) { post in
            VStack(alignment: .leading, spacing: 12) {
              // Profile info row
              HStack(spacing: 12) {
                Image(systemName: "person.circle.fill")
                  .resizable()
                  .frame(width: 40, height: 40)
                  .foregroundColor(.blue)

                VStack(alignment: .leading, spacing: 2) {
                  Text(post.username)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                  Text(post.timestamp, style: .date)
                    .font(.caption)
                    .foregroundColor(.secondary)
                }

                Spacer()
              }

              // Workout image
              Image(uiImage: post.image)
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 300)
                .cornerRadius(12)

              // Caption
              Text(post.caption)
                .font(.body)
                .padding(.horizontal, 4)

              // Like button
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
            .background(Color(.systemGray6))
            .cornerRadius(16)
            .padding(.horizontal)
          }
        }
        .padding(.top)
      }
      .navigationTitle("WorkoutSocial")
      .navigationBarItems(trailing:
        Button(action: {
          // Go to profile screen later
        }) {
          Image(systemName: "person.crop.circle")
            .font(.title2)
        }
      )
    }
  }
}

