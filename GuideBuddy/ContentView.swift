//
//  ContentView.swift
//  GuideBuddy
//
//  Created by Pedro Fernandes Barreto Costa on 26/08/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavBar(action: {}, iconNameLeading: "", iconNameTrailing: "person.crop.circle")
        ScrollView{
            ZStack{
                Image("widgetRoxo")
                HStack {
                    Image("cachorro")
                    Spacer()
                }
            }
        }
    }
    
}
#Preview {
    ContentView()
}
