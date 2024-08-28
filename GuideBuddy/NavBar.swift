//
//  NavBar.swift
//  GuideBuddy
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 28/08/24.
//

import SwiftUI

struct NavBar: View {
    let action: ()->Void
    var iconNameLeading: String
    var iconNameTrailing: String
    var body: some View {
        HStack {
            Button(action: { action() }) {
                Image(systemName: iconNameLeading)
                    .foregroundStyle(Color.fernGreen)
                    .font(.title2)
            }
            
            Spacer()
            
            Text("GuiBu")
                .font(.headline)
            
            Spacer()
            
            Button(action: { action() }) {
                Image(systemName: iconNameTrailing)
                    .foregroundStyle(Color.fernGreen)
                    .font(.title2)
            }
        }
        .padding()
        .background(Color.white.opacity(0.8))
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

#Preview {
    NavBar(action: {}, iconNameLeading: "clock", iconNameTrailing: "house")
}
