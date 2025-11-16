//
//  ConfigView.swift
//  GuiBu
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 14/09/25.
//


import SwiftUI

struct ConfigView: View {
    @EnvironmentObject var languageManager: LanguageManager
    @State private var refreshID = UUID()
    
    // Modelo das seções
    private var sections: [ConfigSection] {
        [
            ConfigSection(title: "geral".localized, rows: [.language]),
            ConfigSection(title: "cores".localized, rows: [.appearance/*, .highContrast*/]),
            ConfigSection(title: "aspectos_legais".localized, rows: [.privacyPolicy, .termsOfUse]),
//        ConfigSection(title: "GERAL", rows: [/*.notifications, */.deleteAccount, .logout])
        ]
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(sections, id: \.title) { section in
                    Section(header: Text(section.title)) {
                        ForEach(section.rows, id: \.title) { row in
                            switch row {
                            case .language:
                                NavigationLink(destination: LanguagePickerView()) {
                                    Text(row.title)
                                }
                            case .appearance:
                                NavigationLink(destination: AparenciaView()) {
                                    Text(row.title)
                                }
                            case .privacyPolicy:
                                NavigationLink(destination: PrivacidadeView()) {
                                    Text(row.title)
                                }
                            case .termsOfUse:
                                NavigationLink(destination: TermosView()) {
                                    Text(row.title)
                                }
                            case .deleteAccount:
                                Text(row.title)
                                    .foregroundColor(.red)
                            case .logout:
                                Text(row.title)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
            }
            .navigationTitle("ajustes".localized)
            .navigationBarTitleDisplayMode(.large)
            .id(refreshID) // Força atualização quando o idioma muda
            .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("LanguageChanged"))) { _ in
                // Atualiza a view quando o idioma muda
                refreshID = UUID()
            }
            .onChange(of: languageManager.currentLanguage) { oldValue, newValue in
                // Atualiza a view quando o idioma muda
                refreshID = UUID()
            }
        }
    }
}

// MARK: - Models

private struct ConfigSection {
    let title: String
    let rows: [RowType]
}

private enum RowType {
    case language
    case appearance
//    case highContrast
    case privacyPolicy
    case termsOfUse
//    case notifications
    case deleteAccount
    case logout
    
    var title: String {
        switch self {
        case .language: return "linguagem".localized
        case .appearance: return "aparencia".localized
//        case .highContrast: return "Modo Alto Contraste"
        case .privacyPolicy: return "politica_privacidade".localized
        case .termsOfUse: return "termos_uso".localized
//        case .notifications: return "Notificações"
        case .deleteAccount: return "excluir_conta".localized
        case .logout: return "sair".localized
        }
    }
}


