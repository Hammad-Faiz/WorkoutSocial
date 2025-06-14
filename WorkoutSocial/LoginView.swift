import SwiftUI

struct LoginView: View {
  @AppStorage("username") private var username: String = ""
  @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false

  init() {
    // Temporary for testing: force logout every time
    isLoggedIn = false
    username = ""
  }

  var body: some View {
    if isLoggedIn {
      MainTabView()
    } else {
      VStack(spacing: 20) {
        Text("WorkoutSocial")
          .font(.largeTitle)
          .bold()

        TextField("Enter username", text: $username)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .padding(.horizontal)

        Button("Login") {
          if !username.trimmingCharacters(in: .whitespaces).isEmpty {
            isLoggedIn = true
          }
        }
        .disabled(username.trimmingCharacters(in: .whitespaces).isEmpty)
        .padding()
        .buttonStyle(.borderedProminent)
      }
    }
  }
}
