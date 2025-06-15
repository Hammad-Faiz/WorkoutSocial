//
//  ContentView.swift
//  WorkoutSocial
//
//  Created by Hammad Faiz on 6/3/25.
//

import SwiftUI

struct ContentView: View {
  @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false

  var body: some View {
    if isLoggedIn {
      MainTabView()
    } else {
      LoginView()
    }
  }
}
