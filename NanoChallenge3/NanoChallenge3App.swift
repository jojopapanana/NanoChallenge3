//
//  NanoChallenge3App.swift
//  NanoChallenge3
//
//  Created by Jovanna Melissa on 11/07/24.
//

import SwiftUI
import SwiftData

@main
struct NanoChallenge3App: App {
    var sharedModelContainer: ModelContainer = {
        // Define your schema
        let schema = Schema([
            Recipe.self,
            ImageAttribute.self
        ])
        
        // Create the ModelContainer
        do {
            return try ModelContainer(for: schema)
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            RecipeView()
                .modelContainer(sharedModelContainer)
        }
    }
}
