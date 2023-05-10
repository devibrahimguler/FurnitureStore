//
//  MobilyaDukkaniApp.swift
//  FurnitureStore
//
//  Created by İbrahim Güler on 29.05.2022.
//

import SwiftUI
import Firebase

@main
struct MobilyaDukkaniApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
