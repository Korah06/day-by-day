//
//  HabitDetailView.swift
//  day_by_day
//
//  Created by Mario Espasa Planells on 11/2/26.
//

import SwiftUI
import SwiftData

struct HabitDetailView: View {
    @Environment(\.modelContext) private var modelContext
    let habit: HabitModel
    @State var isShowingCheckInSheet: Bool = false
    @State var isShowingHistoricCheckInSheet: Bool = false

    
    var body: some View {
        VStack {
            HabitGrid(habit: habit)
            CurrentStreakView(habit: habit)            
            Spacer()
            CheckInButton {
                isShowingCheckInSheet = true
            }
        }
        .navigationTitle(habit.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{

            ToolbarItem(placement: .topBarTrailing){
                Button(action: {
                    isShowingHistoricCheckInSheet = true
                }) {
                    Image(systemName: "calendar.badge.clock")
                }
            }
        }
        .sheet(isPresented: $isShowingCheckInSheet) {
            CheckInSheet(habit: habit)
                .presentationDetents([.medium])
        }
        .sheet(isPresented: $isShowingHistoricCheckInSheet) {
            HistoricCheckInSheet(habit: habit)
                .presentationDetents([.medium, .large])
        }
    }
}

#Preview {
//    HabitDetailView()
}
