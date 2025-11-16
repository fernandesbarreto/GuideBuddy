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
        HealthyPlaceCategory(titulo: "Clínica Médica"),
        HealthyPlaceCategory(titulo: "Rede SUS - UFPE")
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
            .navigationTitle("saude".localized)
//            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct HealthyPlaceOption: View {
    let category: HealthyPlaceCategory


    @State private var selectedHospital: HospitalModel?
    
    private let clinicsByCategory: [String: [ClinicModel]] = [
        "Clínica Médica": susClinicas
    ]
    
    private let hospitalsByCategory: [String: [HospitalModel]] = [
        "Urgência e Emergência": allHospitalPlaces,
//
//        "Clínica Médica": [
//            HospitalModel(title: "Dois Irmãos", ambulatorio: [""], emergencia: [""], clinica: [""], navTitle: "", location: "", image: "", number: [""], email: [""], latitude: 00, longitude: 00),
//            HospitalModel(title: "Engenho do Meio", ambulatorio: [""], emergencia: [""], clinica: [""], navTitle: "", location: "", image: "", number: [""], email: [""], latitude: 00, longitude: 00),
//            HospitalModel(title: "Iputinga", ambulatorio: [""], emergencia: [""], clinica: [""], navTitle: "", location: "", image: "", number: [""], email: [""], latitude: 00, longitude: 00),
//            HospitalModel(title: "Várzea", ambulatorio: [""], emergencia: [""], clinica: [""], navTitle: "", location: "", image: "", number: [""], email: [""], latitude: 00, longitude: 00)],

        
        "Rede SUS - UFPE": [
            HospitalModel(
                title: "Serviço de Psicologia Aplicada da UFPE (SPA)",
                ambulatorio: ["Sim"],
                emergencia: ["Não"],
                clinica: ["Psicologia"],
                navTitle: "SPA",
                location: "Rua Acadêmico Hélio Ramos, 600, Cidade Universitária, Recife, PE",
                image: "https://www.ufpe.br/documents/3488321/3488552/Frente+do+SPA/b0a13b40-7b49-484a-9f43-200496f83c22?t=1622228532711",
                number: ["(81) 2126-8731"],
                email: ["secretaria.spa@ufpe.br"],
                latitude: -8.05044,
                longitude: -34.95471
            ),

            HospitalModel(
                title: "Centro de Especialidades Odontológicas (CEO)",
                ambulatorio: ["Sim"],
                emergencia: ["Não"],
                clinica: ["Odontologia"],
                navTitle: "CEO",
                location: "Av. da Engenharia, Cidade Universitária, Recife, PE",
                image: "https://scontent.frec21-1.fna.fbcdn.net/v/t39.30808-6/317071687_515346277286346_914962472050471599_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=h7grR2GLqwEQ7kNvwEbt2Ec&_nc_oc=AdlHakGdyq1vbMlOHLYZmYuTnHKfkXizj2xZy5He3CLvFUpKjcyk4EyfDaO8aeWBIyxWg7SMfFVglEsEQUnum9IT&_nc_zt=23&_nc_ht=scontent.frec21-1.fna&_nc_gid=kj-nOPAPRLHMGhjSAGDk6Q&oh=00_AfjjRH2YPD-vuGSeJwvEusdh3CpRjDB1vdAePnCAEMRcyA&oe=69202A71",
                number: ["(81) 2126-8826"],
                email: ["odonto.preventiva@ufpe.br"],
                latitude: -8.04628,
                longitude: -34.95159
            ),

            HospitalModel(
                title: "Complexo de Clínicas-escolas de Odontologia",
                ambulatorio: ["Sim"],
                emergencia: ["Não"],
                clinica: ["Odontologia"],
                navTitle: "Clínicas Odonto",
                location: "Av. da Engenharia, Cidade Universitária, Recife, PE",
                image: "https://scontent.frec21-1.fna.fbcdn.net/v/t39.30808-6/317071687_515346277286346_914962472050471599_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=h7grR2GLqwEQ7kNvwEbt2Ec&_nc_oc=AdlHakGdyq1vbMlOHLYZmYuTnHKfkXizj2xZy5He3CLvFUpKjcyk4EyfDaO8aeWBIyxWg7SMfFVglEsEQUnum9IT&_nc_zt=23&_nc_ht=scontent.frec21-1.fna&_nc_gid=kj-nOPAPRLHMGhjSAGDk6Q&oh=00_AfjjRH2YPD-vuGSeJwvEusdh3CpRjDB1vdAePnCAEMRcyA&oe=69202A71",
                number: ["(81) 2126-8830"],
                email: ["odonto.preventiva@ufpe.br"],
                latitude: -8.04620,
                longitude: -34.95150
            ),

            HospitalModel(
                title: "Serviço de Radiologia Odontológica",
                ambulatorio: ["Sim"],
                emergencia: ["Não"],
                clinica: ["Radiologia Odontológica"],
                navTitle: "Radiologia Odonto",
                location: "Av. da Engenharia, Cidade Universitária, Recife, PE",
                image: "https://scontent.frec21-1.fna.fbcdn.net/v/t39.30808-6/317071687_515346277286346_914962472050471599_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=h7grR2GLqwEQ7kNvwEbt2Ec&_nc_oc=AdlHakGdyq1vbMlOHLYZmYuTnHKfkXizj2xZy5He3CLvFUpKjcyk4EyfDaO8aeWBIyxWg7SMfFVglEsEQUnum9IT&_nc_zt=23&_nc_ht=scontent.frec21-1.fna&_nc_gid=kj-nOPAPRLHMGhjSAGDk6Q&oh=00_AfjjRH2YPD-vuGSeJwvEusdh3CpRjDB1vdAePnCAEMRcyA&oe=69202A71",
                number: ["Não"],
                email: ["Não"],
                latitude: -8.04621,
                longitude: -34.95152
            ),

            HospitalModel(
                title: "Serviço de Patologia Oral",
                ambulatorio: ["Sim"],
                emergencia: ["Não"],
                clinica: ["Patologia Oral"],
                navTitle: "Patologia Oral",
                location: "Av. da Engenharia, Cidade Universitária, Recife, PE",
                image: "https://scontent.frec21-1.fna.fbcdn.net/v/t39.30808-6/317071687_515346277286346_914962472050471599_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=h7grR2GLqwEQ7kNvwEbt2Ec&_nc_oc=AdlHakGdyq1vbMlOHLYZmYuTnHKfkXizj2xZy5He3CLvFUpKjcyk4EyfDaO8aeWBIyxWg7SMfFVglEsEQUnum9IT&_nc_zt=23&_nc_ht=scontent.frec21-1.fna&_nc_gid=kj-nOPAPRLHMGhjSAGDk6Q&oh=00_AfjjRH2YPD-vuGSeJwvEusdh3CpRjDB1vdAePnCAEMRcyA&oe=69202A71",
                number: ["Não"],
                email: ["Não"],
                latitude: -8.04622,
                longitude: -34.95153
            ),

            HospitalModel(
                title: "Academia Escola",
                ambulatorio: ["Sim"],
                emergencia: ["Não"],
                clinica: ["Educação Física"],
                navTitle: "Academia Escola",
                location: "Av. Jornalista Aníbal Fernandes, Cidade Universitária, Recife, PE",
                image: "https://scontent.frec21-1.fna.fbcdn.net/v/t39.30808-6/317071687_515346277286346_914962472050471599_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=h7grR2GLqwEQ7kNvwEbt2Ec&_nc_oc=AdlHakGdyq1vbMlOHLYZmYuTnHKfkXizj2xZy5He3CLvFUpKjcyk4EyfDaO8aeWBIyxWg7SMfFVglEsEQUnum9IT&_nc_zt=23&_nc_ht=scontent.frec21-1.fna&_nc_gid=kj-nOPAPRLHMGhjSAGDk6Q&oh=00_AfjjRH2YPD-vuGSeJwvEusdh3CpRjDB1vdAePnCAEMRcyA&oe=69202A71",
                number: ["(81) 2126-7696"],
                email: ["academia.escola@ufpe.br"],
                latitude: -8.05010,
                longitude: -34.94860
            ),

            HospitalModel(
                title: "Serviço-Escola de Nutrição Emília Aureliano (SENEA)",
                ambulatorio: ["Sim"],
                emergencia: ["Não"],
                clinica: ["Nutrição"],
                navTitle: "SENEA",
                location: "Av. da Engenharia, Cidade Universitária, Recife, PE",
                image: "https://scontent.frec21-1.fna.fbcdn.net/v/t39.30808-6/317071687_515346277286346_914962472050471599_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=h7grR2GLqwEQ7kNvwEbt2Ec&_nc_oc=AdlHakGdyq1vbMlOHLYZmYuTnHKfkXizj2xZy5He3CLvFUpKjcyk4EyfDaO8aeWBIyxWg7SMfFVglEsEQUnum9IT&_nc_zt=23&_nc_ht=scontent.frec21-1.fna&_nc_gid=kj-nOPAPRLHMGhjSAGDk6Q&oh=00_AfjjRH2YPD-vuGSeJwvEusdh3CpRjDB1vdAePnCAEMRcyA&oe=69202A71",
                number: ["(81) 2126-3181"],
                email: ["senea.nutricao@ufpe.br"],
                latitude: -8.04650,
                longitude: -34.95170
            ),

            HospitalModel(
                title: "Clínica Escola de Fisioterapia",
                ambulatorio: ["Sim"],
                emergencia: ["Não"],
                clinica: ["Fisioterapia"],
                navTitle: "Fisioterapia",
                location: "Av. Prof. Moraes Rego, 1235, Cidade Universitária, Recife, PE",
                image: "https://scontent.frec21-1.fna.fbcdn.net/v/t39.30808-6/317071687_515346277286346_914962472050471599_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=h7grR2GLqwEQ7kNvwEbt2Ec&_nc_oc=AdlHakGdyq1vbMlOHLYZmYuTnHKfkXizj2xZy5He3CLvFUpKjcyk4EyfDaO8aeWBIyxWg7SMfFVglEsEQUnum9IT&_nc_zt=23&_nc_ht=scontent.frec21-1.fna&_nc_gid=kj-nOPAPRLHMGhjSAGDk6Q&oh=00_AfjjRH2YPD-vuGSeJwvEusdh3CpRjDB1vdAePnCAEMRcyA&oe=69202A71",
                number: ["(81) 2126-7696"],
                email: ["clinica.fisioterapia@ufpe.br"],
                latitude: -8.05020,
                longitude: -34.95200
            ),

            HospitalModel(
                title: "Clínica Escola de Fonoaudiologia da UFPE",
                ambulatorio: ["Sim"],
                emergencia: ["Não"],
                clinica: ["Fonoaudiologia"],
                navTitle: "Fonoaudiologia",
                location: "Av. Prof. Moraes Rego, Cidade Universitária, Recife, PE",
                image: "https://scontent.frec21-1.fna.fbcdn.net/v/t39.30808-6/317071687_515346277286346_914962472050471599_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=h7grR2GLqwEQ7kNvwEbt2Ec&_nc_oc=AdlHakGdyq1vbMlOHLYZmYuTnHKfkXizj2xZy5He3CLvFUpKjcyk4EyfDaO8aeWBIyxWg7SMfFVglEsEQUnum9IT&_nc_zt=23&_nc_ht=scontent.frec21-1.fna&_nc_gid=kj-nOPAPRLHMGhjSAGDk6Q&oh=00_AfjjRH2YPD-vuGSeJwvEusdh3CpRjDB1vdAePnCAEMRcyA&oe=69202A71",
                number: ["(81) 2126-7518"],
                email: ["Não"],
                latitude: -8.05030,
                longitude: -34.95210
            ),

            HospitalModel(
                title: "Laboratório de Micologia Médica Sylvio Campos",
                ambulatorio: ["Sim"],
                emergencia: ["Não"],
                clinica: ["Micologia"],
                navTitle: "Micologia",
                location: "Av. da Engenharia, Cidade Universitária, Recife, PE, CEP 52171-011",
                image: "https://scontent.frec21-1.fna.fbcdn.net/v/t39.30808-6/317071687_515346277286346_914962472050471599_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=h7grR2GLqwEQ7kNvwEbt2Ec&_nc_oc=AdlHakGdyq1vbMlOHLYZmYuTnHKfkXizj2xZy5He3CLvFUpKjcyk4EyfDaO8aeWBIyxWg7SMfFVglEsEQUnum9IT&_nc_zt=23&_nc_ht=scontent.frec21-1.fna&_nc_gid=kj-nOPAPRLHMGhjSAGDk6Q&oh=00_AfjjRH2YPD-vuGSeJwvEusdh3CpRjDB1vdAePnCAEMRcyA&oe=69202A71",
                number: ["(81) 2126-8570"],
                email: ["labmicomed@gmail.com"],
                latitude: -8.04640,
                longitude: -34.95140
            ),

            HospitalModel(
                title: "Unidade de Cuidados Integrados – Serviço Integrado de Saúde (UCIS-SIS)",
                ambulatorio: ["Sim"],
                emergencia: ["Não"],
                clinica: ["Multidisciplinar"],
                navTitle: "UCIS-SIS",
                location: "Rua Lindolfo Color, 65, Engenho do Meio, Recife, PE",
                image: "https://scontent.frec21-1.fna.fbcdn.net/v/t39.30808-6/317071687_515346277286346_914962472050471599_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=h7grR2GLqwEQ7kNvwEbt2Ec&_nc_oc=AdlHakGdyq1vbMlOHLYZmYuTnHKfkXizj2xZy5He3CLvFUpKjcyk4EyfDaO8aeWBIyxWg7SMfFVglEsEQUnum9IT&_nc_zt=23&_nc_ht=scontent.frec21-1.fna&_nc_gid=kj-nOPAPRLHMGhjSAGDk6Q&oh=00_AfjjRH2YPD-vuGSeJwvEusdh3CpRjDB1vdAePnCAEMRcyA&oe=69202A71",
                number: ["(81) 2126-3176", "(81) 3355-0405"],
                email: ["ufpe.sis@ufpe.br"],
                latitude: -8.05090,
                longitude: -34.95510
            )
        ]
]
    
    var body: some View {
        // Verifica se é a categoria "Clínica Médica" para usar ClinicModel
        if category.titulo == "Clínica Médica" {
            let clinicOptions = clinicsByCategory[category.titulo] ?? []
            
            List(clinicOptions) { clinic in
                NavigationLink(destination: {
                    ClinicView(clinic: clinic)
                }) {
                    Text(clinic.title)
                }
            }
            .navigationTitle("\(category.titulo)")
        } else {
            // Para outras categorias, usa HospitalModel
            let hospitalOptions = hospitalsByCategory[category.titulo] ?? []
            
            List(hospitalOptions) { hospital in
                NavigationLink(destination: {
                    HospitalView(hospital: hospital)
                }) {
                    Text(hospital.title)
                }
            }
            .navigationTitle("\(category.titulo)")
        }
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

