import SwiftUI

struct ProfileView: View {
  @AppStorage("username") private var username: String = ""
  @State private var navigateToChat = false
  @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
  @AppStorage("password") private var password: String = ""


  var body: some View {
    NavigationStack {
      VStack(spacing: 24) {
        Text("Welcome, \(username)")
          .font(.title2)
          .fontWeight(.semibold)
          .foregroundColor(.white)

        NavigationLink("Set Workout Schedule", destination: ScheduleSetupView())
          .buttonStyle(BlueButtonStyle())

        NavigationLink("View Consistency Tracker", destination: ConsistencyTrackerView())
          .buttonStyle(GreenButtonStyle())

        // Clean Chat Navigation
        NavigationLink(destination: GroupChatView(), isActive: $navigateToChat) {
          Button("Go to Group Chat") {
            navigateToChat = true
          }
          .buttonStyle(GreenButtonStyle())
        }

        Spacer()
          
      Button("Log Out") {
        isLoggedIn = false
        username = ""
        password = ""
      }
      .foregroundColor(.red)

      }
      .padding()
      .navigationTitle("Profile")
    }
  }

  // Simple custom button styles
  struct BlueButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
      configuration.label
        .foregroundColor(.white)
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.blue)
        .cornerRadius(12)
        .scaleEffect(configuration.isPressed ? 0.98 : 1)
    }
  }

  struct GreenButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
      configuration.label
        .foregroundColor(.black)
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.green)
        .cornerRadius(12)
        .scaleEffect(configuration.isPressed ? 0.98 : 1)
    }
  }
}
