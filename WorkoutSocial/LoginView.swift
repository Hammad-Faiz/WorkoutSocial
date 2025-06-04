import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var isLoggedIn = false

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
                    isLoggedIn = true
                }
                .padding()
                .buttonStyle(.borderedProminent)
            }
        }
    }
}