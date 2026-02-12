//
//  ChckIn.swift
//  day_by_day
//
//  Created by Mario Espasa Planells on 3/2/26.
//

import Foundation

struct CheckIn: Identifiable, Codable, Equatable, Hashable{
    let id: UUID
    let amount: Double
    let date: Date
}
