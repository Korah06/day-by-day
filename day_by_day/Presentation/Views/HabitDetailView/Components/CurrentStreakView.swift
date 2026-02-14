//
//  CurrentStreakView.swift
//  day_by_day
//
//  Created by Mario Espasa Planells on 14/2/26.
//

import SwiftUI

struct CurrentStreakView: View {
<<<<<<< HEAD
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
=======

    let habit: HabitModel

    var body: some View {
        HStack{
            VStack(spacing: 8) {
                Text("\(currentStreak)")
                    .font(.system(size: 48, weight: .bold, design: .rounded))
                    .foregroundStyle(.black)



                HStack(spacing: 4) {
                    
                    Image(systemName: "flame.fill")
                        .foregroundStyle(.orange)
                    Text(currentStreak == 1 ? "Day Streak" : "Days Streak")
                        .font(.subheadline)
                        .foregroundStyle(.black.opacity(0.8))
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .padding(.horizontal, 32)
            .glassEffect(.regular, in: .rect(cornerRadius: 16))
            .padding(.horizontal)
        }
    }

    var currentStreak: Int {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())

        // Sort check-ins by date in descending order
        let sortedCheckIns = habit.checkIns.sorted { $0.date > $1.date }

        guard !sortedCheckIns.isEmpty else { return 0 }

        var streak = 0
        var currentDate = today

        // Check if there's a check-in for each consecutive day
        for checkIn in sortedCheckIns {
            let checkInDay = calendar.startOfDay(for: checkIn.date)

            if checkInDay == currentDate {
                streak += 1
                // Move to the previous day
                if let previousDay = calendar.date(byAdding: .day, value: -1, to: currentDate) {
                    currentDate = previousDay
                }
            } else if checkInDay < currentDate {
                // Gap found, streak is broken
                break
            }
        }

        return streak
>>>>>>> bebc1ac (Make historic sheet and ended habit detail view)
    }
}

#Preview {
<<<<<<< HEAD
    CurrentStreakView()
=======
    CurrentStreakView( habit: HabitModel(id: UUID(), title: "Example", colorHex: "#FF22FF", checkIns:[] ))
>>>>>>> bebc1ac (Make historic sheet and ended habit detail view)
}
