//
//  HomeView.swift
//  GuideBuddy
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 29/08/24.
//

import SwiftUI
import SwiftData
import CoreLocation


class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    
    @Published var location: String = "Obtendo localização..."
    
    override init() {
        super.init()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let loc = locations.last else { return }
        
        // Converter latitude e longitude para string
        location = "Lat: \(loc.coordinate.latitude), Lon: \(loc.coordinate.longitude)"
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        location = "Erro ao obter localização"
    }
}

struct HomeView: View {
    @EnvironmentObject var languageManager: LanguageManager
    
    @Query private var user: [User]
    @State private var resultado: Double = 7.5
    @State private var animatedValue: Double = 0.0
    @State private var refreshID = UUID()
    
    var body: some View {
        NavigationStack{
            ScrollView(.vertical, showsIndicators: false){
                VStack{
                    VStack{
                        GreetingSection()
                            .padding(.top, 30)
                        VStack (spacing: UIScreen.main.bounds.height*0.014){
                            AcionarHelperLink()
                            
                            EmergencyDocumentsSection()
                            
                            UniversitiesSection()
                            
                            HStack {
                                Hospitals()
                                Spacer()
                                DailySlangLink(resultado: $resultado)
                                
                                
                            }
                            .frame(width: UIScreen.main.bounds.width*0.928, height: UIScreen.main.bounds.height*0.18)
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width*0.928)
                    .padding(.horizontal)
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle("inicio".localized)
                    
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            NavigationLink(destination:ConfigView()) {
                                Image(systemName: "gearshape")
                            }
                        }
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .id(refreshID) // Força atualização quando o idioma muda
        }
        .onAppear() {
            print("user defaults ON APPEAR \(String(describing: UserDefaults.standard.value(forKey: "AppleLanguage")))")
            // Aplica o tema salvo quando HomeView aparece
            if let currentUser = user.first {
                applyThemeFromBackground(currentUser.choosenBackground)
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("LanguageChanged"))) { _ in
            // Atualiza a view quando o idioma muda
            refreshID = UUID()
        }
        .onChange(of: languageManager.currentLanguage) { oldValue, newValue in
            // Atualiza a view quando o idioma muda
            refreshID = UUID()
        }
    }
}

struct Hospitals: View {
    @EnvironmentObject var languageManager: LanguageManager
    @State private var refreshID = UUID()
    
    var body: some View {
        NavigationLink(destination: HealthCategories(), label: {
            ZStack{
                Image("widHospital")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width*0.445, height: UIScreen.main.bounds.height*0.18)
                   
            
//                        .frame(width: 185, height: 185)
                VStack(alignment: .leading) {
                  
                    VStack(alignment: .leading, spacing: 5){
                        Text("hospitais".localized)
                            .font(.system(size: 16, weight: .regular))
                            .foregroundStyle(.black)
                        
                        Text("cuidados_saude".localized)
                            .multilineTextAlignment(.leading)
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(.black)
                            .frame(height: 50)
                        
                    }
                    .padding(.leading, 12)
                    Spacer()
                    HStack{
                        Spacer()
                        NavigationLink(destination: HealthCategories(), label: {
                            ZStack{
                                Circle()
                                    .fill(Color.buttonBlack)
                                    .frame(width: 30, height: 30)
                                    .cornerRadius(31)
                                
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 14))
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.white)
                            }
                            
                        })
                    }
                    .padding()
//
                }
                .frame(height: UIScreen.main.bounds.height*0.15)
                .padding(.top)
            }
            .frame(width: UIScreen.main.bounds.width*0.445, height: UIScreen.main.bounds.height*0.18)
        })
        .frame(width: UIScreen.main.bounds.width*0.445, height: UIScreen.main.bounds.height*0.18)
        .id(refreshID)
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("LanguageChanged"))) { _ in
            refreshID = UUID()
        }
        .onChange(of: languageManager.currentLanguage) { oldValue, newValue in
            refreshID = UUID()
        }
    }
}

struct GreetingSection: View {
    @EnvironmentObject var languageManager: LanguageManager
    @Query private var users: [User]
    @State private var refreshID = UUID()
    
    var body: some View {
        let userName = users.first?.name ?? "usuario".localized
        let _ = print("GreetingSection - Nome do usuário: \(userName)")
        return HStack {
            Text("ola".localized + ",")
                .font(.system(size: 24, weight: .regular, design: .rounded))
             
            
            Text(userName)
                .font(.system(size: 24, weight: .semibold, design: .rounded))
                .foregroundStyle(Color.verdePrincipal)
                .id(userName) // Força atualização quando o nome muda
            
            Spacer()
        }
        .padding(.leading, 5)
        .id(refreshID)
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("LanguageChanged"))) { _ in
            refreshID = UUID()
        }
        .onChange(of: languageManager.currentLanguage) { oldValue, newValue in
            refreshID = UUID()
        }
    }
}


