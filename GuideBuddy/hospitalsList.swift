//
//  hospitalsList.swift
//  GuideBuddy
//
//  Created by Deivson Pereira da Silva on 30/08/24.
//


import SwiftUI


struct HealthCategories: View {
    //Aqui logo abaixo temos uma let que estoca Structs com protocolo identifiable, que possuem título.
    let categories = [
        HealthyPlaceCategory(titulo: "Urgência e Emergência"),
        HealthyPlaceCategory(titulo: "Clínica Médica"),
        HealthyPlaceCategory(titulo: "Rede SUS - UFPE")
    ]
    
    var body: some View {
        NavigationStack {
            //Aqui eu faço uma lista que puxa a let co
            List(categories) { category in
                NavigationLink(
                    destination: HealthyPlaceOption(category: category)
                ) {
                    Text(category.titulo)
                }
            }
            .navigationTitle("Saúde")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct HealthyPlaceOption: View {
    let category: HealthyPlaceCategory

    // Estado para controlar a exibição do sheet
    @State private var selectedHospital: MockHospital?
    
    private let hospitalsByCategory: [String: [MockHospital]] = [
        "Urgência e Emergência": [
            MockHospital(titulo: "Hospital da Restauração"),
            MockHospital(titulo: "UPA Caxangá"),
            MockHospital(titulo: "Hospital Ulysses Pernambucano"),
            MockHospital(titulo: "UPA Ibura"),
            MockHospital(titulo: "UPA Curado")
        ],
        
        "Clínica Médica": [
            MockHospital(titulo: "Dois Irmãos"),
            MockHospital(titulo: "Engenho do Meio"),
            MockHospital(titulo: "Iputinga"),
            MockHospital(titulo: "Várzea")
        ],
        
        "Rede SUS - UFPE": [
            MockHospital(titulo: "Serviço de Psicologia Aplicada da UFPE (SPA)"),
            MockHospital(titulo: "Centro de Especialidades Odontológicas (CEO)"),
            MockHospital(titulo: "Complexo de Clínicas-escolas de Odontologia"),
            MockHospital(titulo: "Serviço de Radiologia Odontológica"),
            MockHospital(titulo: "Serviço de Patologia Oral"),
            MockHospital(titulo: "Academia Escola"),
            MockHospital(titulo: "Serviço-Escola de Nutrição Emília Aureliano"),
            MockHospital(titulo: "Clínica Escola de Fisioterapia"),
            MockHospital(titulo: "Clínica Escola de Fonoaudiologia da UFPE"),
            MockHospital(titulo: "Laboratório de Micologia Médica Sylvio Campos"),
            MockHospital(titulo: "Unidade de Cuidados Integrados – Serviço Integrado de Saúde (UCIS-SIS)")
        ]
    ]
    
    var body: some View {
        let hospitalOptions = hospitalsByCategory[category.titulo] ?? []
        
        List(hospitalOptions) { hospital in
            Button(action: {
                selectedHospital = hospital
            }) {
                Text(hospital.titulo)
                    .foregroundStyle(Color.black)
                 
            }
            .sheet(item: $selectedHospital) { hospital in
                HealthyPlaceDescription(hospital: hospital)
            }
        }
        .navigationTitle("\(category.titulo)")
    }
}


struct HealthyPlaceDescription: View {
    let hospital: MockHospital
    
    // Dicionário que mapeia hospitais para suas descrições
    private let descriptionsByHospital: [String: String] = [
        "Hospital da Restauração": hospitalDescription[1],
        "UPA Caxangá": hospitalDescription[0],
        "Hospital Ulysses Pernambucano": hospitalDescription[2],
        "UPA Ibura": hospitalDescription[3],
        "UPA Curado": hospitalDescription[4],
        "Serviço de Psicologia Aplicada da UFPE (SPA)": hospitalDescription[5],
        "Centro de Especialidades Odontológicas (CEO)": hospitalDescription[6],
        "Complexo de Clínicas-escolas de Odontologia": hospitalDescription[7],
        "Serviço de Radiologia Odontológica": hospitalDescription[8],
        "Serviço de Patologia Oral": hospitalDescription[9],
        "Academia Escola": hospitalDescription[10],
        "Serviço-Escola de Nutrição Emília Aureliano": hospitalDescription[11],
        "Clínica Escola de Fisioterapia": hospitalDescription[12],
        "Clínica Escola de Fonoaudiologia da UFPE": hospitalDescription[13],
        "Laboratório de Micologia Médica Sylvio Campos": hospitalDescription[14],
        "Unidade de Cuidados Integrados – Serviço Integrado de Saúde (UCIS-SIS)": hospitalDescription[15],
        "Dois Irmãos": hospitalDescription[16],
        "Engenho do Meio": hospitalDescription[17],
        "Iputinga": hospitalDescription[18],
        "Várzea": hospitalDescription[19]
       
    ]
    
    var body: some View {
           VStack(alignment: .center, spacing: 16) {
               // Indicador visual para deslizar
               Capsule()
                   .fill(Color.gray.opacity(0.5))
                   .frame(width: 50, height: 6)
                   .padding(.top, 8)
                   
               
               HStack {
                   Text(descriptionsByHospital[hospital.titulo] ?? "Descrição não disponível.")
                       .padding()
                   .multilineTextAlignment(.leading)
                   .offset(x: -10)
               }
               
               Spacer()
           }
           .frame(maxWidth: .infinity, maxHeight: .infinity)
           .background(Color.white)
           .clipShape(RoundedRectangle(cornerRadius: 15))
           .padding()
           .navigationTitle(hospital.titulo)
           .navigationBarTitleDisplayMode(.inline)
           
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

