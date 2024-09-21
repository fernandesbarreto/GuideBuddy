//
//  HospitalView.swift
//  GuiBu
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 21/09/24.
//

import SwiftUI

struct HospitalView: View {
    var hospital: HospitalModel
    let specificBuilding = allBuildings[0]
    @State var places: [HospitalModel] = allHospitalPlaces
    
    var body: some View {
        NavigationStack{
            ScrollView(showsIndicators: false) {
                
                    AsyncImage(url: URL(string: hospital.image)) { image in
                        image
                            .resizable()
                        //                        .resizable()
                            .scaledToFit()
                        //                        .frame(width: 370)
                        //
                    } placeholder: {
                        
                        ProgressView()
                    }
                    .cornerRadius(10.0)
                    .frame(width: 393, height: 267)
                    .clipped()
                    .offset(y: -8)
                    Text(hospital.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.leading, 15)
                 
                
                VStack {
                    LazyVStack(alignment: .leading, spacing: 15) {
                       
                        Section(header: Text("Endereço")
                            .font(.body)
                            .bold()
                        ) {
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                Text(hospital.location)
                                    .multilineTextAlignment(.leading)
                                
                            })
                        }
                        .padding(.horizontal)
//                        .padding(.bottom)
                        
                        Section(header: Text("Especialidades")
                                .font(.body)
                                .bold()) {
                                    VStack{
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
                                                        .background(Color.hospitalPurple.opacity(0.2))
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
                                                        .background(Color.hospitalPurple.opacity(0.2))
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
                                                        .background(Color.hospitalPurple.opacity(0.2))
                                                        .cornerRadius(8)
                                                }
                                            }
                                        }
                                    }
                        }
                        .padding(.leading)
                        Section(header: Text("Contatos")
                            .font(.body)
                            .bold()
                        ) {
                            ForEach(hospital.number, id: \.self) { number in
                                Button(action: {
                                    makeCall(to: number)
                                }) {
                                    Text(number)
                                        .foregroundColor(.blue)
                                        .underline()
                                }
                                Button(action: {}, label: {
                                   
                                })
                                
                            }
                            Section(header: Text("Email")
                                .font(.body)
                                .bold()
                            ) {
                                ForEach(hospital.email, id: \.self) { email in
                                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                        Text(email)
                                        
                                        
                                        
                                    })
                                }
                            }
                         
                            Spacer()
                          
                        }
                        .padding(.horizontal, 15)
                    }
                    
                    
                }
//                .navigationTitle(hospital.navTitle)
                .navigationBarTitleDisplayMode(.inline)
                
            }
            .ignoresSafeArea()
            
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
    HospitalModel(title: "Hospital da Restauração", ambulatorio: ["Ambulatório", "Neurologia", "Neurocirurgia", "Ortopedia/traumatologia", "Cirurgia Vascular", "Cirurgia Geral", "Bucomaxilofacial", "Clínica Médica", "Emergência", "Cirurgia bucomaxilofacial", "Cirurgia Geral", "Cirurgia Vascular", "Clínica Médica", "Clínica Pediátrica", "Intoxicações", "Neurocirurgia", "Neurologia", "Queimaduras", "Traumato-ortopedia"], emergencia: [""], clinica: [""], navTitle: "Restauração", location: "Avenida Agamenon Magalhães, S/N\nDerby, Recife – PE", image: "https://portal.saude.pe.gov.br/wp-content/uploads/2024/06/HR-2.jpg", number: ["(81) 3181.5400"], email: ["cpl@lafepe.pe.gov.br"]) as! any View
}

