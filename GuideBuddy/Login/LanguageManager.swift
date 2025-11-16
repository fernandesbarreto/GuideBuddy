//
//  LanguageManager.swift
//  GuiBu
//
//  Created by Raquel Ribeiro Hatem de Farias on 09/09/24.
//

import Foundation


//class LanguageManager: ObservableObject {
//    @Published var currentLanguage: String = "pt-BR"
//
//    func setLanguage(_ language: String) {
//        currentLanguage = language
//        UserDefaults.standard.set([language], forKey: "AppleLanguages")
//        UserDefaults.standard.synchronize()
//    }
//
//    func localizedString(for key: String) -> String {
//        guard let path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj"),
//              let bundle = Bundle(path: path) else {
//            return NSLocalizedString(key, comment: "")
//        }
//        return NSLocalizedString(key, tableName: nil, bundle: bundle, value: "", comment: "")
//    }
//}
//
import Foundation
import SwiftUI

class LanguageManager: ObservableObject { // Ensure this is ObservableObject
    @Published var currentLanguage: String = "pt-BR"
    private var isUpdating = false
    
    func setLanguage(_ language: String) {
        // Evita atualizações simultâneas
        guard !isUpdating else { return }
        
        // Só atualiza se for diferente
        guard currentLanguage != language else { return }
        
        isUpdating = true
        
        // Garante que a atualização seja feita na thread principal
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.currentLanguage = language
            UserDefaults.standard.set(language, forKey: "AppleLanguage")
            UserDefaults.standard.synchronize()
            print("✅ Idioma atualizado: \(language)")
            
            // Permite novas atualizações após um pequeno delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.isUpdating = false
            }
        }
    }

    func localizedString(for key: String) -> String {
        guard let path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            return NSLocalizedString(key, comment: "")
        }
        return NSLocalizedString(key, tableName: nil, bundle: bundle, value: "", comment: "")
    }
}
