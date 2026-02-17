//
//  HabitUnit.swift
//  day_by_day
//
//  Created by Mario Espasa Planells on 17/2/26.
//

import Foundation

// MARK: - Unit Category

enum UnitCategory: String, Codable, CaseIterable {
    case none = "None"
    case time = "Time"
    case distance = "Distance"
    case weight = "Weight"
    case temperature = "Temperature"
    case energy = "Energy"

    var units: [HabitUnit] {
        HabitUnit.allCases.filter { $0.category == self }
    }
}

// MARK: - Unit

enum HabitUnit: String, Codable, CaseIterable {

    case none = "None"

    // MARK: Time
    case milliseconds = "ms"
    case seconds = "s"
    case minutes = "min"
    case hours = "h"
    case days = "d"
    case weeks = "wk"
    case months = "mo"
    case years = "yr"

    // MARK: Distance
    case millimeters = "mm"
    case centimeters = "cm"
    case meters = "m"
    case kilometers = "km"
    case inches = "in"
    case feet = "ft"
    case miles = "mi"
    case nauticalMiles = "nmi"

    // MARK: Weight
    case grams = "g"
    case kilograms = "kg"
    case pounds = "lb"

    // MARK: Temperature
    case celsius = "°C"
    case fahrenheit = "°F"
    case kelvin = "K"

    // MARK: Energy
    case calories = "cal"
    case kilocalories = "kcal"

    // MARK: - Display

    var symbol: String { rawValue }

    var label: String {
        switch self {
        case .none: return "None"
        // Time
        case .milliseconds: return "Milliseconds"
        case .seconds: return "Seconds"
        case .minutes: return "Minutes"
        case .hours: return "Hours"
        case .days: return "Days"
        case .weeks: return "Weeks"
        case .months: return "Months"
        case .years: return "Years"
        // Distance
        case .millimeters: return "Millimeters"
        case .centimeters: return "Centimeters"
        case .meters: return "Meters"
        case .kilometers: return "Kilometers"
        case .inches: return "Inches"
        case .feet: return "Feet"
        case .miles: return "Miles"
        case .nauticalMiles: return "Nautical Miles"
        // Weight
        case .grams: return "Grams"
        case .kilograms: return "Kilograms"
        case .pounds: return "Pounds"
        // Temperature
        case .celsius: return "Celsius"
        case .fahrenheit: return "Fahrenheit"
        case .kelvin: return "Kelvin"
        // Energy
        case .calories: return "Calories"
        case .kilocalories: return "Kilocalories"
        }
    }

    var category: UnitCategory {
        switch self {
        case .milliseconds, .seconds, .minutes, .hours,
            .days, .weeks, .months, .years:
            return .time
        case .millimeters, .centimeters, .meters, .kilometers,
            .inches, .feet, .miles, .nauticalMiles:
            return .distance
        case .grams, .kilograms, .pounds:
            return .weight
        case .celsius, .fahrenheit, .kelvin:
            return .temperature
        case .calories, .kilocalories:
            return .energy
        case .none: return .none
        }
    }
}
