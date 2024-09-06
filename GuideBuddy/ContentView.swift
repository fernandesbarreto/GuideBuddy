//
//  ContentView.swift
//  GuideBuddy
//
//  Created by Pedro Fernandes Barreto Costa on 26/08/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query(sort: \User.age) private var user: [User]
    
    var body: some View {
        if(user.count == 1) {
            HomeView()
        } else {
            Login()
        }
    }
    
}
#Preview {
    ContentView()
}
