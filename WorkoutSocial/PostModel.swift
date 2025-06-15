import Foundation
import SwiftUI

class WorkoutPost: Identifiable, Equatable, ObservableObject {
  let id = UUID()
  let image: UIImage
  let caption: String
  let username: String
  let timestamp: Date

  @Published var isLiked: Bool = false

  init(image: UIImage, caption: String, username: String, timestamp: Date) {
    self.image = image
    self.caption = caption
    self.username = username
    self.timestamp = timestamp
  }

  static func == (lhs: WorkoutPost, rhs: WorkoutPost) -> Bool {
    lhs.id == rhs.id
  }

}

// class PostStore: ObservableObject {
//   @Published var posts: [WorkoutPost] = []
// }
