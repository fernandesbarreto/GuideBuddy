//
//  Emergency.swift
//  GuiBu
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 08/09/24.
//

import SwiftUI

struct EmergencyService: Identifiable {
    let id = UUID()
    let name: String
    let number: String
    let description: String
}

struct Emergency: View {
    
    var emergencyNumbers: [EmergencyService] {
        [
            EmergencyService(name: "ambulancia".localized, number: "192", description: "ambulancia_desc".localized),
            EmergencyService(name: "policia_civil".localized, number: "197", description: "policia_civil_desc".localized),
            EmergencyService(name: "policia_militar".localized, number: "190", description: "policia_militar_desc".localized),
            EmergencyService(name: "defesa_civil".localized, number: "199", description: "defesa_civil_desc".localized),
            EmergencyService(name: "bombeiro".localized, number: "193", description: "bombeiro_desc".localized),
            EmergencyService(name: "central_atendimento_mulher".localized, number: "180", description: "central_atendimento_mulher_desc".localized)
        ]
    }
    
    var body: some View {
        List {
            ForEach(emergencyNumbers) { service in
                HStack{
                    VStack(alignment: .leading, spacing: 4) {
                        
                        Text(service.name)
                            .font(.headline)
                        
                        Text(service.description)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .fixedSize(horizontal: false, vertical: true) // quebra de linha se precisar
                    }
                    .padding(.vertical, 6)
                    
                    Spacer()
                    
                    HStack{
                        Text(service.number)
                            .font(.headline)
                        Button(action: {
                            makeCall(to: service.number)
                        }) {
                            Image(systemName: "phone.fill")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
        }
        .toolbarBackground(.regularMaterial)
        .navigationTitle("emergencia".localized)
    }
    
    func makeCall(to number: String) {
        let tel = "tel://\(number)"
        guard let url = URL(string: tel) else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}


struct Emergencia_Previews: PreviewProvider {
    static var previews: some View {
        Emergency()
    }
}
