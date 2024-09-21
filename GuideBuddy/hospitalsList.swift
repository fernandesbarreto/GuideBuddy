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
    @State private var selectedHospital: HospitalModel?
    
    private let hospitalsByCategory: [String: [HospitalModel]] = [
        "Urgência e Emergência": [
            HospitalModel(title: "Hospital da Restauração", ambulatorio: ["Neurologia", "Neurocirurgia", "Ortopedia/traumatologia", "Cirurgia Vascular", "Cirurgia Geral", "Bucomaxilofacial"], emergencia: ["Cirurgia bucomaxilofacial", "Cirurgia Geral", "Cirurgia Vascular", "Clínica Médica", "Clínica Pediátrica", "Intoxicações", "Neurocirurgia", "Neurologia", "Queimaduras", "Traumato-ortopedia"], clinica: ["Sim"], navTitle: "Restauração", location: "Avenida Agamenon Magalhães, S/N\nDerby, Recife – PE", image: "https://portal.saude.pe.gov.br/wp-content/uploads/2024/06/HR-2.jpg", number: ["(81) 3181.5400"], email: ["cpl@lafepe.pe.gov.br"]),
            HospitalModel(title: "UPA Caxangá", ambulatorio: ["Sim"], emergencia: ["Sim"], clinica: ["Pediatria", "Traumato-ortopedia"]
           , navTitle: "UPA Caxangá", location: "Avenida Caxangá, S/N – Várzea Recife – PE", image: "https://www.hospitalmarialucinda.org/assets/images/unidades/principal-upa---caxanga-upa-caxanga-01.jpg", number: ["(81) 3184-4355"], email: ["admupacaxanga@fmsa.org.br"]),
            HospitalModel(title: "Hospital Ulysses Pernambucano", ambulatorio: ["Sim"], emergencia: ["Sim"], clinica: ["Psiquiatria", "Traumato-ortopedia", "Oftalmologia"], navTitle: "Ulisses Pernambucano", location: "Av. Conselheiro Rosa e Silva, 2130 - Tamarineira, Recife - PE, 52050-020", image: "https://portal.saude.pe.gov.br/wp-content/uploads/2024/06/WhatsApp-Image-2024-06-27-at-16.49.27.jpeg", number: ["(81) 3182-9906", "(81) 3182.9912", "(81) 3182.9921"], email: ["N/A"]),
            HospitalModel(title: "UPA Ibura", ambulatorio: ["Sim"], emergencia: ["Sim"], clinica: ["Psiquiatria", "Traumato-ortopedia", "Oftalmologia"], navTitle: "UPA Ibura", location: "Rua Vale do Itajaí, S/N – Ibura – Recife", image: "https://www.diariodepernambuco.com.br/static/app/noticia_127983242361/2021/03/14/855056/20210314141829347316i.jpg", number: ["(81) 3184-4595", "(81) 3184-4616"], email: ["contato@upaibura.org.br"]),
            HospitalModel(title: "UPA Curado", ambulatorio: ["Sim"], emergencia: ["Sim"], clinica: ["Pediatria", "Traumatologia"], navTitle: "UPA Curado", location: "Avenida Leonardo da Vinci, 68 – Curado II – Jaboatão dos Guararapes", image: "https://upacurado.org.br/images/carrossel/upa-curado-imageminternet_new.jpg", number: ["(81) 3184-4467"], email: ["julianaandrade@upacurado.org.br"])
            
            
        ],
//        
        "Clínica Médica": [
            HospitalModel(title: "Dois Irmãos", ambulatorio: [""], emergencia: [""], clinica: [""], navTitle: "", location: "", image: "", number: [""], email: [""]),
            HospitalModel(title: "Engenho do Meio", ambulatorio: [""], emergencia: [""], clinica: [""], navTitle: "", location: "", image: "", number: [""], email: [""]),
            HospitalModel(title: "Iputinga", ambulatorio: [""], emergencia: [""], clinica: [""], navTitle: "", location: "", image: "", number: [""], email: [""]),
            HospitalModel(title: "Várzea", ambulatorio: [""], emergencia: [""], clinica: [""], navTitle: "", location: "", image: "", number: [""], email: [""])],

        
        "Rede SUS - UFPE": [
            HospitalModel(title: "Serviço de Psicologia Aplicada da UFPE (SPA)", ambulatorio: [""], emergencia: [""], clinica: [""], navTitle: "", location: "", image: "", number: [""], email: [""]),
            HospitalModel(title: "Centro de Especialidades Odontológicas (CEO)", ambulatorio: [""], emergencia: [""], clinica: [""], navTitle: "", location: "", image: "", number: [""], email: [""]),
            HospitalModel(title: "Complexo de Clínicas-escolas de Odontologia", ambulatorio: [""], emergencia: [""], clinica: [""], navTitle: "", location: "", image: "", number: [""], email: [""]),
            HospitalModel(title: "Serviço de Radiologia Odontológica", ambulatorio: [""], emergencia: [""], clinica: [""], navTitle: "", location: "", image: "", number: [""], email: [""]),
            HospitalModel(title: "Serviço de Patologia Oral", ambulatorio: [""], emergencia: [""], clinica: [""], navTitle: "", location: "", image: "", number: [""], email: [""]),
            HospitalModel(title: "Academia Escola", ambulatorio: [""], emergencia: [""], clinica: [""], navTitle: "", location: "", image: "", number: [""], email: [""]),
            HospitalModel(title: "Serviço-Escola de Nutrição Emília Aurelian", ambulatorio: [""], emergencia: [""], clinica: [""], navTitle: "", location: "", image: "", number: [""], email: [""]),
            HospitalModel(title: "Clínica Escola de Fisioterapia", ambulatorio: [""], emergencia: [""], clinica: [""], navTitle: "", location: "", image: "", number: [""], email: [""]),
            HospitalModel(title: "Clínica Escola de Fisioterapia", ambulatorio: [""], emergencia: [""], clinica: [""], navTitle: "", location: "", image: "", number: [""], email: [""]),
            HospitalModel(title: "Clínica Escola de Fonoaudiologia da UFPE", ambulatorio: [""], emergencia: [""], clinica: [""], navTitle: "", location: "", image: "", number: [""], email: [""]),
            HospitalModel(title: "Clínica Escola de Fonoaudiologia da UFPE", ambulatorio: [""], emergencia: [""], clinica: [""], navTitle: "", location: "", image: "", number: [""], email: [""]),
            HospitalModel(title: "Laboratório de Micologia Médica Sylvio Campos", ambulatorio: [""], emergencia: [""], clinica: [""], navTitle: "", location: "", image: "", number: [""], email: [""]),
            HospitalModel(title: "Unidade de Cuidados Integrados – Serviço Integrado de Saúde (UCIS-SIS)", ambulatorio: [""], emergencia: [""], clinica: [""], navTitle: "", location: "", image: "", number: [""], email: [""])
        ]
    ]
    
    var body: some View {
        let hospitalOptions = hospitalsByCategory[category.titulo] ?? []
//        @State var hospitalOptions: [HospitalModel] = allHospitalPlaces
        
        List(hospitalOptions) { hospital in
            NavigationLink(destination: {
                HospitalView(hospital: hospital)
            }) {
                Text(hospital.title)
                    .foregroundStyle(Color.black)
                 
            }
//            .sheet(item: $selectedHospital) { hospital in
//                HealthyPlaceDescription(hospital: hospital)
//            }
        }
        .navigationTitle("\(category.titulo)")
    }
}


struct HealthyPlaceDescription: View {
    let hospital: MockHospital

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

