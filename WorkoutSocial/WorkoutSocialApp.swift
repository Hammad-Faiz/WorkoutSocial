//
//  WorkoutSocialApp.swift
//  WorkoutSocial
//
//  Created by Hammad Faiz on 6/3/25.
//

import SwiftUI

@main
struct WorkoutSocialApp: App {
  @StateObject var postStore = PostStore()

  var body: some Scene {
    WindowGroup {
      LoginView()
        .preferredColorScheme(.dark)
        .environmentObject(postStore)
    }
  }
}
