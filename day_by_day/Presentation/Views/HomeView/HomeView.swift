//
//  HomeView.swift
//  day_by_day
//
//  Created by Mario Espasa Planells on 3/2/26.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @State var isShowingHabitSheet: Bool = false
    @Query(sort: \HabitModel.title) var habits: [HabitModel]
    var body: some View {
        NavigationStack {
            List(habits) { habit in
                ZStack {
                    NavigationLink(value: habit) {
                    }
                    .opacity(0)
                    HabitGrid(habit: habit)
                }
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
            }
            .listStyle(.plain)
            .navigationTitle("habits")
            .navigationDestination(for: HabitModel.self) { habit in
                HabitDetailView(habit: habit)
            }
            .sheet(isPresented: $isShowingHabitSheet) {
                HabitSheet()
            }
            .toolbar {
                if !habits.isEmpty {
                    ToolbarItem(placement: .primaryAction) {
                        Button(action: { isShowingHabitSheet = true }) {
                            Image(systemName: "plus")
                        }
                    }
                }

            }
            .overlay {
                if habits.isEmpty {
                    ContentUnavailableView(
                        label: {
                            Label(
                                "noHabitsAvailable",
                                systemImage: "list.bullet.rectangle.portrait"
                            )
                        },
                        description: {
                            Text("addNewHabit")
                        },
                        actions: {
                            Button("addHabit") {
                                isShowingHabitSheet = true
                            }
                        }
                    )
                }
            }
        }

    }
}

#Preview {
    HomeView()
}
