//
//  TermosView.swift
//  GuiBu
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 14/09/25.
//


import SwiftUI

struct TermosView: View {
    @EnvironmentObject var languageManager: LanguageManager
    @State private var refreshID = UUID()
    
    private var termosDeUso: String {
        """
        \("terms_title".localized)
        
        \("terms_section_1_title".localized)
        
        \("terms_section_1_text".localized)
        
        \("terms_section_2_title".localized)
        
        \("terms_section_2_1".localized)
        
        \("terms_section_2_2".localized)
        
        \("terms_section_3_title".localized)
        
        \("terms_section_3_1".localized)
        
        \("terms_section_3_1_list".localized)
        
        \("terms_section_4_title".localized)
        
        \("terms_section_4_1".localized)
        
        \("terms_section_4_2".localized)
        
        \("terms_section_5_title".localized)
        
        \("terms_section_5_1".localized)
        
        \("terms_section_5_1_list".localized)
        
        \("terms_section_5_2".localized)
        
        \("terms_section_6_title".localized)
        
        \("terms_section_6_1".localized)
        
        \("terms_section_6_2".localized)
        
        \("terms_section_6_2_list".localized)
        
        \("terms_section_7_title".localized)
        
        \("terms_section_7_1".localized)
        
        \("terms_section_7_2".localized)
        
        \("terms_section_8_title".localized)
        
        \("terms_section_8_1".localized)
        
        \("terms_section_8_2".localized)
        
        \("terms_section_9_title".localized)
        
        \("terms_section_9_1".localized)
        
        \("terms_section_9_2".localized)
        
        \("terms_section_9_2_list".localized)
        
        \("terms_section_9_3".localized)
        
        \("terms_section_10_title".localized)
        
        \("terms_section_10_1".localized)
        
        \("terms_section_10_1_list".localized)
        
        \("terms_section_10_2".localized)
        
        \("terms_section_10_2_list".localized)
        
        \("terms_section_11_title".localized)
        
        \("terms_section_11_1".localized)
        
        \("terms_section_11_1_list".localized)
        
        \("terms_section_11_2".localized)
        
        \("terms_section_12_title".localized)
        
        \("terms_section_12_1".localized)
        
        \("terms_section_12_2".localized)
        
        \("terms_section_13_title".localized)
        
        \("terms_section_13_1".localized)
        
        \("terms_section_13_2".localized)
        
        \("terms_section_13_3".localized)
        
        \("terms_section_14_title".localized)
        
        \("terms_section_14_1".localized)
        
        \("terms_section_14_2".localized)
        
        \("terms_section_15_title".localized)
        
        \("terms_section_15_1".localized)
        
        \("terms_section_16_title".localized)
        
        \("terms_section_16_1".localized)
        
        \("terms_section_16_2".localized)
        """
    }
    
    var body: some View {
        ScrollView {
            Text(termosDeUso)
                .font(.system(size: 16))
                .padding()
                .multilineTextAlignment(.leading)
        }
        .id(refreshID)
        .navigationTitle("termos_de_uso".localized)
        .onChange(of: languageManager.currentLanguage) { oldValue, newValue in
            if oldValue != newValue {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    refreshID = UUID()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        TermosView()
            .environmentObject(LanguageManager())
    }
}
