//
//  LanguageManager.swift
//  GuideBuddy
//
//  Created by Raquel Ribeiro Hatem de Farias on 28/08/24.
//

//import Foundation
//import SwiftUI
//
//class LanguageManager: ObservableObject {
//    @Published var currentLanguage: String = "pt-BR" 
//
//    func setLanguage(_ language: String) {
//        print("abobora")
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
