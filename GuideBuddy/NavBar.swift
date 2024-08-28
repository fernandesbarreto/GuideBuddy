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
        NavigationStack {
            ScrollView {
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.white.opacity(0.8), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationTitle("GuiBu")
            
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action:{ action() }, label: {
                        
                        Image(systemName: iconNameLeading)
                            .foregroundStyle(Color.verdePrincipal)
                    })
                    
                }
                
                
                
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    Button(action: { action()
                        
                    },
                           label: {
                        Image(systemName: iconNameTrailing)
                            .foregroundStyle(Color.verdePrincipal)
                        
                    })
                }
            }
        }
    }
}

#Preview {
    NavBar(action: {}, iconNameLeading: "clock", iconNameTrailing: "house")
}
