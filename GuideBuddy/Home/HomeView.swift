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
                    
                    EmergencyFavoritesSection()
                    
                    CarousselView(caroussel: Category(images: ["widHospital", "widUniversities", "widDocuments"], titles: ["hospital".localized, "faculdade".localized,"documento".localized], destination: [AnyView(HealthCategories()), AnyView(MapUFPE()), AnyView(ListaDeDocumentosView())], color: [.white, .white, .white]))
                        .padding(.horizontal, 8)
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
                        Text("acionar_helper")
                            .font(.system(size: 22, weight: .semibold, design: .rounded))
                            .foregroundStyle(.white)
                            .shadow(radius: 5)
                    }
                    .padding(10)
                    .padding(.trailing, 10)
                }
                .padding()
            }
        })
    }
}

struct EmergencyFavoritesSection: View {
    var body: some View {
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
                            .foregroundStyle(.ourorange)
                        VStack {
                            Image(systemName: "bookmark.fill")
                                .font(.system(size: 32, weight: .semibold, design: .rounded))
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
                                .font(.system(size: 22, weight: .semibold, design: .rounded))
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
                            .shadow(radius: 5)
                    }
                    .padding(10)
                    .padding(.trailing, 10)
                }
                .padding()
            }
            .frame(width: 363, height: 208)
        })
        .padding(10)
        .shadow(radius: 5)
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
