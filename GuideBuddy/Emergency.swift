//
//  Emergency.swift
//  GuiBu
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 08/09/24.
//

import SwiftUI

struct Emergency: View {

    let emergencyNumbers = [
        ("Ambulância", "192"),
        ("Polícia Civil", "197"),
        ("Polícia Militar", "190"),
        ("Defesa Civil", "199"),
        ("Bombeiro", "193"),
        ("Central de Atendimento à Mulher", "180")
    ]
    
    var body: some View {
        List {
            ForEach(emergencyNumbers.sorted { $0.1 > $1.1 }, id: \.1) { service, number in
                HStack {
                    Text(service)
                        .font(.body)
                    Spacer()
                    Text(number)
                        .font(.body)
                    Button(action: {
                        makeCall(to: number)
                    }) {
                        Image(systemName: "phone.fill")
                            .foregroundColor(.red)
                    }
                   // .buttonStyle(PlainButtonStyle())
                }
                .padding(.vertical, 8)
            }
        }
        .navigationTitle("Emergência")
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
