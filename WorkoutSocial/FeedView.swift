import SwiftUI

struct FeedView: View {
    let mockPosts = ["Push Day 💪", "Morning Run 🏃‍♂️", "Leg Day Killer 🦵"]

    var body: some View {
        NavigationView {
            List(mockPosts, id: \.self) { post in
                HStack {
                    Image(systemName: "photo")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding(.trailing, 10)
                    Text(post)
                }
                .padding(.vertical, 5)
            }
            .navigationTitle("Feed")
        }
    }
}