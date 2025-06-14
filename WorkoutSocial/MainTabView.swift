import SwiftUI

struct MainTabView: View {
  @AppStorage("isLoggedIn") private var isLoggedIn: Bool = true
  @AppStorage("username") private var username: String = ""

  @StateObject var postStore = PostStore()

  var body: some View {
    TabView {
      FeedView()
        .environmentObject(postStore)
        .tabItem {
          Label("Feed", systemImage: "house")
        }

      PostView()
        .environmentObject(postStore)
        .tabItem {
          Label("Post", systemImage: "plus.circle")
        }

      ProfileView()
        .tabItem {
          Label("Profile", systemImage: "person.crop.circle")
        }
      Button("Log Out") {
        isLoggedIn = false
        username = ""
      }
      .padding()
      .foregroundColor(.red)
    }
  }
}
