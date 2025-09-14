//
//  ConfigView.swift
//  GuiBu
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 14/09/25.
//


import SwiftUI

struct ConfigView: View {
    
    // Modelo das seções
    private let sections: [ConfigSection] = [
        ConfigSection(title: "CORES", rows: [.appearance/*, .highContrast*/]),
        ConfigSection(title: "ASPECTOS LEGAIS", rows: [.privacyPolicy, .termsOfUse]),
//        ConfigSection(title: "GERAL", rows: [/*.notifications, */.deleteAccount, .logout])
    ]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(sections, id: \.title) { section in
                    Section(header: Text(section.title)) {
                        ForEach(section.rows, id: \.title) { row in
                            switch row {
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
            .navigationTitle("Ajustes")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

// MARK: - Models

private struct ConfigSection {
    let title: String
    let rows: [RowType]
}

private enum RowType {
    case appearance
//    case highContrast
    case privacyPolicy
    case termsOfUse
//    case notifications
    case deleteAccount
    case logout
    
    var title: String {
        switch self {
        case .appearance: return "Aparência"
//        case .highContrast: return "Modo Alto Contraste"
        case .privacyPolicy: return "Política de privacidade"
        case .termsOfUse: return "Termos de uso"
//        case .notifications: return "Notificações"
        case .deleteAccount: return "Excluir conta"
        case .logout: return "Sair"
        }
    }
}


