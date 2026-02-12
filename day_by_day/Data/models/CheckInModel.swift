//
//  CheckInModel.swift
//  day_by_day
//
//  Created by Mario Espasa Planells on 9/2/26.
//

import Foundation
import SwiftData

@Model
class CheckInModel {
    @Attribute(.unique) var id: UUID
    var amount: Double
    var date: Date

    init(id: UUID, amount: Double, date: Date) {
        self.id = id
        self.amount = amount
        self.date = date
    }
}
