//
//  GestionaleApp.swift
//  Gestionale
//
//  Created by Felice Marano on 14/10/22.
//

import SwiftUI
import Firebase

@main
struct GestionaleApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            
            ContentView()
        }
    }
}
