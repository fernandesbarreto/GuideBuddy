//
//  AgePicker.swift
//  GuiBu
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 08/09/24.
//

import Foundation
import SwiftUI

struct AgePickerView: View {
    @Binding var selectedAge : Int  // Idade padrão selecionada
    
    var body: some View {
        NavigationView {
            Form {
                Picker("Selecione sua idade", selection: $selectedAge) {
                    ForEach(0..<117) { age in  // Idades de 0 a 100
                        Text("\(age) anos").tag(age)
                    }
                }
                .pickerStyle(WheelPickerStyle())  // Apresenta no estilo roda
                .accessibilityLabel("Idade selecionada")
            }
            .navigationBarTitle("Idade", displayMode: .inline)
        }
    }
}
