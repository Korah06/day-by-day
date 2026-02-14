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
            .navigationTitle("Habitos")
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
                                "No hay hábitos disponibles",
                                systemImage: "list.bullet.rectangle.portrait"
                            )
                        },
                        description: {
                            Text("Agrega un nuevo hábito")
                        },
                        actions: {
                            Button("Agregar Hábito") {
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
