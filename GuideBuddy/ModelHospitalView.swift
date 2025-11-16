//
//  ModelHospitalView.swift
//  GuiBu
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 21/09/24.
//

import Foundation

struct ClinicModel: Identifiable {
    let id = UUID()
    let title: String
    let ambulatorio: [String]
    let emergencia: [String]
    let clinica: [String]
    let navTitle: String
    let location: String
    let number: [String]
    let email: [String]
    let latitude: Double?
    let longitude: Double?
}

struct HospitalModel: Identifiable{
    var id = UUID()
    var title: String
    var ambulatorio: [String]
    var emergencia: [String]
    var clinica: [String]
    var navTitle: String
    var location: String
    var image: String
    var number: [String]
    var email: [String]
    var latitude: Double
    var longitude: Double
    
    init(title: String, ambulatorio: [String], emergencia: [String], clinica: [String], navTitle: String, location: String, image: String, number: [String], email: [String], latitude: Double, longitude: Double) {
        self.title = title
        self.ambulatorio = ambulatorio
        self.emergencia = emergencia
        self.clinica = clinica
        self.navTitle = navTitle
        self.location = location
        self.image = image
        self.number = number
        self.email = email
        self.latitude = latitude
        self.longitude = longitude
    }
}
let allHospitalPlaces = [
    HospitalModel(title: "Hospital da Restauração", ambulatorio: ["Ambulatório", "Neurologia", "Neurocirurgia", "Ortopedia/traumatologia", "Cirurgia Vascular", "Cirurgia Geral", "Bucomaxilofacial", "Clínica Médica", "Emergência", "Queimaduras"], emergencia: ["Emergência Geral", "Trauma", "Queimados", "Neurocirurgia"], clinica: ["Clínica Médica", "Clínica Cirúrgica"], navTitle: "Restauração", location: "Avenida Agamenon Magalhães, S/N\nDerby, Recife – PE", image: "https://portal.saude.pe.gov.br/wp-content/uploads/2024/06/HR-2.jpg", number: ["(81) 3181.5400"], email: ["cpl@lafepe.pe.gov.br"], latitude: 00, longitude: 00),
    HospitalModel(title: "UPA Caxangá", ambulatorio: ["Clínica médica", "Pediatria", "Traumato-ortopedia"], emergencia: ["Urgência e Emergência 24h"], clinica: ["Clínica Médica"], navTitle: "UPA Caxangá", location: "Avenida Caxangá, S/N (em frente ao nº 40 da Rua Ribeiro Pessoa) – Várzea Recife – PE", image: "https://www.hospitalmarialucinda.org/assets/images/unidades/principal-upa---caxanga-upa-caxanga-01.jpg", number: ["(81) 3184-4355"], email: ["admupacaxanga@fmsa.org.br"], latitude: 00, longitude: 00),
    HospitalModel(title: "Hospital Ulysses Pernambucano", ambulatorio: ["Psiquiatria", "Saúde Mental"], emergencia: ["Emergência Psiquiátrica 24h"], clinica: ["Saúde Mental"], navTitle: "Ulisses Pernambucano", location: "Av. Conselheiro Rosa e Silva, 2130 - Tamarineira, Recife - PE, 52050-020", image: "", number: ["(81) 3182-9906"], email: [""], latitude: 00, longitude: 00),
    HospitalModel(title: "Hospital Agamenon Magalhães (HAM)", ambulatorio: ["Clínica Médica", "Cirurgia Geral", "Ginecologia", "Obstetrícia", "Otorrinolaringologia"], emergencia: ["Emergência Geral 24h", "Emergência Obstétrica"], clinica: ["Clínica Médica", "Clínica Cirúrgica"], navTitle: "HAM", location: "Estrada do Arraial, 2723 - Casa Amarela, Recife, PE", image: "", number: ["(81) 3184-2000"], email: [""], latitude: 00, longitude: 00),
    HospitalModel(title: "Hospital Getúlio Vargas (HGV)", ambulatorio: ["Clínica Médica", "Cirurgia Geral", "Ortopedia", "Traumatologia"], emergencia: ["Emergência Ortopédica/Traumatológica", "Emergência Geral 24h"], clinica: ["Clínica Médica", "Clínica Cirúrgica"], navTitle: "HGV", location: "Av. Gen. Lídio Paraíso, 305 - Cordeiro, Recife, PE", image: "", number: ["(81) 3184-2300"], email: [""], latitude: 00, longitude: 00),
    HospitalModel(title: "Hospital Geral de Areias (SPA Cravo Gama)", ambulatorio: ["Pediatria", "Urgência Odontológica"], emergencia: ["SPA Infantil 24h"], clinica: ["Clínica Pediátrica"], navTitle: "SPA Areias", location: "Av. Recife, 810 - Areias, Recife, PE", image: "", number: ["(81) 3182-3004"], email: [""], latitude: 00, longitude: 00),
    HospitalModel(title: "Hospital da Mulher do Recife (HMR)", ambulatorio: ["Ginecologia", "Obstetrícia", "Neonatologia"], emergencia: ["Emergência Ginecológica e Obstétrica 24h"], clinica: ["Ginecologia", "Obstetrícia"], navTitle: "HMR", location: "Av. Recife, 5629 - Estância, Recife, PE", image: "", number: ["(81) 3303-3400"], email: [""], latitude: 00, longitude: 00),
    HospitalModel(title: "Maternidade Prof. Barros Lima", ambulatorio: ["Ginecologia", "Obstetrícia", "Pediatria", "Clínica Médica"], emergencia: ["SPA Adulto", "SPA Infantil", "Emergência Obstétrica 24h"], clinica: ["Clínica Médica", "Clínica Pediátrica"], navTitle: "Maternidade Barros Lima", location: "Av Norte, 6465 - Casa Amarela, Recife, PE", image: "", number: ["(81) 3355-2169"], email: [""], latitude: 00, longitude: 00),
    HospitalModel(title: "Maternidade Prof. Amaury Coutinho", ambulatorio: ["Ginecologia", "Obstetrícia", "Pediatria", "Clínica Médica"], emergencia: ["SPA Adulto", "SPA Infantil", "Emergência Obstétrica 24h"], clinica: ["Clínica Médica", "Clínica Pediátrica"], navTitle: "Maternidade Amaury Coutinho", location: "Rua Iguatu, S/N - Campina do Barreto, Recife, PE", image: "", number: ["(81) 3355-7891"], email: [""], latitude: 00, longitude: 00),
    HospitalModel(title: "Policlínica Agamenon Magalhães (SPA)", ambulatorio: ["Clínica Médica", "Urgência Odontológica"], emergencia: ["SPA Adulto 24h"], clinica: ["Clínica Médica"], navTitle: "SPA Agamenon Magalhães", location: "Largo da Paz, S/N - Afogados, Recife, PE", image: "", number: ["(81) 3355-2331"], email: [""], latitude: 00, longitude: 00),
    HospitalModel(title: "Policlínica e Maternidade Arnaldo Marques", ambulatorio: ["Ginecologia", "Obstetrícia", "Pediatria", "Clínica Médica"], emergencia: ["SPA Adulto", "SPA Infantil", "Emergência Obstétrica 24h"], clinica: ["Clínica Médica", "Clínica Pediátrica"], navTitle: "Maternidade Arnaldo Marques", location: "Av. Dois Rios, S/N - Cohab, Recife, PE", image: "", number: ["(81) 3355-1815"], email: [""], latitude: 00, longitude: 00),
    HospitalModel(title: "Hospital Otávio de Freitas (HOF)", ambulatorio: ["Clínica Médica", "Cirurgia Geral", "Ortopedia", "Traumatologia"], emergencia: ["Emergência Geral 24h"], clinica: ["Clínica Médica", "Clínica Cirúrgica"], navTitle: "HOF", location: "R. Dona Mariquinha de Oliveira, 117 - Cavaleiro, Jaboatão dos Guararapes (Atende Recife/RMR)", image: "", number: ["(81) 3184-4000"], email: [""], latitude: 00, longitude: 00),
    HospitalModel(title: "Hospital das Clínicas da UFPE (HC-UFPE)", ambulatorio: ["Diversas Especialidades"], emergencia: ["Emergência Geral (Referência Universitária)"], clinica: ["Clínica Médica", "Clínica Cirúrgica"], navTitle: "HC-UFPE", location: "Av. Prof. Moraes Rego, 1235 - Cidade Universitária, Recife, PE", image: "", number: ["(81) 2126-3500"], email: [""], latitude: 00, longitude: 00),
    HospitalModel(title: "UPA da Imbiribeira", ambulatorio: ["Clínica Médica", "Pediatria"], emergencia: ["Urgência e Emergência 24h"], clinica: ["Clínica Médica"], navTitle: "UPA Imbiribeira", location: "R. Padre Nestor de Alencar, 252 - Imbiribeira, Recife, PE", image: "", number: ["(81) 3184-0683"], email: [""], latitude: 00, longitude: 00),
    HospitalModel(title: "UPA Torrões", ambulatorio: ["Clínica Médica", "Pediatria"], emergencia: ["Urgência e Emergência 24h"], clinica: ["Clínica Médica"], navTitle: "UPA Torrões", location: "Av. Caxangá, S/N, ao lado da UPA Caxangá", image: "", number: ["(81) 3355-2403"], email: [""], latitude: 00, longitude: 00),
    HospitalModel(title: "Hospital Tricentenário (HT) - Olinda", ambulatorio: ["Clínica Médica", "Cirurgia", "Traumatologia", "Maternidade"], emergencia: ["Emergência Geral 24h", "Emergência Obstétrica"], clinica: ["Clínica Médica", "Clínica Cirúrgica"], navTitle: "Hospital Tricentenário", location: "Av. Olinda, 560 - Santa Tereza, Olinda, PE", image: "", number: ["(81) 3301-4400"], email: [""], latitude: 00, longitude: 00),
    HospitalModel(title: "UPA de Rio Doce - Olinda", ambulatorio: ["Clínica Médica", "Pediatria"], emergencia: ["Urgência e Emergência 24h"], clinica: ["Clínica Médica"], navTitle: "UPA Rio Doce", location: "Av. Nápoles - Rio Doce, Olinda, PE", image: "", number: ["(81) 3184-0660"], email: [""], latitude: 00, longitude: 00),
    HospitalModel(title: "UPA Jardim Brasil - Olinda", ambulatorio: ["Clínica Médica", "Pediatria"], emergencia: ["Urgência e Emergência 24h"], clinica: ["Clínica Médica"], navTitle: "UPA Jardim Brasil", location: "R. do Passarinho, 219 - Jardim Brasil, Olinda, PE", image: "", number: ["(81) 3184-0650"], email: [""], latitude: 00, longitude: 00),
    HospitalModel(title: "Policlínica Barros Barreto - Olinda", ambulatorio: ["Odontologia"], emergencia: ["Urgência Odontológica 24h"], clinica: ["Clínica Geral"], navTitle: "Policlínica Barros Barreto", location: "R. Farias Neves Sobrinho, 477 - Bairro Novo, Olinda, PE", image: "", number: ["(81) 3184-0601"], email: [""], latitude: 00, longitude: 00),
    HospitalModel(title: "Hospital São Salvador - Olinda", ambulatorio: ["Clínica Médica", "Cirurgia"], emergencia: ["Emergência Geral"], clinica: ["Clínica Médica", "Clínica Cirúrgica"], navTitle: "Hospital São Salvador", location: "Avenida Getúlio Vargas, 1937 - Bairro Novo, Olinda/PE", image: "", number: ["(81) 3334.1000"], email: [""], latitude: 00, longitude: 00),
    HospitalModel(title: "Hospital Nossa Senhora do Ó - Paulista", ambulatorio: ["Clínica Médica", "Cirurgia", "Maternidade"], emergencia: ["Emergência Geral 24h", "Emergência Obstétrica"], clinica: ["Clínica Médica", "Clínica Cirúrgica"], navTitle: "Hospital N. S. do Ó", location: "Av. Cláudio José Gueiros Leite, 1229 - Janga, Paulista - PE", image: "", number: ["(81) 3434.0405"], email: [""], latitude: 00, longitude: 00),
    HospitalModel(title: "UPA de Jardim Paulista - Paulista", ambulatorio: ["Clínica Médica", "Pediatria"], emergencia: ["Urgência e Emergência 24h"], clinica: ["Clínica Médica"], navTitle: "UPA Jardim Paulista", location: "Av. C, S/N - Jardim Paulista, Paulista - PE", image: "", number: ["(81) 3184-0690"], email: [""], latitude: 00, longitude: 00),
    HospitalModel(title: "Hospital Central Nossa Senhora Aparecida (HCNSA) - Paulista", ambulatorio: ["Clínica Médica", "Urgência"], emergencia: ["Emergência Geral (Referência)"], clinica: ["Clínica Médica"], navTitle: "HCNSA", location: "Vila Torres Galvão, Paulista, PE", image: "", number: ["(81) 3433-2811"], email: [""], latitude: 00, longitude: 00),
    HospitalModel(title: "UPA Nobre - Paulista", ambulatorio: ["Clínica Médica", "Pediatria"], emergencia: ["Urgência e Emergência 24h"], clinica: ["Clínica Médica"], navTitle: "UPA Nobre", location: "Rua Doutor José Mariano, 650 - Nobre, Paulista - PE", image: "", number: ["(81) 3184-0692"], email: [""], latitude: 00, longitude: 00),
    HospitalModel(title: "Hospital Mestre Vitalino (HMV) - Paulista", ambulatorio: ["Trauma", "Clínica Médica", "Cirurgia"], emergencia: ["Emergência Traumato-Ortopédica", "Emergência Geral"], clinica: ["Clínica Médica", "Clínica Cirúrgica"], navTitle: "HMV", location: "Av. Brasil, s/n - Mirueira, Paulista - PE", image: "", number: ["(81) 3184-6000"], email: [""], latitude: 00, longitude: 00)
]

