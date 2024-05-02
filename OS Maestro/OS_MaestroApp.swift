//
//  OS_MaestroApp.swift
//  OS Maestro
//
//  Created by Zac Booth on 5/2/24.
//

import SwiftUI

@main
struct OSMaestroApp: App {
    
    // Define a key for UserDefaults
    let hasLaunchedKey = "hasLaunchedBefore"
    
    var body: some Scene {
        WindowGroup {
            // Check if the app has launched before
            if UserDefaults.standard.bool(forKey: hasLaunchedKey) {
                // If it has launched before, show ContentView
                ContentView()
            } else {
                // If it's the first launch, show Onboarding and set hasLaunched to true
                Onboarding()
                    .onAppear {
                        UserDefaults.standard.set(true, forKey: hasLaunchedKey)
                    }
            }
        }
    }
}
