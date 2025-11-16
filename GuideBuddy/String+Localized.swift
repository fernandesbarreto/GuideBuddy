//
//  String+Localized.swift
//  GuideBuddy
//
//  Created on 2025-01-27.
//

import Foundation
import SwiftUI

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

