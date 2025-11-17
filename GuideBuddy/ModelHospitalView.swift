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
    HospitalModel(title: "UPA Caxangá", ambulatorio: ["Clínica médica", "Pediatria", "Traumato-ortopedia"], emergencia: ["Urgência e Emergência 24h"], clinica: ["Clínica Médica"], navTitle: "UPA Caxangá", location: "Avenida Caxangá, S/N (em frente ao nº 40 da Rua Ribeiro Pessoa) – Várzea Recife – PE", image: "https://www.hospitalmarialucinda.org/assets/images/unidades/principal-upa---caxanga-upa-caxanga-01.jpg", number: ["(81) 3184-4355"], email: ["admupacaxanga@fmsa.org.br"], latitude: -8.029551724421736, longitude: -34.957138390380116),
    HospitalModel(title: "Hospital Ulysses Pernambucano", ambulatorio: ["Psiquiatria", "Saúde Mental"], emergencia: ["Emergência Psiquiátrica 24h"], clinica: ["Saúde Mental"], navTitle: "Ulisses Pernambucano", location: "Av. Conselheiro Rosa e Silva, 2130 - Tamarineira, Recife - PE, 52050-020", image: "https://coc.fiocruz.br/images/noticias/2021/2021.03/tamarineira.jpg", number: ["(81) 3182-9906"], email: ["Não informado"], latitude: -8.029551724421736, longitude:  -34.957138390380116),
    HospitalModel(title: "Hospital Agamenon Magalhães (HAM)", ambulatorio: ["Clínica Médica", "Cirurgia Geral", "Ginecologia", "Obstetrícia", "Otorrinolaringologia", "Endoscopia", "Colonoscopia", "Ambulatório", "Mastologia"], emergencia: ["Emergência Ginecológica e Obstétrica 24h", "Emergência Geral 24h"], clinica: ["Clínica Médica", "Clínica Cirúrgica", "Clínica Ginecológica e Obstétrica"], navTitle: "HAM", location: "Estrada do Arraial, 2723, Casa Amarela, Recife – PE", image: "https://portal-homologacao.saude.pe.gov.br/wp-content/uploads/2024/06/HAM-2.jpg", number: ["(81) 3184.2000"], email: ["Não informado"], latitude: 00, longitude: 00),
        HospitalModel(title: "Hospital Alfa", ambulatorio: ["Cirurgia", "Reabilitação", "Fisioterapia", "Medicina Nuclear"], emergencia: ["Emergência Cardiovascular"], clinica: ["Clínica Cardiológica", "Clínica Cirúrgica"], navTitle: "Alfa", location: "Rua Marquês de Valença, 301, Boa Viagem, Recife – PE", image: "https://portal-homologacao.saude.pe.gov.br/wp-content/uploads/2024/06/ALFA-2.jpg", number: ["(81) 3184.1500"], email: ["Não informado"], latitude: 00, longitude: 00),
        HospitalModel(title: "Hospital Barão de Lucena (HBL)", ambulatorio: ["Clínica Médica", "Cirurgia", "Pediatria", "Ginecologia", "Obstetrícia", "Ambulatório", "Endocrinologia"], emergencia: ["Emergência Ginecológica e Obstétrica 24h", "Emergência Pediátrica 24h"], clinica: ["Clínica Médica", "Clínica Cirúrgica", "Clínica Materno-Infantil"], navTitle: "Barão de Lucena", location: "Avenida Caxangá, 6393, Iputinga, Recife – PE", image: "https://portal-homologacao.saude.pe.gov.br/wp-content/uploads/2024/06/HOF-2.jpg", number: ["(81) 3184.6500"], email: ["Não informado"], latitude: 00, longitude: 00),
        HospitalModel(title: "Hospital Belarmino Correia", ambulatorio: ["Clínica Médica", "Ginecologia", "Obstetrícia", "Pediatria", "Ambulatório"], emergencia: ["Emergência Geral", "Emergência Obstétrica"], clinica: ["Clínica Médica", "Clínica Cirúrgica", "Clínica Materno-Infantil"], navTitle: "Belarmino Correia", location: "Rua Cônego João Rodrigues, S/N, São José, Goiana – PE", image: "https://portal-homologacao.saude.pe.gov.br/wp-content/uploads/2024/07/HBC.jpg", number: ["(81) 3626.8500"], email: ["Não informado"], latitude: 00, longitude: 00),
        HospitalModel(title: "Hospital Correia Picanço (HCP)", ambulatorio: ["Infectologia", "Dermatologia", "Terapia Antirretroviral", "Ambulatório"], emergencia: ["Emergência Infectologia 24h (Doenças Infectocontagiosas)"], clinica: ["Clínica Infectológica", "Clínica Médica"], navTitle: "Correia Picanço", location: "Rua Padre Roma, 149, Tamarineira, Recife – PE", image: "https://portal-homologacao.saude.pe.gov.br/wp-content/uploads/2024/06/correia_picanco_1.jpg", number: ["(81) 3184.2200"], email: ["Não informado"], latitude: 00, longitude: 00),
        HospitalModel(title: "Hospital da Restauração Governador Paulo Guerra (HR)", ambulatorio: ["Neurocirurgia", "Neurologia", "Traumatologia", "Queimados", "Cirurgia Vascular", "Ambulatório"], emergencia: ["Emergência Geral 24h", "Trauma", "Queimados", "Neurocirurgia", "Emergência Clínica"], clinica: ["Clínica Médica", "Clínica Cirúrgica", "UTI Geral"], navTitle: "Restauração", location: "Avenida Agamenon Magalhães, S/N, Derby, Recife – PE", image: "https://portal-homologacao.saude.pe.gov.br/wp-content/uploads/2024/06/HR-2.jpg", number: ["(81) 3181.5400"], email: ["cpl@lafepe.pe.gov.br"], latitude: 00, longitude: 00),
        HospitalModel(title: "Hospital Ermírio Coutinho", ambulatorio: ["Clínica Médica", "Pediatria", "Ginecologia", "Ambulatório"], emergencia: ["Emergência Geral", "Emergência Clínica"], clinica: ["Clínica Médica", "Clínica Pediátrica"], navTitle: "Ermírio Coutinho", location: "Avenida Agamenon Magalhães, S/N, Centro, Limoeiro – PE", image: "https://portal-homologacao.saude.pe.gov.br/wp-content/uploads/2024/07/HEC-2.jpg", number: ["(81) 3628.8600"], email: ["Não informado"], latitude: 00, longitude: 00),
        HospitalModel(title: "Hospital Geral de Areias (HGA)", ambulatorio: ["Clínica Médica", "Cirurgia Geral", "Pediatria", "Ambulatório"], emergencia: ["Emergência Geral 24h", "SPA Infantil 24h"], clinica: ["Clínica Médica", "Clínica Pediátrica"], navTitle: "HGA", location: "Av. Recife, 810, Areias, Recife – PE", image: "https://portal-homologacao.saude.pe.gov.br/wp-content/uploads/2024/06/HGA-1.jpg", number: ["(81) 3184.3000"], email: ["Não informado"], latitude: 00, longitude: 00),
        HospitalModel(title: "Hospital Getúlio Vargas (HGV)", ambulatorio: ["Traumatologia", "Ortopedia", "Cirurgia Vascular", "Neurocirurgia", "Urologia", "Clínica Médica", "Reabilitação Motora"], emergencia: ["Emergência Ortopédica/Traumatológica 24h", "Emergência Geral"], clinica: ["Clínica Cirúrgica", "Clínica Médica"], navTitle: "HGV", location: "Av. General San Martin, S/N, Cordeiro, Recife – PE", image: "https://portal-homologacao.saude.pe.gov.br/wp-content/uploads/2024/07/SES-HGV.jpeg", number: ["(81) 3184.5600"], email: ["Não informado"], latitude: 00, longitude: 00),
        HospitalModel(title: "Hospital João Murilo de Oliveira", ambulatorio: ["Clínica Médica", "Cirurgia Geral", "Ginecologia", "Obstetrícia", "Ambulatório"], emergencia: ["Emergência Geral 24h", "Emergência Obstétrica"], clinica: ["Clínica Médica", "Clínica Cirúrgica", "Clínica Ginecológica e Obstétrica"], navTitle: "João Murilo", location: "BR-232, S/N, São João, Vitória de Santo Antão – PE", image: "https://portal-homologacao.saude.pe.gov.br/wp-content/uploads/2024/07/frente-HJMO-2.jpeg", number: ["(81) 3526.8700"], email: ["Não informado"], latitude: 00, longitude: 00),
        HospitalModel(title: "Hospital Mestre Vitalino (HMV)", ambulatorio: ["Traumatologia", "Ortopedia", "Cirurgia Geral", "Clínica Médica", "Ambulatório"], emergencia: ["Emergência de Trauma 24h", "Emergência Clínica"], clinica: ["Clínica Cirúrgica", "Clínica Médica", "UTI Geral"], navTitle: "HMV", location: "BR 232, km 130, Nova Caruaru, Caruaru – PE", image: "https://portal-homologacao.saude.pe.gov.br/wp-content/uploads/2024/07/Hospital-Mestre-Vitalino.jpeg", number: ["(81) 3728.8500"], email: ["Não informado"], latitude: 00, longitude: 00),
        HospitalModel(title: "Hospital Metropolitano Norte – Miguel Arraes de Alencar (HMA)", ambulatorio: ["Clínica Médica", "Cirurgia", "Ambulatório"], emergencia: ["Emergência Geral 24h", "Emergência Clínica"], clinica: ["Clínica Médica", "Clínica Cirúrgica", "UTI"], navTitle: "H. Miguel Arraes", location: "Rodovia PE 15, S/N, Perimetral, Paulista – PE", image: "https://portal-homologacao.saude.pe.gov.br/wp-content/uploads/2024/07/img6.jpg", number: ["(81) 3182.2500"], email: ["Não informado"], latitude: 00, longitude: 00),
        HospitalModel(title: "Hospital Metropolitano Oeste – Pelópidas Silveira (HMPS)", ambulatorio: ["Cirurgia Vascular", "Traumatologia", "Neurocirurgia", "Ambulatório"], emergencia: ["Emergência de Trauma 24h", "Emergência Cirúrgica"], clinica: ["Clínica Cirúrgica", "UTI Geral"], navTitle: "H. Pelópidas", location: "Rodovia PE 07, km 01, S/N, Santo Aleixo, Jaboatão dos Guararapes – PE", image: "https://portal-homologacao.saude.pe.gov.br/wp-content/uploads/2024/07/01.03.2022-DN-Hospital-Pelopidas130_credito_Divulgacao.jpg", number: ["(81) 3184.2800"], email: ["Não informado"], latitude: 00, longitude: 00),
        HospitalModel(title: "Hospital Metropolitano Sul – Dom Helder Câmara (HMDC)", ambulatorio: ["Clínica Médica", "Cirurgia Geral", "Ambulatório"], emergencia: ["Emergência Geral 24h", "Emergência Clínica"], clinica: ["Clínica Médica", "Clínica Cirúrgica", "UTI"], navTitle: "H. Dom Helder", location: "Rodovia PE-60, km 02, S/N, Zona Rural, Cabo de Santo Agostinho – PE", image: "https://portal-homologacao.saude.pe.gov.br/wp-content/uploads/2024/06/HDHC.jpg", number: ["(81) 3184.4500"], email: ["Não informado"], latitude: 00, longitude: 00),
        HospitalModel(title: "Hospital Otávio de Freitas (HOF)", ambulatorio: ["Clínica Médica", "Cirurgia Geral", "Ortopedia", "Traumatologia", "Ambulatório"], emergencia: ["Emergência Geral 24h", "Emergência Clínica"], clinica: ["Clínica Médica", "Clínica Cirúrgica"], navTitle: "HOF", location: "R. Dona Mariquinha de Oliveira, 117, Cavaleiro, Jaboatão dos Guararapes – PE", image: "https://portal-homologacao.saude.pe.gov.br/wp-content/uploads/2024/06/HOF-2.jpg", number: ["(81) 3184.4000"], email: ["Não informado"], latitude: 00, longitude: 00),
        HospitalModel(title: "Hospital Professor Agamenon Magalhães (HPAM)", ambulatorio: ["Clínica Médica", "Cirurgia Geral", "Ambulatório"], emergencia: ["Emergência Geral"], clinica: ["Clínica Médica", "Clínica Cirúrgica"], navTitle: "HPAM (Serra Talhada)", location: "Rua Enock Inácio de Oliveira, S/N, Nossa Senhora da Penha, Serra Talhada – PE", image: "https://portal-homologacao.saude.pe.gov.br/wp-content/uploads/2024/06/hospital_sera_talhada2_1.jpg", number: ["(87) 3831.8300"], email: ["Não informado"], latitude: 00, longitude: 00),
        HospitalModel(title: "Hospital Regional de Palmares Dr. Sílvio Magalhães", ambulatorio: ["Clínica Médica", "Cirurgia Geral", "Obstetrícia", "Ambulatório"], emergencia: ["Emergência Geral 24h", "Emergência Obstétrica"], clinica: ["Clínica Médica", "Clínica Cirúrgica", "Clínica Ginecológica e Obstétrica"], navTitle: "H. Palmares", location: "Rodovia PE 96, S/N, Santo Aleixo, Palmares – PE", image: "https://portal-homologacao.saude.pe.gov.br/wp-content/uploads/2024/07/Regional-de-Palmares.jpg", number: ["(81) 3662.8800"], email: ["Não informado"], latitude: 00, longitude: 00),
        HospitalModel(title: "Hospital Regional do Agreste Dr. Waldemiro Ferreira (HRA)", ambulatorio: ["Clínica Médica", "Cirurgia Geral", "Traumatologia", "Ambulatório"], emergencia: ["Emergência de Trauma 24h", "Emergência Clínica"], clinica: ["Clínica Cirúrgica", "Clínica Médica", "UTI"], navTitle: "HRA", location: "BR 232, km 127, S/N, Bairro Agamenon Magalhães, Caruaru – PE", image: "https://portal-homologacao.saude.pe.gov.br/wp-content/uploads/2024/06/HRA-2.jpg", number: ["(81) 3719.9200"], email: ["Não informado"], latitude: 00, longitude: 00),
        HospitalModel(title: "Hospital Regional Dom Moura", ambulatorio: ["Clínica Médica", "Cirurgia Geral", "Pediatria", "Obstetrícia", "Ambulatório"], emergencia: ["Emergência Geral 24h", "Emergência Obstétrica"], clinica: ["Clínica Médica", "Clínica Cirúrgica", "Clínica Materno-Infantil"], navTitle: "Dom Moura", location: "Avenida Djalma Dutra, 203, Heliópolis, Garanhuns – PE", image: "https://portal-homologacao.saude.pe.gov.br/wp-content/uploads/2024/07/Dom-Moura.jpg", number: ["(87) 3762.8000"], email: ["Não informado"], latitude: 00, longitude: 00),
        HospitalModel(title: "Hospital Regional Emília Câmara", ambulatorio: ["Clínica Médica", "Cirurgia Geral", "Obstetrícia", "Ambulatório"], emergencia: ["Emergência Geral 24h", "Emergência Obstétrica"], clinica: ["Clínica Médica", "Clínica Cirúrgica", "Clínica Ginecológica e Obstétrica"], navTitle: "Emília Câmara", location: "Rodovia PE-216, S/N, Sítio Juazeiro, Afogados da Ingazeira – PE", image: "https://portal-homologacao.saude.pe.gov.br/wp-content/uploads/2024/07/frente-HREC.jpeg", number: ["(87) 3838.7400"], email: ["Não informado"], latitude: 00, longitude: 00),
        HospitalModel(title: "Hospital Regional Inácio de Sá", ambulatorio: ["Clínica Médica", "Cirurgia Geral", "Obstetrícia", "Ambulatório"], emergencia: ["Emergência Geral 24h", "Emergência Obstétrica"], clinica: ["Clínica Médica", "Clínica Cirúrgica", "Clínica Ginecológica e Obstétrica"], navTitle: "Inácio de Sá", location: "Rua do Progresso, S/N, Centro, Salgueiro – PE", image: "https://portal-homologacao.saude.pe.gov.br/wp-content/uploads/2024/07/Inacio-de-Sa.jpeg", number: ["(87) 3871.8400"], email: ["Não informado"], latitude: 00, longitude: 00),
        HospitalModel(title: "Hospital Regional José Fernandes Salsa", ambulatorio: ["Clínica Médica", "Cirurgia Geral", "Obstetrícia", "Pediatria", "Ambulatório"], emergencia: ["Emergência Geral 24h", "Emergência Obstétrica"], clinica: ["Clínica Médica", "Clínica Cirúrgica", "Clínica Materno-Infantil"], navTitle: "José Fernandes Salsa", location: "Av. Prefeito José Nunes de Sá, S/N, Boa Vista, Limoeiro – PE", image: "https://portal-homologacao.saude.pe.gov.br/wp-content/uploads/2024/07/HFS.jpeg", number: ["(81) 3628.8400"], email: ["Não informado"], latitude: 00, longitude: 00),
        HospitalModel(title: "Hospital Regional Ruy de Barros Correia", ambulatorio: ["Clínica Médica", "Cirurgia Geral", "Obstetrícia", "Pediatria", "Ambulatório"], emergencia: ["Emergência Geral 24h", "Emergência Obstétrica"], clinica: ["Clínica Médica", "Clínica Cirúrgica", "Clínica Materno-Infantil"], navTitle: "Ruy de Barros Correia", location: "Rodovia PE 50, km 80, S/N, Centro, Arcoverde – PE", image: "https://portal-homologacao.saude.pe.gov.br/wp-content/uploads/2024/07/Frente-HRRBC.jpeg", number: ["(87) 3821.8200"], email: ["Não informado"], latitude: 00, longitude: 00),
        HospitalModel(title: "Hospital São Lucas", ambulatorio: ["Clínica Médica", "Ginecologia", "Ambulatório"], emergencia: ["Emergência Clínica", "Emergência Ginecológica"], clinica: ["Clínica Médica", "Clínica Ginecológica"], navTitle: "São Lucas", location: "Rua da Aurora, 1693, Boa Vista, Recife – PE", image: "https://portal-homologacao.saude.pe.gov.br/wp-content/uploads/2024/07/Hospital-Sao-Lucas-Noronha.jpg", number: ["(81) 3184.2600"], email: ["Não informado"], latitude: 00, longitude: 00)
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
