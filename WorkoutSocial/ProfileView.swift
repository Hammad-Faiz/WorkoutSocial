import SwiftUI

struct ProfileView: View {
  @AppStorage("isLoggedIn") private var isLoggedIn: Bool = true
  @AppStorage("username") private var username: String = ""

  var body: some View {
    VStack(spacing: 20) {
      Text("Logged in as \(username)")
        .font(.title2)

      Button("Log Out") {
        isLoggedIn = false
        username = ""
      }
      .foregroundColor(.red)
      .padding()
      .buttonStyle(.bordered)

      Spacer()
    }
    .padding()
    .navigationTitle("Profile")
  }
}
