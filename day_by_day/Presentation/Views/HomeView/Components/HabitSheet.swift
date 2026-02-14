//
//  HabitSheet.swift
//  day_by_day
//
//  Created by Mario Espasa Planells on 9/2/26.
//

import SwiftUI
import SwiftData

struct HabitSheet: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) private var dismiss
    
    let habit: HabitModel?
    
    @State private var name: String
    @State private var color: Color
    
    init(habit: HabitModel? = nil) {
        self.habit = habit
        _name = State(initialValue: habit?.title ?? "")
        _color = State(initialValue: habit != nil ? Color(hex: habit!.colorHex) : .green)
    }
    
    private var isEditing: Bool {
        habit != nil
    }
    
    var body: some View {
        NavigationStack{
            Form{
                TextField("Nombre del habito", text:$name)
                ColorPicker("Color principal", selection: $color)
            }
            .navigationTitle(isEditing ? "Editar hábito" : "Nuevo hábito")
            .navigationBarTitleDisplayMode(.large)
            .toolbar{
                ToolbarItemGroup(placement: .topBarLeading){
                    Button("Cancelar",role: .cancel){
                        dismiss()
                    }
                }

                ToolbarItemGroup(placement: .topBarTrailing){
                    Button("Guardar",role: .confirm){
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
                                checkIns: []
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
    HabitSheet(habit: HabitModel(id: UUID(), title: "Example Habit", colorHex: "#FF5733", checkIns: []))
}

