//
//  GuideBuddyApp.swift
//  GuideBuddy
//
//  Created by Pedro Fernandes Barreto Costa on 26/08/24.
//

import SwiftUI

@main
struct GuideBuddyApp: App {
    var body: some Scene {
        WindowGroup {
            EduView()
        }
        .modelContainer(for: Prompt.self)
    }
}
