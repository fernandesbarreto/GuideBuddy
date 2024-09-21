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
    @Query private var selectedImage: [ProfilePhoto]
    @State private var resultado: Double = 7.5
    @State private var animatedValue: Double = 0.0
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack{
                    GreetingSection(user: user)
                    
                    AcionarHelperLink()
                        .padding(6)
                    EmergencyFavoritesSection()
                    
                    CarousselView(caroussel: Category(images: ["widDocuments", "widUniversities", "widHospital"], titles: ["documento".localized, "faculdade".localized,"hospital".localized], destination: [AnyView(ListaDeDocumentosView()), AnyView(MapUFPE()), AnyView(HealthCategories())], color: [.white, .white, .white]))
                        .frame(width: 400)
                    
                    DailySlangLink(resultado: $resultado)
                    
                }
                .frame(width: 365)
                .padding(.horizontal)
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Home")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        ProfileLink(selectedImage: selectedImage)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .onAppear() {
            print("user defaults ON APPEAR \(String(describing: UserDefaults.standard.value(forKey: "AppleLanguage")))")
        }
    }
}

struct GreetingSection: View {
    var user: [User]
    
    var body: some View {
        VStack{
            HStack {
                Text("ola".localized)
                    .font(.system(size: 24, weight: .regular, design: .rounded))
                    .foregroundStyle(.black)
                Spacer()
            }
            HStack {
                Text(user.first?.name ?? "User")
//                Text("Nome")
                    .font(.system(size: 24, weight: .semibold, design: .rounded))
                    .foregroundStyle(Color.verdePrincipal)
                Spacer()
            }
        }
        .padding(.leading, 5)
    }
}

struct AcionarHelperLink: View {
    var body: some View {
        NavigationLink(destination: EduView(), label: {
            ZStack{
                Image("widHelper")
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Text("Acionar GuiBu")
                            .font(.system(size: 22, weight: .semibold, design: .rounded))
                            .foregroundStyle(.white)
                            .shadow(radius: 2)
                    }
//
                    .padding(.trailing, 10)
                }
                .padding()
            }
        })
        .shadow(radius: 2)
    }
}

struct EmergencyFavoritesSection: View {
    var body: some View {
        HStack{
            
            NavigationLink(destination: SearchableMap(), label: {
                ZStack{
                    Image("widMaps")
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Text("mapas".localized)
                                .font(.system(size: 22, weight: .semibold, design: .rounded))
                                .foregroundStyle(.white)
                                .shadow(radius: 2)
                        }
//
                    }
                    .padding()
                }
            })
            .shadow(radius: 2)
            .padding(.trailing, 10)
//            .frame(width: 280, height: 195)
            Spacer()
            VStack{
                NavigationLink(destination: Emergency(), label: {
                    ZStack {
                        Rectangle()
                            .frame(width: 77, height: 77)
                            .cornerRadius(15)
                            .foregroundStyle(.red)
                        VStack {
                            Image(systemName: "light.beacon.max.fill")
                                .font(.system(size: 32, weight: .semibold, design: .rounded))
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
                            .foregroundStyle(.verdePrincipal)
                        VStack {
                            Image(systemName: "star.fill")
                                .font(.system(size: 32, weight: .semibold, design: .rounded))
                                .foregroundStyle(.white)
                            
                            Text("favoritos")
                                .font(.system(size: 12))
                                .foregroundStyle(.white)
                                .padding(.vertical, 2)
                        }
                    }
                })
                .shadow(radius: 2)
            }
            .frame(height: 177)
        }
        
              .padding(8)
    }
}

struct DailySlangLink: View {
    @Binding var resultado: Double
    
    var body: some View {
        NavigationLink(destination: DailySlangView(), label: {
            ZStack {
             Image("slangsWid")
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Text("Gírias")
                            .font(.system(size: 22, weight: .semibold, design: .rounded))
                            .foregroundStyle(.white)
//                            .shadow(radius: 3)
                    }
                    .padding(10)
                    .padding(.trailing, 10)
                }
                .padding()
            }
            .frame(width: 363, height: 208)
        })
        .padding(10)
        .shadow(radius: 2)
    }
}

struct ProfileLink: View {
    var selectedImage: [ProfilePhoto]
    
    var body: some View {
        NavigationLink(destination: Profile(), label: {
            if let image = selectedImage.last?.getProfilePhoto() {
                Image(uiImage: image)
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
#Preview {
    HomeView()
}
