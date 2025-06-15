import SwiftUI

struct ProfileView: View {
  @AppStorage("username") private var username: String = ""
  @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false

  var body: some View {
    NavigationView {
      VStack(spacing: 24) {
        Text("Welcome, \(username)")
          .font(.title2)
          .fontWeight(.semibold)

        NavigationLink(destination: ScheduleSetupView()) {
          Text("Set Workout Schedule")
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(12)
            .padding(.horizontal)
        }

        NavigationLink(destination: ConsistencyTrackerView()) {
          Text("View Consistency Tracker")
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.green)
            .foregroundColor(.black)
            .cornerRadius(12)
        }
        .padding(.horizontal)

        Spacer()

        Button("Log Out") {
          isLoggedIn = false
          username = ""
        }
        .foregroundColor(.red)
      }
      .padding()
      .navigationTitle("Profile")
      .navigationBarTitleDisplayMode(.inline)
    }
  }
}
