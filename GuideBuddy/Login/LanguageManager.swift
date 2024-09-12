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
    
    func setLanguage(_ language: String) {
        currentLanguage = language
        print("language is \(language)")
        UserDefaults.standard.set(language, forKey: "AppleLanguage")
        UserDefaults.standard.synchronize()
        print("user defaults \(String(describing: UserDefaults.standard.value(forKey: "AppleLanguage")))")
    }

    func localizedString(for key: String) -> String {
        guard let path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            return NSLocalizedString(key, comment: "")
        }
        return NSLocalizedString(key, tableName: nil, bundle: bundle, value: "", comment: "")
    }
}
