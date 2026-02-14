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
    @State var isShowingHabitModal: Bool = false

    
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

            ToolbarItemGroup(placement: .topBarTrailing){
                Button(action: {
                    isShowingHistoricCheckInSheet = true
                }) {
                    Image(systemName: "calendar.badge.clock")
                }
                Button(role:.confirm,action: {
                    isShowingHabitModal = true
                }) {
                    Image(systemName: "pencil")
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
        .sheet(isPresented: $isShowingHabitModal) {
            HabitSheet(habit: habit)
                .presentationDetents([.medium, .large])
        }
    }
}

#Preview {
//    HabitDetailView()
}
