//
//  ContentView.swift
//  GuideBuddy
//
//  Created by Pedro Fernandes Barreto Costa on 26/08/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                NavBar(
                    action: {
                        print("Button tapped")
                    },
                    iconNameLeading: "clock",
                    iconNameTrailing: "house"
                )
                GuideChat()
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

#Preview {
    ContentView()
}
