//
//  WorkoutSocialApp.swift
//  WorkoutSocial
//
//  Created by Hammad Faiz on 6/3/25.
//

import SwiftUI
import UserNotifications

@main
struct WorkoutSocialApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var postStore = PostStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)  // Force dark mode for MVP
                .environmentObject(postStore)
        }
    }
}

// MARK: - AppDelegate to handle notifications in foreground
class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
  ) -> Bool {
    UNUserNotificationCenter.current().delegate = self

    // 🧠 Read stored values
    let workoutDays = UserDefaults.standard.string(forKey: "workoutDays") ?? ""
    let selectedDays = Set(workoutDays.split(separator: ",").map { String($0) })

    let timeInterval = UserDefaults.standard.double(forKey: "reminderTime")
    if !selectedDays.isEmpty && timeInterval > 0 {
      let reminderTime = Date(timeIntervalSince1970: timeInterval)
      NotificationManager.shared.scheduleWorkoutReminders(for: selectedDays, time: reminderTime)
    }

    return true
  }

  // Show banner and sound even when app is open
  func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
  ) {
    completionHandler([.banner, .sound])
  }
}
