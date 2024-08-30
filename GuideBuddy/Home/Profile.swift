//
//  Profile.swift
//  GuideBuddy
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 29/08/24.
//

import SwiftUI

struct Profile: View {
    var body: some View {
        NavigationStack{
            ScrollView{
                
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.white.opacity(0.8), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationTitle("Perfil")
            
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action:{}, label: {
                        
                        Image("")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                    })
                  
    
                }
                
        
                
                ToolbarItem(placement: .navigationBarTrailing) {

                    Button(action: {
                       

                    },
                           label: {
                        Image(systemName: "")
                            .foregroundStyle(Color(.white))

                    })
                }
            }
        }
    }
}

#Preview {
    Profile()
}
