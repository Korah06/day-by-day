//
//  HabitModel.swift
//  day_by_day
//
//  Created by Mario Espasa Planells on 9/2/26.
//

import Foundation
import SwiftData

@Model
class HabitModel {
    @Attribute(.unique) var id: UUID
    var title: String
    var colorHex: String
    var gradientByWork: Bool = false
    var unit: HabitUnit = HabitUnit.none
    @Relationship(deleteRule: .cascade)
    var checkIns: [CheckInModel]

    init(id: UUID, title: String, colorHex:String, checkIns: [CheckInModel], unit: HabitUnit, gradientByWork: Bool = false) {
        self.title = title
        self.id = id
        self.colorHex = colorHex
        self.checkIns = checkIns
        self.unit = unit
        self.gradientByWork = gradientByWork
    }
}
