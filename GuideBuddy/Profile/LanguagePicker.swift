//
//  LanguagePicker.swift
//  GuiBu
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 08/09/24.
//

import Foundation
import SwiftUI

struct LanguagePicker: View {
    @Binding var selectedLanguage : String  // Idade padrão selecionada
    let languages = ["Português", "Español", "English"]
    var body: some View {
        NavigationView {
            Form {
                Picker("Selecione a linguagem", selection: $selectedLanguage) {
                    ForEach(languages, id: \.self) { language in
                        Text("\(language)").tag(language)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .accessibilityLabel("Idade selecionada")
            }
            .navigationBarTitle("Idade", displayMode: .inline)
        }
    }
}
