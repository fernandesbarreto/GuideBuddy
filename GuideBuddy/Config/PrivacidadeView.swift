//
//  PrivacidadeView.swift
//  GuiBu
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 14/09/25.
//


//
//  PrivacidadeView.swift
//  GuiBU
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 11/04/25.
//

import SwiftUI

struct PrivacidadeView: View {
    @EnvironmentObject var languageManager: LanguageManager
    @State private var refreshID = UUID()
    
    private var privacyText: String {
        """
        \("privacy_title".localized)
        
        \("privacy_intro".localized)
        
        \("privacy_section_1_title".localized)
        
        \("privacy_section_1_text".localized)
        
        \("privacy_section_1_1_title".localized)
        \("privacy_section_1_1_text".localized)
        
        \("privacy_section_1_2_title".localized)
        \("privacy_section_1_2_text".localized)
        
        \("privacy_section_1_3_title".localized)
        \("privacy_section_1_3_text".localized)
        
        \("privacy_section_2_title".localized)
        
        \("privacy_section_2_text".localized)
        
        \("privacy_section_2_1_title".localized)
        \("privacy_section_2_1_text".localized)
        
        \("privacy_section_2_2_title".localized)
        \("privacy_section_2_2_text".localized)
        
        \("privacy_section_3_title".localized)
        
        \("privacy_section_3_text".localized)
        
        \("privacy_section_3_1".localized)
        \("privacy_section_3_2".localized)
        \("privacy_section_3_3".localized)
        
        \("privacy_section_4_title".localized)
        
        \("privacy_section_4_1_title".localized)
        \("privacy_section_4_1_text".localized)
        
        \("privacy_section_4_2_title".localized)
        \("privacy_section_4_2_text".localized)
        
        \("privacy_section_5_title".localized)
        
        \("privacy_section_5_1".localized)
        
        \("privacy_section_5_2_title".localized)
        \("privacy_section_5_2_text".localized)
        
        \("privacy_section_5_3".localized)
        
        \("privacy_section_6_title".localized)
        
        \("privacy_section_6_1_title".localized)
        \("privacy_section_6_1_text".localized)
        
        \("privacy_section_6_2".localized)
        
        \("privacy_section_7_title".localized)
        
        \("privacy_section_7_1".localized)
        
        \("privacy_section_7_2_title".localized)
        \("privacy_section_7_2_text".localized)
        
        \("privacy_section_7_3".localized)
        
        \("privacy_section_8_title".localized)
        
        \("privacy_section_8_text".localized)
        
        \("privacy_section_8_1".localized)
        \("privacy_section_8_2".localized)
        \("privacy_section_8_3".localized)
        \("privacy_section_8_4".localized)
        \("privacy_section_8_5".localized)
        \("privacy_section_8_6".localized)
        
        \("privacy_section_9_title".localized)
        
        \("privacy_section_9_text".localized)
        
        \("privacy_section_10_title".localized)
        
        \("privacy_section_10_text".localized)
        
        \("privacy_section_11_title".localized)
        
        \("privacy_section_11_text".localized)
        """
    }
    
    var body: some View {
        ScrollView {
            Text(privacyText)
                .font(.system(size: 16))
                .padding()
        }
        .id(refreshID)
        .navigationTitle("politicas_privacidade".localized)
        .navigationBarTitleDisplayMode(.large)
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
        PrivacidadeView()
            .environmentObject(LanguageManager())
    }
}
