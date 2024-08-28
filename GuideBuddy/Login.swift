//
//  Login.swift
//  GuideBuddy
//
//  Created by Raquel Ribeiro Hatem de Farias on 27/08/24.
//

import Foundation
import SwiftUI

struct Login: View {
    
    @State private var name = ""
    @State private var age: Double?
    @StateObject var languageManager = LanguageManager()
    
    var body: some View {
        
        GeometryReader { geometry in
            
            
            HStack {
                
                Spacer()
                
                VStack (alignment: .leading){
                    
                    Spacer()
                    Text("lets_go".localized)
//                    .position(y: geometry.size.width/2)

                    Text("fill_your_details".localized)
                    //.position(x: geometry.size.width/2.45, y: geometry.size.height/1.82)
                    
                        TextField("user_name".localized, text: $name)
                        .padding(.leading)
                            .frame(width: geometry.size.width*0.88, height: geometry.size.height*0.05)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.barraTexto)
                            )
                        //.position(x: geometry.size.width/2, y: geometry.size.height/1.6)
                   
                        
                    TextField("user_age".localized, value: $age, format: .number)
                        .padding(.leading)
                        .frame(width: geometry.size.width*0.88, height: geometry.size.height*0.05)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.barraTexto)
                        )
                    //.position(x: geometry.size.width/2, y: geometry.size.height/1.45)
                    
                    Button {
                       
                    } label: {
                        Text("Começar")
                            .foregroundStyle(.white)
                            .frame(width: geometry.size.width*0.88, height: geometry.size.height*0.07)
                            .background(.verde)
                            .cornerRadius(14)
                    }
                    
                    
                    Rectangle()
                        .frame(width: 10, height: 20)
//
                }
                
                Spacer()
                
            }
            
            
            
            
        }
        
        
    }
}

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

#Preview {
    Login()
}
