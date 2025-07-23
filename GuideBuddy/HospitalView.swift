//
//  HospitalView.swift
//  GuiBu
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 21/09/24.
//

import SwiftUI
struct PhoneNumbersSheet: View {
    let phoneNumbers: [String]

    var body: some View {
        NavigationView {
            List {
                ForEach(phoneNumbers, id: \.self) { number in
                    if let phoneURL = URL(string: "tel://\(number.filter { $0.isNumber })") {
                        Link(number, destination: phoneURL)
                            .padding()
                    }
                }
            }
            .navigationTitle("Números")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Fechar") {
                       
                    }
                }
            }
        }
    }
}
struct EmailListView: View {
    let emails: [String]

    var body: some View {
        NavigationView {
            List(emails, id: \.self) { email in
                Button(action: {
                    sendEmail(to: email)
                }) {
                    Text(email)
                        .padding()
                }
            }
            .navigationTitle("Email")
            . navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Fechar") {
                      
                    }
                }
            }
        }
    }

    func sendEmail(to email: String) {
        let emailUrl = URL(string: "mailto:\(email)")!

        if UIApplication.shared.canOpenURL(emailUrl) {
            UIApplication.shared.open(emailUrl)
        }
    }
}


struct HospitalView: View {
    var hospital: HospitalModel
    let specificBuilding = allBuildings[0]
    @State var places: [HospitalModel] = allHospitalPlaces
    @Environment(\.presentationMode) var presentationMode
    @State var showNumbersSheet = false
    @State var showEmailSheet = false
    @State private var locationService = LocationService(completer: .init())
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    var body: some View {
        NavigationStack{
            
            VStack {
                ZStack {
                    VStack{
                        AsyncImage(url: URL(string: hospital.image)) { image in
                            image
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width * 1, height: UIScreen.main.bounds.height * 0.4)
                                .clipped()
                                .scaledToFill()
                            
                        } placeholder: {
                            
                            ProgressView()
                            
                        }
                        
                        
                        .frame(width: UIScreen.main.bounds.width * 1, height: UIScreen.main.bounds.height * 0.4)
                        .clipped()
                      
                        
                    }
                    .frame(width: UIScreen.main.bounds.width * 1, height: UIScreen.main.bounds.height * 0.35)
                    //                .clipped()
                    
                    .padding(.bottom, UIScreen.main.bounds.height * 0.8)
                    
                    ScrollView(showsIndicators: false) {
                        
                        
                        
                        
                        VStack {
                            Text(hospital.title)
                                .font(.title)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .fixedSize(horizontal: false, vertical: true)
                                .padding(.leading, 15)
                                .padding(.top, 15)
                            LazyVStack(alignment: .leading, spacing: 15) {
                                
                                Section() {
                                    
                                    NavigationLink(
                                        destination: SearchableMap(location: SavedLocation(name: hospital.title, latitude:hospital.latitude, longitude: hospital.longitude)),
                                        label: {
                                            HStack {
                                                Image(systemName: "location.fill")
                                                    .foregroundStyle(Color.verdePrincipal)
                                                Text(hospital.location) // Aqui pode ser o nome da localização ou algo mais descritivo
                                                    .multilineTextAlignment(.leading)
                                                    .foregroundStyle(Color.gray)
                                            }
                                        }
                                    )
                                    
                                }
                                .padding(.horizontal)
                                //                        .padding(.bottom)
                                Section(header: Text("Contatos")
                                    .font(.body)
                                    .bold()){
                                        ScrollView(.horizontal, showsIndicators: false){
                                            HStack{
                                                Button(action: {
                                                    showNumbersSheet = true
                                                }, label: {
                                                    ZStack {
                                                        Rectangle()
                                                            .frame(width: 175, height: 70)
                                                            .cornerRadius(15)
                                                            .foregroundStyle(.gray)
                                                            .opacity(0.1)
                                                            .shadow(radius: 5)
                                                        VStack {
                                                            Image(systemName: "phone.fill")
                                                                .font(.system(size: 25, weight: .semibold, design: .rounded))
                                                                .foregroundStyle(Color.verdePrincipal)
                                                                .opacity(0.8)
                                                            
                                                            Text("Telefone")
                                                                .font(.system(size: 12))
                                                                .bold()
                                                                .foregroundStyle(Color.verdePrincipal)
                                                                .padding(.vertical, 3)
                                                                .opacity(0.8)
                                                        }
                                                    }
                                                })
                                                .sheet(isPresented: $showNumbersSheet) {
                                                    PhoneNumbersSheet(phoneNumbers: hospital.number)
                                                        .presentationDetents([.fraction(0.3), .large])
                                                    
                                                }
                                                Spacer()
                                                Button(action: {
                                                    showEmailSheet.toggle()
                                                }, label: {
                                                    ZStack {
                                                        Rectangle()
                                                            .frame(width: 175, height: 70)
                                                            .cornerRadius(15)
                                                            .foregroundStyle(.gray)
                                                            .opacity(0.1)
                                                            .shadow(radius: 5)
                                                        VStack {
                                                            Image(systemName: "envelope.fill")
                                                                .font(.system(size: 25, weight: .semibold, design: .rounded))
                                                                .foregroundStyle(Color.verdePrincipal)
                                                                .opacity(0.8)
                                                            
                                                            Text("Email")
                                                                .font(.system(size: 12))
                                                                .bold()
                                                                .foregroundStyle(Color.verdePrincipal)
                                                                .padding(.vertical, 3)
                                                                .opacity(0.8)
                                                        }
                                                    }
                                                })
                                                .sheet(isPresented: $showEmailSheet) {
                                                    EmailListView(emails: hospital.email)
                                                        .presentationDetents([.fraction(0.3), .large])
                                                }
                                            }
                                            
                                        }
                                        
                                    }
                                    .padding(.leading)
                                Spacer()
                                Section(header: Text("Especialidades")
                                    .font(.body)
                                    .bold()) {
                                        VStack{
                                            //                                        LazyVGrid(columns: columns, spacing: 5) {
                                            //                                            ForEach(hospital.ambulatorio, id: \.self) { item in
                                            //                                                Text(item)
                                            //                                                    .frame(maxWidth: .infinity)
                                            //                                                                           .frame(height: 30)
                                            //                                                    .font(.body)
                                            //                                                    .padding(.horizontal, 10)
                                            //                                                    .padding(.vertical, 6)
                                            //                                                    .background(Color.verdePrincipal.opacity(0.2))
                                            //                                                    .cornerRadius(8)
                                            //                                            }
                                            //                                        }
                                            //                                        .padding(.trailing)
                                            HStack{
                                                Text("Ambulatório")
                                                    .multilineTextAlignment(.leading)
                                                    .padding(.top)
                                                Spacer()
                                            }
                                            ScrollView(.horizontal, showsIndicators: false) {
                                                HStack {
                                                    ForEach(hospital.ambulatorio, id: \.self) { ambulatorio in
                                                        Text(ambulatorio)
                                                            .font(.body)
                                                            .padding(.horizontal, 10)
                                                            .padding(.vertical, 6)
                                                            .background(Color.verdePrincipal.opacity(0.1))
                                                            .cornerRadius(8)
                                                    }
                                                }
                                            }
                                            HStack{
                                                Text("Emergência")
                                                    .multilineTextAlignment(.leading)
                                                    .padding(.top)
                                                Spacer()
                                            }
                                            ScrollView(.horizontal, showsIndicators: false) {
                                                HStack {
                                                    ForEach(hospital.emergencia, id: \.self) { emergencia in
                                                        Text(emergencia)
                                                            .font(.body)
                                                            .padding(.horizontal, 10)
                                                            .padding(.vertical, 6)
                                                            .background(Color.verdePrincipal.opacity(0.1))
                                                            .cornerRadius(8)
                                                    }
                                                }
                                            }
                                            HStack{
                                                Text("Clínica Médica")
                                                    .multilineTextAlignment(.leading)
                                                    .padding(.top)
                                                Spacer()
                                            }
                                            ScrollView(.horizontal, showsIndicators: false) {
                                                HStack {
                                                    ForEach(hospital.clinica, id: \.self) { clinica in
                                                        Text(clinica)
                                                            .font(.body)
                                                            .padding(.horizontal, 10)
                                                            .padding(.vertical, 6)
                                                            .background(Color.verdePrincipal.opacity(0.1))
                                                            .cornerRadius(8)
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    .padding(.leading)
                                
                            }
                            
                            
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                            
                                .fill(Color.white)
                                .frame(width: UIScreen.main.bounds.width * 1, height: .infinity)
                        )
                        
                        
                        .padding(.top, UIScreen.main.bounds.height * 0.35)
                    }
                    
                    
                    
                }
                
                
                .ignoresSafeArea()
            }
            .navigationBarBackButtonHidden(false)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    
//                    ZStack {
//                        Rectangle()
//                            .frame(width: 70, height: 35)
//                            .cornerRadius(10)
//                            .foregroundStyle(Color.white)
//                            .opacity(0.6)
//                    }
                    
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    Button(action: {}, label: {})
                }
                ToolbarItem(placement: .principal){
                    Text("")
                }
            }
        }
    }
}
    func makeACall(to number: String) {
        let tel = "tel://\(number)"
        guard let url = URL(string: tel) else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
#Preview {
    HospitalView(hospital: HospitalModel(title: "Hospital da Restauração",
                                         ambulatorio: ["Ambulatório", "Neurologia", "Neurocirurgia", "Ortopedia/traumatologia", "Cirurgia Vascular", "Cirurgia Geral", "Bucomaxilofacial", "Clínica Médica", "Emergência", "Cirurgia bucomaxilofacial", "Cirurgia Geral", "Cirurgia Vascular", "Clínica Médica", "Clínica Pediátrica", "Intoxicações", "Neurocirurgia", "Neurologia", "Queimaduras", "Traumato-ortopedia"],
                                         emergencia: [""],
                                         clinica: [""],
                                         navTitle: "Restauração",
                                         location: "Avenida Agamenon Magalhães, S/N\nDerby, Recife – PE",
                                         image: "https://portal.saude.pe.gov.br/wp-content/uploads/2024/06/HR-2.jpg",
                                         number: ["(81) 3181.5400"],
                                         email: ["cpl@lafepe.pe.gov.br"], latitude: -8.02659, longitude: -34.86425))
}


