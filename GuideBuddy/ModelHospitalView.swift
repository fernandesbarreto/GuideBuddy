//
//  ModelHospitalView.swift
//  GuiBu
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 21/09/24.
//

import Foundation
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
    
    init(title: String, ambulatorio: [String], emergencia: [String], clinica: [String], navTitle: String, location: String, image: String, number: [String], email: [String]) {
        self.title = title
        self.ambulatorio = ambulatorio
        self.emergencia = emergencia
        self.clinica = clinica
        self.navTitle = navTitle
        self.location = location
        self.image = image
        self.number = number
        self.email = email
    }
}
let allHospitalPlaces = [
    HospitalModel(title: "Hospital da Restauração", ambulatorio: ["Ambulatório", "Neurologia", "Neurocirurgia", "Ortopedia/traumatologia", "Cirurgia Vascular", "Cirurgia Geral", "Bucomaxilofacial", "Clínica Médica", "Emergência", "Cirurgia bucomaxilofacial", "Cirurgia Geral", "Cirurgia Vascular", "Clínica Médica", "Clínica Pediátrica", "Intoxicações", "Neurocirurgia", "Neurologia", "Queimaduras", "Traumato-ortopedia"], emergencia: [""], clinica: [""], navTitle: "Restauração", location: "Avenida Agamenon Magalhães, S/N\nDerby, Recife – PE", image: "https://portal.saude.pe.gov.br/wp-content/uploads/2024/06/HR-2.jpg", number: ["(81) 3181.5400"], email: ["cpl@lafepe.pe.gov.br"]),
    HospitalModel(title: "UPA Caxangá", ambulatorio: ["Clínica médica", "Pediatria", "Traumato-ortopedia"], emergencia: [""], clinica: [""]
   , navTitle: "UPA Caxangá", location: "Avenida Caxangá, S/N (em frente ao nº 40 da Rua Ribeiro Pessoa) – Várzea Recife – PE", image: "https://www.hospitalmarialucinda.org/assets/images/unidades/principal-upa---caxanga-upa-caxanga-01.jpg", number: ["(81) 3184-4355"], email: ["admupacaxanga@fmsa.org.br"]),
    HospitalModel(title: "Hospital Ulysses Pernambucano", ambulatorio: [""], emergencia: [""], clinica: [""], navTitle: "Ulisses Pernambucano", location: "Av. Conselheiro Rosa e Silva, 2130 - Tamarineira, Recife - PE, 52050-020", image: "", number: ["(81) 3182-9906"], email: [""]),
    HospitalModel(title: "", ambulatorio: [""], emergencia: [""], clinica: [""], navTitle: "", location: "", image: "", number: [""], email: [""]),
    HospitalModel(title: "", ambulatorio: [""], emergencia: [""], clinica: [""], navTitle: "", location: "", image: "", number: [""], email: [""]),
    HospitalModel(title: "", ambulatorio: [""], emergencia: [""], clinica: [""], navTitle: "", location: "", image: "", number: [""], email: [""]),
    HospitalModel(title: "", ambulatorio: [""], emergencia: [""], clinica: [""], navTitle: "", location: "", image: "", number: [""], email: [""])]
