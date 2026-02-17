//
//  UnitPickerSheet.swift
//  day_by_day
//
//  Created by Mario Espasa Planells on 17/2/26.
//

import SwiftUI

struct UnitPickerSheet: View {
    @Binding var unit: HabitUnit

    var body: some View {
        Picker("Unit", selection: $unit) {
            ForEach(UnitCategory.allCases, id: \.self) { category in
                Section(category.rawValue) {
                    ForEach(category.units, id: \.self) { unit in
                        Text("\(unit.label) (\(unit.symbol))").tag(unit)
                    }
                }
            }
        }
    }
}

#Preview {
//    UnitPickerSheet()
}
