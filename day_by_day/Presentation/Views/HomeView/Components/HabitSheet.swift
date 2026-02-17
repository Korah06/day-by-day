//
//  HabitSheet.swift
//  day_by_day
//
//  Created by Mario Espasa Planells on 9/2/26.
//

import SwiftData
import SwiftUI

struct HabitSheet: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) private var dismiss

    let habit: HabitModel?
    private let selectableColors: [Color] = [
        .red, .yellow, .blue, .purple, .green,
    ]

    @State private var name: String
    @State private var color: Color
    @State private var unit: HabitUnit
    @State private var isGradientByWorkout: Bool

    @State var isShowingColorPicker: Bool = false
    @State var isShowingUnitPicker: Bool = false

    init(habit: HabitModel? = nil) {
        self.habit = habit
        _name = State(initialValue: habit?.title ?? "")
        _color = State(
            initialValue: habit != nil ? Color(hex: habit!.colorHex) : .green
        )
        _unit = State(initialValue: habit?.unit ?? .none)
        _isGradientByWorkout = State(initialValue: habit?.gradientByWork ?? false)
    }

    private var isEditing: Bool {
        habit != nil
    }

    var body: some View {
        NavigationStack {
            Form {
                TextField("habitName", text: $name)
                //                ColorPicker("mainColor", selection: $color,supportsOpacity: false)
                HStack {
                    Text("mainColor")
                    Spacer()
                    Circle()
                        .fill(color)
                        .frame(width: 30, height: 30)
                }.onTapGesture {
                    isShowingColorPicker = true
                }
                Picker("Unit", selection: $unit) {
                    ForEach(UnitCategory.allCases, id: \.self) { category in
                        Section(category.rawValue) {
                            ForEach(category.units, id: \.self) { unit in
                                Text("\(unit.label) (\(unit.symbol))").tag(unit)
                            }
                        }
                    }
                }
                Toggle("gradientByQuantity",isOn: $isGradientByWorkout)
            }
            .sheet(isPresented: $isShowingColorPicker) {
                ColorPickerSheet(
                    selectedColor: $color
                )
                .presentationDetents([.medium])
            }
            .navigationTitle(isEditing ? "editHabit" : "newHabit")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button("cancel", role: .cancel) {
                        dismiss()
                    }
                }

                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("save", role: .confirm) {
                        if let existingHabit = habit {
                            // Edit existing habit
                            existingHabit.title = name
                            existingHabit.colorHex = color.toHex()
                        } else {
                            // Create new habit
                            let newHabit = HabitModel(
                                id: UUID.init(),
                                title: name,
                                colorHex: color.toHex(),
                                checkIns: [],
                                unit: unit,
                            )
                            context.insert(newHabit)
                        }
                        dismiss()
                    }
                    .disabled(name.isEmpty)
                }
            }
        }

    }
}

#Preview("New Habit") {
    HabitSheet()
}
#Preview("Edit Habit") {
    HabitSheet(
        habit: HabitModel(
            id: UUID(),
            title: "Example Habit",
            colorHex: "#FF5733",
            checkIns: [],
            unit: .none
        )
    )
}
