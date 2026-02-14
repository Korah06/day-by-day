//
//  HistoricCheckInView.swift
//  day_by_day
//
//  Created by Mario Espasa Planells on 14/2/26.
//

import SwiftUI
import SwiftData

struct HistoricCheckInSheet: View {
    @Environment(\.modelContext) private var modelContext
    let habit: HabitModel
    @State private var editingCheckIn: CheckInModel?
    
    var sortedCheckIns: [CheckInModel] {
        habit.checkIns.sorted { $0.date > $1.date }
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(sortedCheckIns) { checkIn in
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(checkIn.date, style: .date)
                                .font(.headline)
                            Text(checkIn.date, style: .time)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        
                        Spacer()
                        
                        Text("\(checkIn.amount, specifier: "%.1f")")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color(hex: habit.colorHex))
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        editingCheckIn = checkIn
                    }
                }
                .onDelete(perform: deleteCheckIns)
            }
            .navigationTitle("Check-in History")
            .navigationBarTitleDisplayMode(.inline)
            .overlay {
                if sortedCheckIns.isEmpty {
                    ContentUnavailableView(
                        "No Check-ins Yet",
                        systemImage: "calendar.badge.clock",
                        description: Text("Start tracking your habit to see history here")
                    )
                }
            }
            .sheet(item: $editingCheckIn) { checkIn in
                EditCheckInSheet(checkIn: checkIn)
            }
        }
    }
    
    private func deleteCheckIns(at offsets: IndexSet) {
        for index in offsets {
            let checkIn = sortedCheckIns[index]
            if let habitIndex = habit.checkIns.firstIndex(where: { $0.id == checkIn.id }) {
                habit.checkIns.remove(at: habitIndex)
                modelContext.delete(checkIn)
            }
        }
    }
}

// MARK: - Edit CheckIn Sheet
struct EditCheckInSheet: View {
    @Environment(\.dismiss) private var dismiss
    let checkIn: CheckInModel
    
    @State private var date: Date
    @State private var amount: Double
    
    init(checkIn: CheckInModel) {
        self.checkIn = checkIn
        _date = State(initialValue: checkIn.date)
        _amount = State(initialValue: checkIn.amount)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                DatePicker("Date & Time", selection: $date)
                
                LabeledContent {
                    TextField("Amount", value: $amount, formatter: NumberFormatter())
                        .multilineTextAlignment(.trailing)
                } label: {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("hours")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Text("Quantity")
                    }
                }
            }
            .navigationTitle("Edit Check-in")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        checkIn.date = date
                        checkIn.amount = amount
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    HistoricCheckInSheet(habit: HabitModel(id: UUID(), title: "Example", colorHex: "#FF22FF", checkIns:[
        CheckInModel(
            id: UUID(),
            amount: 30,
            date: Date().addingTimeInterval(-6 * 86400)
        ),
        CheckInModel(id: UUID(), amount: 40, date: Date()),
    ] ))
}
