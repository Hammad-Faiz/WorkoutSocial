import Foundation
import SwiftUI

class PostStore: ObservableObject {
  @Published var posts: [WorkoutPost] = []

  @AppStorage("checkInDates") var checkInDates: String = ""  // comma-separated dates

  func addCheckIn(for date: Date = Date()) {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    let newDate = formatter.string(from: date)

    var dates = getCheckInDates()
    if !dates.contains(newDate) {
      dates.append(newDate)
      checkInDates = dates.joined(separator: ",")
    }
  }

  func getCheckInDates() -> [String] {
    return checkInDates.split(separator: ",").map { String($0) }
  }
}
