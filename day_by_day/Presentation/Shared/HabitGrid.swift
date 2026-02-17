//
//  HabitGrid.swift
//  day_by_day
//
//  Created by Mario Espasa Planells on 4/2/26.
//

import SwiftUI

struct HabitGrid: View {
    let habit: HabitModel
    let isStatic: Bool = true
    let maxSquares = 105
    let rows = Array(
        repeating: GridItem(.fixed(15), spacing: 5),
        count: 7
    )
    @State private var animatedSquares: Set<Int> = []

    var body: some View {
        let dates: [Date] = generateArrayOfDates(
            today: Date(),
            maxSquares: maxSquares
        )

        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(habit.title)
                    .font(.title)
                Spacer()
                if isStatic {
                    Text("lastElevenWeeks")
                        .font(.caption)
                }

            }
            .padding(.vertical)

            HStack(spacing: 5) {
                ForEach(0..<17, id: \.self) { columnIndex in
                    VStack(spacing: 5) {
                        ForEach(0..<7, id: \.self) { rowIndex in
                            let index = columnIndex * 7 + rowIndex
                            if index < dates.count {
                                let date = dates[index]
                                let colorData = calculateColorAndBrightness(
                                    date: date,
                                    checkIns: habit.checkIns
                                )
                                RoundedRectangle(cornerRadius: 4)
                                    .foregroundColor(colorData.color)
                                    .frame(width: 17, height: 17)
                                    .shadow(
                                        color: Color(hex: habit.colorHex).opacity(colorData.brightness * 0.6),
                                        radius: colorData.brightness * 3,
                                        x: 0,
                                        y: 0
                                    )
                                    .scaleEffect(animatedSquares.contains(index) ? 1 : 0.1)
                                    .rotationEffect(.degrees(animatedSquares.contains(index) ? 0 : -180))
                                    .onAppear {
                                        withAnimation(.spring(response: 0.6, dampingFraction: 0.7).delay(Double(index) * 0.01)) {
                                            _ = animatedSquares.insert(index)
                                        }
                                    }
                            }
                        }
                    }
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(hex: habit.colorHex).opacity(0.07))
        )
        .padding()


    }

    func generateArrayOfDates(today: Date, maxSquares: Int) -> [Date] {
        let today = Date()
        let calendar = Calendar.current
        var dates: [Date] = []

        let weekdayInt = calendar.component(.weekday, from: today)

        let usedSquares: Int = {
            if let weekday = Weekday(rawValue: weekdayInt) {
                switch weekday {
                case .monday:
                    return maxSquares-6
                case .tuesday:
                    return maxSquares-5
                case .wednesday:
                    return maxSquares-4
                case .thursday:
                    return maxSquares-3
                case .friday:
                    return maxSquares-2
                case .saturday:
                    return maxSquares-1
                default:
                    return maxSquares
                }
            }
            return maxSquares
        }()

        let remainingDays = maxSquares - usedSquares

        for dayOffset in (0..<usedSquares).reversed() {
            if let date = calendar.date(
                byAdding: .day,
                value: -dayOffset,
                to: today
            ) {
                dates.append(date)
            }
        }

        for dayOffset in 1...remainingDays {
            if let date = calendar.date(
                byAdding: .day,
                value: dayOffset,
                to: today
            ) {
                dates.append(date)
            }
        }

        return dates
    }

    func calculateColorAndBrightness(date: Date, checkIns: [CheckInModel]) -> (color: Color, brightness: Double) {
        let today = Date()
        var totalAmount: Double = 0
        var thereIsCheckInToday: Bool = false
        
        for checkIn in checkIns {
            if Calendar.current.isDate(checkIn.date, inSameDayAs: date) {
                thereIsCheckInToday = true
                totalAmount += checkIn.amount
            }
        }
        
        let habitColor = Color(hex: habit.colorHex)
        
        if thereIsCheckInToday {
            // Calculate brightness based on amount (0-10 scale)
            let brightness = min(totalAmount / 10.0, 1.0)
            return (habitColor.opacity(brightness), brightness)
        } else if date < today {
            return (Color.gray.opacity(0.5), 0)
        } else {
            return (Color.clear, 0)
        }
    }
}

#Preview {
    HabitGrid(
        habit: HabitModel(
            id: UUID(),
            title: "Read a Book",
            colorHex: "#121212",
            checkIns: [
                CheckInModel(
                    id: UUID(),
                    amount: 30,
                    date: Date().addingTimeInterval(-6 * 86400)
                ),
                CheckInModel(
                    id: UUID(),
                    amount: 30,
                    date: Date().addingTimeInterval(-6 * 86400)
                ),
                CheckInModel(
                    id: UUID(),
                    amount: 30,
                    date: Date().addingTimeInterval(-6 * 86400)
                ),
                CheckInModel(
                    id: UUID(),
                    amount: 30,
                    date: Date().addingTimeInterval(-6 * 86400)
                ),
                CheckInModel(
                    id: UUID(),
                    amount: 30,
                    date: Date().addingTimeInterval(-6 * 86400)
                ),
                CheckInModel(
                    id: UUID(),
                    amount: 30,
                    date: Date().addingTimeInterval(-6 * 86400)
                ),
                CheckInModel(id: UUID(), amount: 40, date: Date()),
            ], unit:.none
        )
    )
}
