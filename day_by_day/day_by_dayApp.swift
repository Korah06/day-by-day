//
//  day_by_dayApp.swift
//  day_by_day
//
//  Created by Mario Espasa Planells on 2/2/26.
//

import SwiftData
import SwiftUI

@main
struct day_by_dayApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            HabitModel.self,
            CheckInModel.self,
        ])
        let modelConfiguration =
            ModelConfiguration(//            cloudKitDatabase: nil
            )

        do {
            return try ModelContainer(
                for: schema,
                configurations: [modelConfiguration]
            )
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
