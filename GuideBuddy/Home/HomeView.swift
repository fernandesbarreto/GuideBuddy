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
                            Text("Olá,")
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
                
                
                NavigationLink(destination: EduView(), label: {
                    ZStack{
                        Image("widHelper")
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Text("Acionar Helper")
                                    .font(.system(size: 22,weight: .semibold , design: .rounded))
                                    .foregroundStyle(.white)
                            
                            }
                            .padding(10)
                            
                        }
                        .padding()
                    }
                })
                HStack{
                    VStack{
                        NavigationLink(destination: Emergencia(), label: {
                            ZStack {
                                Rectangle()
                                    .frame(width: 77, height: 77)
                                    .cornerRadius(15)
                                .foregroundStyle(.red)
                                VStack {
                                    Image(systemName: "light.beacon.max.fill")
                                        .font(.system(size: 32,weight: .semibold , design: .rounded))
                                    .foregroundStyle(.white)
                                    
                                    Text("Emergência")
                                        .font(.system(size: 12))
                                        .foregroundStyle(.white)
                                        .padding(.vertical, 3)
                                }
                            }
                        })
                        .shadow(radius: 5)
                        Spacer()
                        NavigationLink(destination: TestView(), label: {
                            ZStack {
                                Rectangle()
                                    .frame(width: 77, height: 77)
                                    .cornerRadius(15)
                                .foregroundStyle(.ourorange)
                                VStack {
                                    Image(systemName: "bookmark.fill")
                                        .font(.system(size: 32,weight: .semibold , design: .rounded))
                                    .foregroundStyle(.white)
                                    
                                    Text("Favoritos")
                                        .font(.system(size: 12))
                                        .foregroundStyle(.white)
                                        .padding(.vertical, 2)
                                }
                            }
                        })
                        .shadow(radius: 5)
                    }
                    .frame(height: 177)
                    NavigationLink(destination: TestView(), label: {
                        ZStack{
                            Image("widMaps")
                            VStack {
                                Spacer()
                                HStack {
                                    Spacer()
                                    Text("Mapa")
                                        .font(.system(size: 22,weight: .semibold , design: .rounded))
                                        .foregroundStyle(.white)
                                    
                                
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
                
                CarousselView(caroussel: Category(images: ["widHospital", "widUniversities", "widDocuments"], titles: ["Hospitais", "Faculdades","Documentos"], destination: [AnyView(TestView()), AnyView(TestView()), AnyView(TestView())], color: [.white, .white, .white]))
                    .padding(.horizontal, 8)
                
                NavigationLink(destination: TestView(), label: {
                    ZStack {
                        Rectangle()
                            .frame(width: 363, height: 208)
                            .foregroundStyle(Color.ourorange)
                        .cornerRadius(20)
                        HStack{
                            ZStack {
                                
                                Circle()
                                    .stroke(lineWidth: 30)
                                    .opacity(0.2)
                                    .foregroundColor(Color.gray)
                                    .frame(width: 140)
                                if resultado > 0 {
                                    Circle()
                                        .trim(from: 0.0, to: CGFloat(min(resultado / 10, 1.0)))
                                        .stroke(
                                                                AngularGradient(
                                                                    gradient: Gradient(colors: [.background]),
                                                                    center: .center
                                                                ),
                                                                style: StrokeStyle(lineWidth: 35, lineCap: .round, lineJoin: .round)
                                                            )
                                        .rotationEffect(Angle(degrees: 270.0))
                                        .animation(.linear, value: resultado / 10)
                                        .frame(width: 140)
                                }
                                Image("setinha2")
                                    .offset(y: -70)
                               /* Text("\(resultado*10, specifier: "%.0f")")
                                    .animation(.easeInOut.speed(0.5), value: animatedValue)
                                    .foregroundColor(.white)
                                    .font(.system (size:32))
                                    .bold()
                                */
                            }
                            .padding(.leading, 35)
                            Spacer()
                            VStack {
                                Text("Desafios")
                                    .font(.system(size: 22,weight: .semibold , design: .rounded))
                                .foregroundStyle(.white)
                            }
                            .padding(.trailing, 35)
                          
                            
                        }
                    }
                    .frame(width: 363, height: 208)
                })
                .padding(10)
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
      
    }
}

#Preview {
    HomeView()
}
