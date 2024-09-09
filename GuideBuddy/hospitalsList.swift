//
//  hospitalsList.swift
//  GuideBuddy
//
//  Created by Deivson Pereira da Silva on 30/08/24.
//


import SwiftUI

struct HealthCategories: View {
    let categories = [
        HealthyPlaceCategory(titulo: "Urgência e Emergência"),
        HealthyPlaceCategory(titulo: "Clínica médica")
    ]
    
    var body: some View {
        NavigationStack {
            List(categories) { category in
                NavigationLink(
                    destination: HealthyPlaceOption(category: category)
                ) {
                    Text(category.titulo)
                }
            }
            .navigationTitle("Categorias de Saúde")
          
        }
    }
}

struct HealthyPlaceOption: View {
    let category: HealthyPlaceCategory

    // Dicionário que mapeia categorias para suas listas de hospitais
    private let hospitalsByCategory: [String: [MockHospital]] = [
        "Urgência e Emergência": [
            MockHospital(titulo: "Hospital da Restauração"),
            MockHospital(titulo: "UPA Caxangá"),
            MockHospital(titulo: "Hospital C")
        ],
        "Clínica médica": [
            MockHospital(titulo: "Clínica A"),
            MockHospital(titulo: "Clínica B"),
            MockHospital(titulo: "Clínica C")
        ]
    ]
    
    var body: some View {
        let hospitalOptions = hospitalsByCategory[category.titulo] ?? []
        
        List(hospitalOptions) { hospital in
            NavigationLink(
                destination: HealthyPlaceDescription(hospital: hospital)
            ) {
                Text(hospital.titulo)
            }
        }
        .navigationTitle("Hospitais para \(category.titulo)")
    }
}

struct HealthyPlaceDescription: View {
    let hospital: MockHospital
    
    // Dicionário que mapeia hospitais para suas descrições
    private let descriptionsByHospital: [String: String] = [
        "Hospital da Restauração": "Descrição detalhada do Hospital da Restauração.",
        "UPA Caxangá": hospitalDescription[0],
        "Hospital C": "Descrição detalhada do Hospital C.",
        "Clínica A": "Descrição detalhada da Clínica A.",
        "Clínica B": "Descrição detalhada da Clínica B.",
        "Clínica C": "Descrição detalhada da Clínica C."
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(hospital.titulo)
                .font(.title)
                .padding(.bottom, 8)
            Text(descriptionsByHospital[hospital.titulo] ?? "Descrição não disponível.")
                .padding()
        }
        .navigationTitle(hospital.titulo)
    }
}

struct MockHospital: Identifiable {
    var id = UUID()
    var titulo: String
}

struct HealthyPlaceCategory: Identifiable {
    let id = UUID()
    let titulo: String
}

#Preview {
    HealthCategories()
}

