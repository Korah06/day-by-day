//
//  HabitDetailView.swift
//  day_by_day
//
//  Created by Mario Espasa Planells on 11/2/26.
//

import SwiftUI
import SwiftData

struct HabitDetailView: View {
    let habit: HabitModel
    @State private var isButtonVisible = false
    @State private var showShadow = false
    @Environment(\.modelContext) private var modelContext
    
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
    }
    
    var body: some View {
        VStack {
            HabitGrid(habit: habit)

            HStack{
                VStack(spacing: 8) {
                    Text("\(currentStreak)")
                        .font(.system(size: 48, weight: .bold, design: .rounded))
                        .foregroundStyle(.black)

                    Text(currentStreak == 1 ? "Day Streak" : "Days Streak")
                        .font(.subheadline)
                        .foregroundStyle(.black.opacity(0.8))

                    HStack(spacing: 4) {
                        Image(systemName: "flame.fill")
                            .foregroundStyle(.orange)
                        Text("Keep it up!")
                            .font(.caption)
                            .foregroundStyle(.black.opacity(0.7))
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 24)
                .padding(.horizontal, 32)
                .glassEffect(.regular, in: .rect(cornerRadius: 16))
                .padding(.horizontal)
            }
            Spacer()

            Button(action: {
                // Create new check-in
                let newCheckIn = CheckInModel(
                    id: UUID(),
                    amount: 1,
                    date: Date.now
                )
                
                // Add to habit's check-ins array
                habit.checkIns.append(newCheckIn)
                
                // Insert into model context
                modelContext.insert(newCheckIn)
                
                // Animate shadow
                withAnimation(.easeOut(duration: 0.5)) {
                    showShadow = true
                }
                
                // Fade out the shadow after a brief moment
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    withAnimation(.easeOut(duration: 0.3)) {
                        showShadow = false
                    }
                }
            }) {
                Label("Check in", systemImage: "checkmark")
                    .font(.title3)
                    .padding(.horizontal,20)
                    .padding(.vertical,5)
            }
            .buttonStyle(.glassProminent)
            .shadow(
                color: Color.blue.opacity(showShadow ? 1 : 0),
                radius: showShadow ? 40 : 0,
                x: 0,
                y: 0
            )
            .padding()
            .scaleEffect(isButtonVisible ? 1 : 0.5)
            .opacity(isButtonVisible ? 1 : 0)
        }
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                isButtonVisible = true
            }
        }
    }
}

#Preview {
//    HabitDetailView()
}
