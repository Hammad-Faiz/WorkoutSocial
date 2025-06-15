import Foundation
import UserNotifications

class NotificationManager {
  static let shared = NotificationManager()

  func requestPermission() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
      granted, _ in
      if granted {
        print("✅ Notifications authorized")
      } else {
        print("❌ Notifications not authorized")
      }
    }
  }

  func scheduleWorkoutReminders(for selectedDays: Set<String>, time: Date) {
    let weekdayMap = [
      "Sun": 1, "Mon": 2, "Tue": 3, "Wed": 4,
      "Thu": 5, "Fri": 6, "Sat": 7,
    ]

    let weekdays = selectedDays.compactMap { weekdayMap[$0] }

    let calendar = Calendar.current
    let timeComponents = calendar.dateComponents([.hour, .minute], from: time)

    // Clear previous notifications
    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()

    for weekday in weekdays {
      var dateComponents = DateComponents()
      dateComponents.weekday = weekday  // 1 = Sunday, etc.
      dateComponents.hour = timeComponents.hour
      dateComponents.minute = timeComponents.minute

      let content = UNMutableNotificationContent()
      content.title = "🏋️ Time to Work Out"
      content.body = "Stay consistent! Check in your workout today."
      content.sound = .default

      let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

      let request = UNNotificationRequest(
        identifier: "workoutReminder-\(weekday)",
        content: content,
        trigger: trigger
      )

      UNUserNotificationCenter.current().add(request)
    }

    print(
      "🔔 Scheduled reminders for weekdays: \(weekdays) at \(timeComponents.hour ?? 0):\(timeComponents.minute ?? 0)"
    )
  }
}
