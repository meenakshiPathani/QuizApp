//
//  QuizAppApp.swift
//  QuizApp
//
//  Created by Meenakshi Pathani on 14/06/25.
//

import SwiftUI
import SwiftData

@main
struct QuizApp: App {
        
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            QuizQuestion.self,
            QuizOption.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            HomeView()
                .onAppear(){
                    // Delay to ensure model context is ready
                    DispatchQueue.main.async() {
                        QuizManager.shared.importQuizDataIfFirstLaunch(context: sharedModelContainer.mainContext)
                    }
                }
        }
        .modelContainer(sharedModelContainer)
    }
    

}
