//
//  ConfigView.swift
//  GuiBu
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 14/09/25.
//


import SwiftUI
import SwiftData

struct ConfigView: View {
    @EnvironmentObject var languageManager: LanguageManager
    @Environment(\.modelContext) private var context
    @Query private var users: [User]
    @State private var showChangeNameAlert = false
    @State private var newName = ""
    
    // Modelo das seções
    private var sections: [ConfigSection] {
        [
            ConfigSection(title: "geral".localized, rows: [.editName, .language]),
            ConfigSection(title: "cores".localized, rows: [.appearance/*, .highContrast*/]),
            ConfigSection(title: "aspectos_legais".localized, rows: [.privacyPolicy, .termsOfUse]),
//        ConfigSection(title: "GERAL", rows: [/*.notifications, */.deleteAccount, .logout])
        ]
    }
    
    var body: some View {
        List {
            ForEach(sections, id: \.title) { section in
                Section(header: Text(section.title)) {
                    ForEach(section.rows, id: \.title) { row in
                        switch row {
                        case .editName:
                            Button(action: {
                                if let currentUser = users.first {
                                    newName = currentUser.name
                                    showChangeNameAlert = true
                                }
                            }) {
                                HStack {
                                    Text(row.title)
                                    Spacer()
                                    if let currentUser = users.first {
                                        Text(currentUser.name)
                                            .foregroundColor(.gray)
                                    }
                                }
                            }
                            .foregroundColor(.primary)
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
        .alert("mudar_nome".localized, isPresented: $showChangeNameAlert) {
            TextField("novo_nome".localized, text: $newName)
            Button("cancelar".localized, role: .cancel) { }
            Button("salvar".localized) {
                if !newName.isEmpty, let currentUser = users.first {
                    currentUser.name = newName
                    do {
                        try context.save()
                        print("✅ Nome salvo com sucesso: \(newName)")
                    } catch {
                        print("❌ Erro ao salvar nome: \(error)")
                    }
                }
            }
        } message: {
            Text("digite_novo_nome".localized)
        }
    }
}

// MARK: - Models

private struct ConfigSection {
    let title: String
    let rows: [RowType]
}

private enum RowType {
    case editName
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
        case .editName: return "mudar_nome".localized
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


