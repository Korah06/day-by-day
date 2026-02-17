//
//  CheckInSheet.swift
//  day_by_day
//
//  Created by Mario Espasa Planells on 14/2/26.
//

import SwiftUI

struct CheckInSheet: View {

    @Environment(\.dismiss) private var dismiss
    let habit: HabitModel

    @State private var checkInDate: Date = Date()
    @State private var amount: Double = 1

    var body: some View {
        NavigationStack{
            Form{
                DatePicker("dateAndTime", selection: $checkInDate)

                LabeledContent("quantity (\(habit.unit.rawValue))") {
                    TextField("amount", value: $amount, formatter: NumberFormatter())
                        .multilineTextAlignment(.trailing)
                }
            }
            .navigationTitle("checkIn")
            .navigationBarTitleDisplayMode(.large)
            .toolbar{
                ToolbarItemGroup(placement: .topBarLeading){
                    Button("cancel",role: .cancel){
                        dismiss()
                    }
                }

                ToolbarItemGroup(placement: .topBarTrailing){
                    Button("save",role: .confirm){

                        let checkIn = CheckInModel(
                            id: UUID(), amount: amount, date: checkInDate
                        )
                        habit.checkIns.append(checkIn)
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    CheckInSheet(
        habit: HabitModel(
            id: UUID(),
            title: "Example",
            colorHex: "#FF22FF",
            checkIns:[],
            unit: .none
        )
    )
}
