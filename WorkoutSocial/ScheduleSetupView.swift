import SwiftUI

struct ScheduleSetupView: View {
  @AppStorage("workoutDays") private var workoutDaysData: String = ""
  @State private var selectedDays: Set<String> = []

  private let daysOfWeek = ["S", "M", "T", "W", "T", "F", "S"]
  private let dayCodes = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]

  var body: some View {
    ZStack {
      Color.black.ignoresSafeArea()

      VStack(spacing: 32) {
        Text("Set Workout Days")
          .font(.system(size: 32, weight: .bold, design: .rounded))
          .foregroundColor(.green)

        Text("Which days do you plan to work out?")
          .foregroundColor(.white.opacity(0.8))
          .font(.subheadline)

        HStack(spacing: 18) {
          ForEach(0..<7) { index in
            let code = dayCodes[index]
            Button(action: {
              toggleDay(code)
            }) {
              Text(daysOfWeek[index])
                .font(.headline)
                .frame(width: 40, height: 40)
                .background(selectedDays.contains(code) ? Color.green : Color.clear)
                .foregroundColor(selectedDays.contains(code) ? .black : .white)
                .overlay(
                  Circle()
                    .stroke(Color.green, lineWidth: 2)
                )
                .clipShape(Circle())
            }
          }
        }

        Spacer()

        Button(action: {
          saveWorkoutDays()
        }) {
          Text("Confirm")
            .font(.headline)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.green)
            .foregroundColor(.black)
            .cornerRadius(16)
        }
        .padding(.horizontal)
      }
      .padding()
    }
    .onAppear {
      loadSavedDays()
    }
  }

  private func toggleDay(_ day: String) {
    if selectedDays.contains(day) {
      selectedDays.remove(day)
    } else {
      selectedDays.insert(day)
    }
  }

  private func saveWorkoutDays() {
    workoutDaysData = selectedDays.joined(separator: ",")
  }

  private func loadSavedDays() {
    selectedDays = Set(workoutDaysData.split(separator: ",").map { String($0) })
  }
}
