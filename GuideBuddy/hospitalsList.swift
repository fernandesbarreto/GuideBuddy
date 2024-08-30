//
//  hospitalsList.swift
//  GuideBuddy
//
//  Created by Deivson Pereira da Silva on 30/08/24.
//


import SwiftUI

struct ListaDeHospitaisView: View {
    let categories = [
    
        HealthyPlaceCategory(titulo: "Urgência e Emergência"),
        HealthyPlaceCategory(titulo: "Clínica médica"),
        HealthyPlaceCategory(titulo: "Saúde mental")
        
    ]
    
    var body: some View {
        NavigationView {
            List(categories) { doc in       // abaixo a segunda struct, o destino
                NavigationLink(destination: HealthyPlaceOption ()) {
                    Text(doc.titulo)
                }
            }
            .navigationTitle("Hospitais")
        }
    }
    
}


struct HealthyPlaceOption:View {
    
    let hospitalOptions = [
    
        MockHospital(titulo: "h1, h2, h3"),
        MockHospital(titulo: "h4, h5, h6"),
        MockHospital(titulo: "h7, h8, h9")
        
    ]
    
    var body: some View {
        
        NavigationView {
            List(hospitalOptions) { doc in
                NavigationLink(destination: HealthyPlaceDescription ()) {
                    Text(doc.titulo)
                }
            }
            .navigationTitle("Hospitais dessa categoria")
        }
    }
}


struct HealthyPlaceDescription:View {
    
    let hosptitalDescricao = [
    
        HospitalDescricao(titulo: "hi blablabla"),
        HospitalDescricao(titulo: "hi blablabla"),
        HospitalDescricao(titulo: "hi blablabla")
        
    ]

    var body: some View {
    
        Text ("Colocar algo aqui")
        
    }
}



struct MockHospital: Identifiable {
    var id = UUID()
    var titulo: String
}

struct HospitalDescricao: Identifiable {
    var id = UUID()
    var titulo: String
}





struct  HealthyPlaceCategory: Identifiable {
    let id = UUID()
    let titulo: String
}

#Preview {
    ListaDeHospitaisView()
}

