//
//  LanguageManager.swift
//  GuideBuddy
//
//  Created by Raquel Ribeiro Hatem de Farias on 28/08/24.
//

import Foundation

class LanguageManager: ObservableObject {
    @Published var currentLanguage: String {
        didSet {
            UserDefaults.standard.set(currentLanguage, forKey: "currentLanguage")
            Bundle.setLanguage(currentLanguage)
            NotificationCenter.default.post(name: NSNotification.Name("LanguageChanged"), object: nil)
        }
    }
    
    init() {
        currentLanguage = UserDefaults.standard.string(forKey: "currentLanguage") ?? Locale.current.language.languageCode?.identifier ?? "en"
    }
}

extension Bundle {
    private static var onLanguageDispatchOnce: Void = {
        object_setClass(Bundle.main, BundleEx.self)
    }()
    
    class func setLanguage(_ language: String) {
        Bundle.onLanguageDispatchOnce
        objc_setAssociatedObject(Bundle.main, &kBundleKey, language, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}

private var kBundleKey: UInt8 = 0

private class BundleEx: Bundle {
    override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        guard let bundlePath = objc_getAssociatedObject(self, &kBundleKey) as? String,
              let bundle = Bundle(path: Bundle.main.path(forResource: bundlePath, ofType: "lproj") ?? "") else {
            return super.localizedString(forKey: key, value: value, table: tableName)
        }
        return bundle.localizedString(forKey: key, value: value, table: tableName)
    }
}
