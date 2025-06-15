import SwiftUI

struct ConsistencyTrackerView: View {
  @EnvironmentObject var postStore: PostStore
  private let calendar = Calendar.current

  // MARK: - Data Preparation
  private var today: Date { calendar.startOfDay(for: Date()) }

  private var allDates: [Date] {
    // Get start date (29 days before today)
    let startDate = calendar.date(byAdding: .day, value: -29, to: today)!

    // Get the weekday of start date (0-6, where 0 is Sunday)
    let startWeekday = calendar.component(.weekday, from: startDate) - 1  // Convert to 0-6

    // Create array of 42 dates (6 weeks) to ensure proper grid alignment
    let totalDays = 42
    return (0..<totalDays).map { offset in
      calendar.date(byAdding: .day, value: offset - startWeekday, to: startDate)!
    }
  }

  private var checkedInDates: Set<Date> {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return Set(postStore.getCheckInDates().compactMap { formatter.date(from: $0) })
  }

  // MARK: - Layout Components
  private var weekdayHeaders: [String] {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.dateFormat = "EEEEE"  // Single character weekday

    // Always start with Sunday
    let startOfWeek = calendar.date(
      from:
        calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today))!

    return (0..<7).map { offset in
      let date = calendar.date(byAdding: .day, value: offset, to: startOfWeek)!
      return formatter.string(from: date)
    }
  }

  private var calendarGrid: some View {
    let columns = Array(repeating: GridItem(.flexible()), count: 7)

    return LazyVGrid(columns: columns, spacing: 12) {
      ForEach(allDates, id: \.self) { date in
        let isCheckedIn = checkedInDates.contains { calendar.isDate($0, inSameDayAs: date) }
        let isToday = calendar.isDate(date, inSameDayAs: today)
        let isInRange =
          date >= calendar.date(byAdding: .day, value: -29, to: today)! && date <= today

        Group {
          if isCheckedIn {
            Image(systemName: "checkmark.circle.fill")
              .foregroundColor(.green)
          } else if isToday {
            Circle()
              .stroke(Color.green, lineWidth: 2)
          } else if !isInRange {
            Circle()
              .opacity(0)
          } else {
            Circle()
              .stroke(Color.green.opacity(0.5), lineWidth: 1.5)
          }
        }
        .frame(width: 28, height: 28)
        .overlay(
          Text(calendar.component(.day, from: date).description)
            .font(.system(size: 10))
            .foregroundColor(isCheckedIn ? .white : .green)
        )
      }
    }
    .padding(.horizontal)
  }

  // MARK: - Main View
  var body: some View {
    ZStack {
      Color.black.ignoresSafeArea()

      VStack(spacing: 20) {
        // Header
        VStack(spacing: 4) {
          Text("Consistency")
            .font(.system(size: 32, weight: .heavy, design: .rounded))
            .foregroundColor(.green)

          Text("30-Day Streak")
            .font(.subheadline)
            .foregroundColor(.white.opacity(0.8))
        }
        .padding(.top, 20)

        // Weekday headers (always starts with Sunday)
        HStack(spacing: 0) {
          ForEach(weekdayHeaders, id: \.self) { day in
            Text(day)
              .font(.system(size: 14, weight: .bold))
              .foregroundColor(.white.opacity(0.7))
              .frame(maxWidth: .infinity)
          }
        }
        .padding(.horizontal)

        // Calendar grid
        calendarGrid

        // Progress
        Text("\(checkedInDates.count)/30 Workouts")
          .font(.system(size: 18, weight: .semibold))
          .foregroundColor(.white)
          .padding(.vertical, 12)
          .padding(.horizontal, 32)
          .background(Capsule().fill(Color.green))
          .padding(.bottom, 20)
      }
    }
  }
}