struct AcionarHelperLink: View {
    @EnvironmentObject var languageManager: LanguageManager
    @StateObject var locationManager = LocationManager()
    @State private var refreshID = UUID()
    
    var body: some View {
        NavigationLink(destination: EduView(), label: {
            ZStack{
                Image("widHelper")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width*0.93, height: UIScreen.main.bounds.height*0.28)
                HStack{
                    VStack(alignment: .leading, spacing: UIScreen.main.bounds.height*0.0117) {
                        
                        Text("ajudante_ia".localized)
                            .font(.system(size: 16))
                            .fontWeight(.regular)
                        //                        .font(.body)
                            .foregroundStyle(.black)
                            .multilineTextAlignment(.leading)
                            .frame(height: 22)
                        
                        Text("use_conhecer_cidade".localized)
                            .font(.system(size: 20))
                        //                        .font(.title2)
                            .fontWeight(.medium)
                            .lineSpacing(6)
                            .multilineTextAlignment(.leading)
                            .foregroundStyle(.black)
                            .frame(height: 101)
                        
                        HStack(spacing: 5){
//                            Image(systemName: "location")
//                            //                            .font(.body)
//                                .font(.system(size: 12))
//                                .fontWeight(.regular)
//                                .foregroundStyle(.black)
//                                .multilineTextAlignment(.leading)
//                            
//                            Text(locationManager.location)
//                                .font(.system(size: 12))
//                            //                            .font(.caption)
//                                .fontWeight(.regular)
//                                .padding()
                        }
                        .frame(height: 22)
                        
                        NavigationLink(destination: EduView(), label: {
                            ZStack{
                                Rectangle()
                                    .fill(Color.buttonBlack)
                                    .frame(width: 110, height: 36)
                                    .cornerRadius(31)
                                
                                Text("acionar".localized)
                                    .font(.system(size: 14))
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.white)
                            }
                            
                        }
                        )
                        
                    }
                    .frame(height: 216)
                    .padding(.leading, 12)
                    Spacer()
                }
            }
            .frame(width: UIScreen.main.bounds.width*0.93, height: UIScreen.main.bounds.height*0.28)
        })
        .id(refreshID)
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("LanguageChanged"))) { _ in
            refreshID = UUID()
        }
        .onChange(of: languageManager.currentLanguage) { oldValue, newValue in
            refreshID = UUID()
        }
    }
}

struct EmergencyDocumentsSection: View {
    @EnvironmentObject var languageManager: LanguageManager
    @State private var refreshID = UUID()
    
    var body: some View {
       
            HStack{
                NavigationLink(destination: ListaDeDocumentosView(), label: {
                    ZStack {
                        Rectangle()
                            .frame(width: UIScreen.main.bounds.width*0.45, height: UIScreen.main.bounds.height*0.06)
                            .cornerRadius(31)
                            .foregroundStyle(Color.docGreen)

                          
                        HStack {
                            
                            ZStack{
                                Circle()
                                    .frame(width: 40, height: 40)
                                    .foregroundStyle(Color.docGreen2)
                                Image(systemName: "document.fill")
                                    .font(.system(size: 19, weight: .semibold, design: .rounded))
                                    .foregroundStyle(.white)
                            }
                            
                            Spacer()
                            
                            Text("documentos".localized)
                                .font(.system(size: 16))
                                .fontWeight(.regular)
                                .foregroundStyle(.black)
                                .padding(.trailing, 12)
                        }
                        .padding(.horizontal, 8)
                    }
                })
                .frame(width: UIScreen.main.bounds.width*0.45, height: UIScreen.main.bounds.height*0.06)
             
                
                Spacer()
                NavigationLink(destination: Emergency(), label: {
                    ZStack {
                        Rectangle()
                            .frame(width: UIScreen.main.bounds.width*0.45, height: UIScreen.main.bounds.height*0.06)
                            .cornerRadius(31)
                            .foregroundStyle(Color.emergencyRed)
                           
                        HStack {
                            
                            ZStack{
                                Circle()
                                    .frame(width: 40, height: 40)
                                    .foregroundStyle(Color.emergencyRed2)
                                
                                Image(systemName: "light.beacon.max.fill")
                                    .font(.system(size: 19, weight: .semibold, design: .rounded))
                                    .foregroundStyle(.white)
                            }
                            
                            Spacer()
                            
                            Text("emergencia".localized)
                                .font(.system(size: 16))
                                .fontWeight(.regular)
                                .foregroundStyle(.black)
                                .padding(.trailing, 12)
                        }
                        .padding(.horizontal, 8)
                    }
                })
                .frame(width: UIScreen.main.bounds.width*0.45, height: UIScreen.main.bounds.height*0.06)
              
               
            }
            .frame(width: UIScreen.main.bounds.width*0.929, height: UIScreen.main.bounds.height*0.06)
            .id(refreshID)
            .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("LanguageChanged"))) { _ in
                refreshID = UUID()
            }
            .onChange(of: languageManager.currentLanguage) { oldValue, newValue in
                refreshID = UUID()
            }
    }
}

