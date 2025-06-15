import SwiftUI

struct LoginView: View {
  @AppStorage("username") private var username: String = ""
  @AppStorage("password") private var password: String = ""
  @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false

  @State private var inputUsername: String = ""
  @State private var inputPassword: String = ""

  var body: some View {
    ZStack {
      Color.black.ignoresSafeArea()

      VStack(spacing: 24) {
        Text("Login")
          .font(.system(size: 32, weight: .bold, design: .rounded))
          .foregroundColor(.green)

        TextField("Username", text: $inputUsername)
          .padding()
          .background(Color(.darkGray))
          .foregroundColor(.white)
          .cornerRadius(10)
          .autocapitalization(.none)

        SecureField("Password", text: $inputPassword)
          .padding()
          .background(Color(.darkGray))
          .foregroundColor(.white)
          .cornerRadius(10)

        Button(action: {
          username = inputUsername
          password = inputPassword
          isLoggedIn = true
        }) {
          Text("Log In")
            .font(.headline)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.green)
            .foregroundColor(.black)
            .cornerRadius(12)
        }
      }
      .padding(.horizontal, 32)
    }
  }
}
