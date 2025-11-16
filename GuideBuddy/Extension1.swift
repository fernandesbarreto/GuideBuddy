//
//  Extension1.swift
//  GuideBuddy
//
//  Created by Deivson Pereira da Silva on 10/09/24.
//

import Foundation
import SwiftUI

extension View {
    func blurredSheet<Content: View>(_ style:AnyShapeStyle, show: Binding<Bool>, onDismiss:
                                     @escaping()->(), @ViewBuilder content: @escaping ()->Content)-> some View{
        self
            .sheet(isPresented: show, onDismiss: onDismiss) {
                content()
                    
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background{
                        Rectangle()
                            .fill(style)
                            .ignoresSafeArea(.container, edges: .all)
                    }
                
            }
    }
}

extension String {
    var localized: String {
        // Obtém o idioma atual do UserDefaults ou usa pt-BR como padrão
        let currentLanguage = UserDefaults.standard.string(forKey: "AppleLanguage") ?? "pt-BR"
        
        // Tenta carregar o bundle de localização para o idioma atual
        guard let path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            // Fallback para NSLocalizedString padrão
            return NSLocalizedString(self, comment: "")
        }
        
        // Retorna a string localizada do bundle específico
        return NSLocalizedString(self, tableName: nil, bundle: bundle, value: self, comment: "")
    }
}

                                 