let susClinicas: [ClinicModel] = [
    // — Recife —  
    ClinicModel(
        title: "Policlínica Lessa de Andrade (US 128)",
        ambulatorio: ["Clínica Médica", "Vacinação"],
        emergencia: ["Não"],
        clinica: ["Policlínica Geral"],
        navTitle: "Lessa de Andrade",
        location: "Estrada dos Remédios, 2416, Madalena, Recife, PE",
        number: ["(81) 3355-7826", "(81) 3355-7801"],
        email: ["Não encontrado"],
        latitude: nil,
        longitude: nil
    ),
    ClinicModel(
        title: "Policlínica Gouveia de Barros (US 160)",
        ambulatorio: ["Cardiologia", "Clínica Médica", "Ginecologia", "Dermatologia", "Psiquiatria", "Ortopedia"],
        emergencia: ["Não"],
        clinica: ["Policlínica Especializada"],
        navTitle: "Gouveia de Barros",
        location: "Largo da Santa Cruz, 140, Boa Vista, Recife, PE",
        number: ["(81) 3355-1535"],
        email: ["p.gouveia.barros@gmail.com"],
        latitude: nil,
        longitude: nil
    ),
    ClinicModel(
        title: "Policlínica Agamenon Magalhães (US 159)",
        ambulatorio: ["Clínica Médica", "Ginecologia", "Pediatria"],
        emergencia: ["Pronto atendimento adulto"],
        clinica: ["Policlínica Geral"],
        navTitle: "Agamenon Magalhães",
        location: "Praça da Paz, s/n, Afogados, Recife, PE",
        number: ["(81) 3355-2331"],
        email: ["Não encontrado"],
        latitude: nil,
        longitude: nil
    ),
    ClinicModel(
        title: "Policlínica Albert Sabin (US 162)",
        ambulatorio: ["Clínica Médica", "Pediatria", "Ginecologia"],
        emergencia: ["Não"],
        clinica: ["Policlínica Geral"],
        navTitle: "Albert Sabin",
        location: "Tamarineira, Recife, PE",
        number: ["Não encontrado"],
        email: ["Não encontrado"],
        latitude: nil,
        longitude: nil
    ),
    ClinicModel(
        title: "Policlínica Barros Lima (US 167)",
        ambulatorio: ["Clínica Médica", "Ginecologia", "Odontologia"],
        emergencia: ["Não"],
        clinica: ["Policlínica Geral"],
        navTitle: "Barros Lima",
        location: "Avenida Norte Miguel Arraes de Alencar, 6465, Casa Amarela, Recife, PE",
        number: ["Não encontrado"],
        email: ["Não encontrado"],
        latitude: nil,
        longitude: nil
    ),
    ClinicModel(
        title: "Policlínica Centro (US 166)",
        ambulatorio: ["Clínica Médica", "Atenção Básica"],
        emergencia: ["Não"],
        clinica: ["Policlínica Geral"],
        navTitle: "Policlínica Centro",
        location: "Rua 1º de Março, 90, Santo Antônio, Recife, PE",
        number: ["(81) 3355-6703", "(81) 3355-6375"],
        email: ["Não encontrado"],
        latitude: nil,
        longitude: nil
    ),
    // — Paulista —  
    ClinicModel(
        title: "USF Maranguape I A – Paulista",
        ambulatorio: ["Clínica Médica", "Imunização", "Pré-Natal"],
        emergencia: ["Não"],
        clinica: ["Saúde da Família"],
        navTitle: "USF Maranguape I A",
        location: "Av. Nelson Ferreira, s/n, Maranguape I, Paulista, PE",
        number: ["(81) 3437-0875"],
        email: ["Não encontrado"],
        latitude: nil,
        longitude: nil
    ),
    ClinicModel(
        title: "USF Maranguape II A – Paulista",
        ambulatorio: ["Clínica Médica", "Atenção Primária"],
        emergencia: ["Não"],
        clinica: ["Saúde da Família"],
        navTitle: "USF Maranguape II A",
        location: "Rua 93, 61, Maranguape II, Paulista, PE",
        number: ["(81) 3437-2849"],
        email: ["Não encontrado"],
        latitude: nil,
        longitude: nil
    ),
    ClinicModel(
        title: "Prontoclínica Torres Galvão – Paulista",
        ambulatorio: ["Clínica Médica", "Urgência Ambulatorial"],
        emergencia: ["Não"],
        clinica: ["Clínica Geral"],
        navTitle: "Prontoclínica Torres Galvão",
        location: "Av. Marechal Floriano Peixoto, s/n, Centro, Paulista, PE",
        number: ["(81) 3433-0936"],
        email: ["Não encontrado"],
        latitude: nil,
        longitude: nil
    ),
    // — Olinda —  
    ClinicModel(
        title: "USF Alto da Bondade I – Olinda",
        ambulatorio: ["Clínica Médica", "Atenção Básica", "Imunização"],
        emergencia: ["Não"],
        clinica: ["Unidade Básica de Saúde"],
        navTitle: "USF Alto Bondade I",
        location: "Rua da Linha, s/n, Alto da Bondade, Olinda, PE",
        number: ["Não encontrado"],
        email: ["Não encontrado"],
        latitude: nil,
        longitude: nil
    ),
    ClinicModel(
        title: "Policlínica Alto do Sol Nascente – Olinda",
        ambulatorio: ["Clínica Médica", "Ginecologia", "Pediatria"],
        emergencia: ["Não"],
        clinica: ["Policlínica Geral"],
        navTitle: "Policlínica Sol Nascente",
        location: "Rua Assunção, 500, Alto do Sol Nascente, Olinda, PE",
        number: ["Não encontrado"],
        email: ["Não encontrado"],
        latitude: nil,
        longitude: nil
    ),
    ClinicModel(
        title: "USF Cohab Peixinhos I – Olinda",
        ambulatorio: ["Clínica Médica", "Saúde da Família"],
        emergencia: ["Não"],
        clinica: ["Unidade Básica"],
        navTitle: "USF Cohab Peixinhos I",
        location: "Olinda, PE",
        number: ["Não encontrado"],
        email: ["Não encontrado"],
        latitude: nil,
        longitude: nil
    )
]
