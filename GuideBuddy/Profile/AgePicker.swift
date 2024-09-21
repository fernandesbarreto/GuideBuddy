//
//  AgePicker.swift
//  GuiBu
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 08/09/24.
//

import Foundation
import SwiftUI

struct AgePickerView: View {
    @Binding var selectedAge : Int 
    
    var body: some View {
        NavigationView {
            Form {
                Picker("age_select", selection: $selectedAge) {
                    ForEach(0..<117) { age in
                        Text("\(age) anos").tag(age)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .accessibilityLabel("idade_selecionada")
            }
            .navigationBarTitle("user_age", displayMode: .inline)
        }
    }
}