struct UniversitiesSection: View {
    @EnvironmentObject var languageManager: LanguageManager
    @State private var refreshID = UUID()
    
    var body: some View {
        HStack{
            
            NavigationLink(destination: MapUFPE(), label: {
                ZStack{
                    Image("widUniversities")
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width*0.928, height: UIScreen.main.bounds.height*0.18)
                    HStack{
                        VStack(alignment: .leading, spacing: 8) {
                            
                            Text("faculdades".localized)
                                .font(.system(size: 16))
                                .fontWeight(.regular)
                            //                        .font(.body)
                                .foregroundStyle(.black)
                                .multilineTextAlignment(.leading)
                                .frame(height: 22)
                            
                            Text("mapas_infos_universidades".localized)
                                .font(.system(size: 20))
                            //                        .font(.title2)
                                .fontWeight(.medium)
                                .lineSpacing(6)
                                .multilineTextAlignment(.leading)
                                .foregroundStyle(.black)
                                .frame(height: 54)
                            
                       
                            
                            NavigationLink(destination: MapUFPE(), label: {
                                ZStack{
                                    Rectangle()
                                        .fill(Color.buttonBlack)
                                        .frame(width: 76, height: 36)
                                        .cornerRadius(31)
                                    
                                    Text("ir".localized)
                                        .font(.system(size: 14))
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.white)
                                }
                                
                            }
                            )
                            
                        }
                        .frame(height: 216)
                        .padding(.leading, 12)
                        Spacer()
                    }
                }
                .frame(width: UIScreen.main.bounds.width*0.928, height: UIScreen.main.bounds.height*0.18)
                
            })
            .id(refreshID)
            .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("LanguageChanged"))) { _ in
                refreshID = UUID()
            }
            .onChange(of: languageManager.currentLanguage) { oldValue, newValue in
                refreshID = UUID()
            }
        }
    }
}

struct DailySlangLink: View {
    @EnvironmentObject var languageManager: LanguageManager
    @Binding var resultado: Double
    @State private var refreshID = UUID()
    
    var body: some View {
        NavigationLink(destination: DailySlangView(), label: {
            ZStack {
             Image("slangsWid")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width*0.45, height: UIScreen.main.bounds.height*0.18)
                VStack(alignment: .leading) {
                  
                    VStack(alignment: .leading, spacing: 5){
                        Text("girias".localized)
                            .font(.system(size: 16, weight: .regular))
                            .foregroundStyle(.black)
                        
                        Text("expressoes_linguagem_local".localized)
                            .multilineTextAlignment(.leading)
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(.black)
                            .frame(height: 50)
                        
                    }
                    .padding(.leading, 12)
                    Spacer()
                    HStack{
                        Spacer()
                        NavigationLink(destination: DailySlangView(), label: {
                            ZStack{
                                Circle()
                                    .fill(Color.buttonBlack)
                                    .frame(width: 30, height: 30)
                                    .cornerRadius(31)
                                
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 14))
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.white)
                            }
                            
                        })
                    }
                    .padding()
//
                }
                .frame(height: UIScreen.main.bounds.height*0.15)
                .padding(.top)
            }
            .frame(width: 160, height: 160)
        })
        .frame(width: UIScreen.main.bounds.width*0.45, height: UIScreen.main.bounds.height*0.18)
        .id(refreshID)
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("LanguageChanged"))) { _ in
            refreshID = UUID()
        }
        .onChange(of: languageManager.currentLanguage) { oldValue, newValue in
            refreshID = UUID()
        }
    }
}

//struct ProfileLink: View {
//    var selectedImage: [ProfilePhoto]
//    
//    var body: some View {
//        NavigationLink(destination: Profile(), label: {
//            if let image = selectedImage.last?.getProfilePhoto() {
//                Image(uiImage: image)
//                    .resizable()
//                    .scaledToFill()
//                    .frame(width: 27, height: 27)
//                    .clipShape(Circle())
//            } else {
//                Image(systemName: "person.crop.circle")
//                    .foregroundStyle(Color.verdePrincipal)
//            }
//        })
//    }
//}
#Preview {
    HomeView()
}
