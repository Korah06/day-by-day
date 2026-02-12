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
    @State private var name: String = ""
    @State private var color: Color = .green
    var body: some View {
        NavigationStack{
            Form{
                TextField("Nombre del habito", text:$name)
                ColorPicker("Color principal", selection: $color)
            }
            .navigationTitle("Nuevo habito")
            .navigationBarTitleDisplayMode(.large)
            .toolbar{
                ToolbarItemGroup(placement: .topBarLeading){
                    Button("Cancelar",role: .cancel){
                        dismiss()
                    }
                }

                ToolbarItemGroup(placement: .topBarTrailing){
                    Button("Guardar",role: .confirm){
                        let habit = HabitModel(
                            id: UUID.init(),
                            title: name,
                            colorHex: color.toHex(),
                            checkIns: []
                        )
                        context.insert(habit)
                        dismiss()
                    }
                }
            }
        }

    }
}

#Preview {
    HabitSheet()
}
