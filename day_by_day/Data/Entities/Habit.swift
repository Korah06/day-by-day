//
//  Habit.swift
//  day_by_day
//
//  Created by Mario Espasa Planells on 3/2/26.
//

import Foundation

struct Habit: Identifiable, Codable, Equatable, Hashable {
    let id: UUID
    let title: String
    let description: String
    let checkIns: [CheckIn]

    init(id: UUID, title: String, description: String, checkIns: [CheckIn]) {
        self.title = title
        self.description = description
        self.id = id
        self.checkIns = checkIns
    }
}
