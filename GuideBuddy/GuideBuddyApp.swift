//
//  GuideBuddyApp.swift
//  GuideBuddy
//
//  Created by Pedro Fernandes Barreto Costa on 26/08/24.
//

import SwiftUI
import SwiftData

@main
struct GuideBuddyApp: App {
    @StateObject private var languageManager = LanguageManager()
    var body: some Scene {
        WindowGroup {
            StartView()
            //Login()
              .environmentObject(languageManager)
        }
        .modelContainer(for: [Prompt.self,/* ProfilePhoto.self, BackgroundPhoto.self,*/ User.self, ItemEntity.self, SavedLocation.self])
    }
}
