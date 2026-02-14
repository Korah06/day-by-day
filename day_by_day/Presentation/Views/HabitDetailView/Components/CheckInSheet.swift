//
//  CheckInSheet.swift
//  day_by_day
//
//  Created by Mario Espasa Planells on 14/2/26.
//

import SwiftUI

struct CheckInSheet: View {
<<<<<<< HEAD
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
=======

    @Environment(\.dismiss) private var dismiss
    let habit: HabitModel

    @State private var checkInDate: Date = Date()
    @State private var amount: Double = 1

    var body: some View {
        NavigationStack{
            Form{
                DatePicker("Fecha y Hora", selection: $checkInDate)

                LabeledContent {
                    TextField("Cantidad", value: $amount, formatter: NumberFormatter())
                        .multilineTextAlignment(.trailing)
                } label: {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Quantity")
                        Text("hours")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .navigationTitle("Check in")
            .navigationBarTitleDisplayMode(.large)
            .toolbar{

                ToolbarItemGroup(placement: .topBarTrailing){
                    Button("Guardar",role: .confirm){

                        let checkIn = CheckInModel(
                            id: UUID(), amount: amount, date: checkInDate
                        )
                        habit.checkIns.append(checkIn)
                        dismiss()
                    }
                }
            }
        }
>>>>>>> bebc1ac (Make historic sheet and ended habit detail view)
    }
}

#Preview {
<<<<<<< HEAD
    CheckInSheet()
=======
    CheckInSheet(habit: HabitModel(id: UUID(), title: "Example", colorHex: "#FF22FF", checkIns:[] ))
>>>>>>> bebc1ac (Make historic sheet and ended habit detail view)
}
