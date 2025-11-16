//
//  LanguagePickerView.swift
//  GuideBuddy
//
//  Created on 2025-01-27.
//

import SwiftUI
import SwiftData

struct LanguagePickerView: View {
    @Environment(\.modelContext) private var context
    @EnvironmentObject var languageManager: LanguageManager
    @Query private var users: [User]
    @State private var refreshID = UUID()
    
    let languages = [
        ("Português", "pt-BR"),
        ("English", "en"),
        ("Español", "es")
    ]
    
    var currentUser: User? {
        users.first
    }
    
    var currentLanguage: String {
        currentUser?.preferredLanguage ?? "pt-BR"
    }
    
    var body: some View {
        List {
            ForEach(languages, id: \.1) { language in
                HStack {
                    Text(language.0)
                        .font(.system(size: 17))
                    
                    Spacer()
                    
                    Circle()
                        .strokeBorder(language.1 == currentLanguage ? Color.green : Color.gray,
                                      lineWidth: 2)
                        .background(
                            Circle()
                                .fill(language.1 == currentLanguage ? Color.green : Color.clear)
                        )
                        .frame(width: 20, height: 20)
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    selectLanguage(language.1)
                }
                .listRowBackground(Color.clear)
            }
        }
        .scrollContentBackground(.hidden)
        .navigationTitle("selecionar_linguagem".localized)
        .navigationBarTitleDisplayMode(.large)
        .id(refreshID) // Força atualização quando o idioma muda
        .onAppear {
            // Sincroniza o LanguageManager com o idioma do usuário
            if let userLanguage = currentUser?.preferredLanguage {
                languageManager.setLanguage(userLanguage)
            }
        }
        .onChange(of: languageManager.currentLanguage) { oldValue, newValue in
            // Atualiza a view quando o idioma muda
            refreshID = UUID()
        }
    }
    
    private func selectLanguage(_ languageCode: String) {
        guard let user = currentUser else {
            print("Erro: Nenhum usuário encontrado para salvar idioma")
            return
        }
        
        // Atualiza o idioma no usuário
        user.preferredLanguage = languageCode
        
        // Salva no SwiftData
        do {
            try context.save()
            print("✅ Idioma salvo com sucesso: \(languageCode) para usuário: \(user.name)")
        } catch {
            print("❌ Erro ao salvar idioma: \(error)")
            return
        }
        
        // Atualiza o LanguageManager (isso também atualiza o UserDefaults)
        languageManager.setLanguage(languageCode)
        
        // Força atualização da view
        refreshID = UUID()
        
        // Notifica o sistema que o idioma mudou
        // Isso força as views a recarregarem as strings localizadas
        NotificationCenter.default.post(name: NSNotification.Name("LanguageChanged"), object: nil)
    }
}

