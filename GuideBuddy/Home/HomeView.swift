//
//  HomeView.swift
//  GuideBuddy
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 29/08/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack{
            ScrollView{
                NavigationLink(destination: TestView(), label: {
                    ZStack{
                        Image("widHelper")
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Text("Acionar Helper")
                                    .font(.system(size: 26,weight: .semibold , design: .rounded))
                                    .foregroundStyle(.white)
                            
                            }
                            .padding(10)
                            
                        }
                        .padding()
                    }
                })
                HStack{
                    VStack{
                        
                    }
                    Spacer()
                    Image("widMaps")
                }
                CarousselView(caroussel: Category(images: ["widHospital", "widUniversities", "widDocuments"], titles: ["Hospitais", "Faculdades","Meus documentos"], destination: [AnyView(TestView()), AnyView(TestView()), AnyView(TestView())], color: [.white, .black, .black]))
                }
                    
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.white.opacity(0.1), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationTitle("GuiBu")
            
            
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
    HomeView()
}
