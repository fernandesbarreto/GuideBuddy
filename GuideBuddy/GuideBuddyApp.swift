//
//  GuideBuddyApp.swift
//  GuideBuddy
//
//  Created by Pedro Fernandes Barreto Costa on 26/08/24.
//

import SwiftUI

@main
struct GuideBuddyApp: App {
    @StateObject private var languageManager = LanguageManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
            //Login()
              .environmentObject(languageManager)
        }
        .modelContainer(for: [Prompt.self, ProfilePhoto.self, BackgroundPhoto.self, User.self, ItemEntity.self])
    }
}
