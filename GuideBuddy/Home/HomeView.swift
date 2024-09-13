//
//  HomeView.swift
//  GuideBuddy
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 29/08/24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Query(sort: \User.age) private var user: [User]
    @State var selectedImage: UIImage?
    @State private var resultado: Double = 7.5
    @State private var animatedValue: Double = 0.0
    var body: some View {
        NavigationStack{
            ScrollView{
                
                    VStack{
                        HStack {
                            Text("ola".localized)
                                .font(.system(size: 24,weight: .regular , design: .rounded))
                            .foregroundStyle(.black)
                            Spacer()
                        }
                            
                        HStack {
                            Text(user[0].name)
                                .font(.system(size: 24,weight: .semibold , design: .rounded))
                            .foregroundStyle(Color.verdePrincipal)
                            Spacer()
                        }
                        
                    }
                    .padding()
                    .padding(.leading, 8)
                
                
                NavigationLink(destination: EduView(), label: {
                    ZStack{
                        Image("widHelper")
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Text("acionar_helper")
                                    .font(.system(size: 22,weight: .semibold , design: .rounded))
                                    .foregroundStyle(.white)
                                    .shadow(radius: 5)
                            }
                            .padding(10)
                            .padding(.trailing, 10)
                            
                        }
                        .padding()
                    }
                })
                HStack{
                    VStack{
                        NavigationLink(destination: Emergency(), label: {
                            ZStack {
                                Rectangle()
                                    .frame(width: 77, height: 77)
                                    .cornerRadius(15)
                                .foregroundStyle(.red)
                                VStack {
                                    Image(systemName: "light.beacon.max.fill")
                                        .font(.system(size: 32,weight: .semibold , design: .rounded))
                                    .foregroundStyle(.white)
                                    
                                    Text("emergencia")
                                        .font(.system(size: 12))
                                        .foregroundStyle(.white)
                                        .padding(.vertical, 3)
                                }
                            }
                        })
                        .shadow(radius: 5)
                        Spacer()
                        NavigationLink(destination: Favorites(), label: {
                            ZStack {
                                Rectangle()
                                    .frame(width: 77, height: 77)
                                    .cornerRadius(15)
                                .foregroundStyle(.ourorange)
                                VStack {
                                    Image(systemName: "bookmark.fill")
                                        .font(.system(size: 32,weight: .semibold , design: .rounded))
                                    .foregroundStyle(.white)
                                    
                                    Text("favoritos")
                                        .font(.system(size: 12))
                                        .foregroundStyle(.white)
                                        .padding(.vertical, 2)
                                }
                            }
                        })
                        .shadow(radius: 5)
                    }
                    .frame(height: 177)
                    NavigationLink(destination: SearchableMap(), label: {
                        ZStack{
                            Image("widMaps")
                            VStack {
                                Spacer()
                                HStack {
                                    Spacer()
                                    Text("mapas".localized)
                                        .font(.system(size: 22,weight: .semibold , design: .rounded))
                                        .foregroundStyle(.white)
                                        .shadow(radius: 5)
                                
                                }
                                .padding(10)
                                
                            }
                            .padding()
                        }
                    })
                  
                  
                    .frame(width: 280, height: 195)
                }
                .frame(width: 370)
                .padding(.horizontal)
                
                CarousselView(caroussel: Category(images: ["widHospital", "widUniversities", "widDocuments"], titles: ["hospital".localized, "faculdade".localized,"documento".localized], destination: [AnyView(HealthCategories()), AnyView(MapUFPE()), AnyView(ListaDeDocumentosView())], color: [.white, .white, .white]))
                    .padding(.horizontal, 8)
                
                NavigationLink(destination: TestView(), label: {
                    
                    ZStack {
                        Image("slangsWid")
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Text("Gírias")
                                    .font(.system(size: 22,weight: .semibold , design: .rounded))
                                    .foregroundStyle(.white)
                                    .shadow(radius: 5)
                            }
                            .padding(10)
                            .padding(.trailing, 10)
                            
                        }
                        .padding()
                    }
                })
                .padding(5)
                .shadow(radius: 5)
                }
            .frame(width: 365)
                    
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.clear.opacity(0.1), for: .navigationBar)
//            .toolbarBackground(.visible, for: .navigationBar)
            .navigationTitle("Home")
            
            
            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button(action:{}, label: {
//                        
//                        Image("")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 30)
//                    })
//                  
//    
//                }
//                
        
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: Profile(), label: {
                        if let selectedImage = selectedImage {
                            Image(uiImage: selectedImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 27, height: 27)
                                .clipShape(Circle())
                        } else {
                            Image(systemName: "person.crop.circle")
                                .foregroundStyle(Color.verdePrincipal)
                        }
                    })
                  
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
                  .background(Color.background)
        }
        .onAppear() {
            print("user defaults ON APPEAR \(String(describing: UserDefaults.standard.value(forKey: "AppleLanguage")))")
        }
      
    }
}

#Preview {
    HomeView()
}
