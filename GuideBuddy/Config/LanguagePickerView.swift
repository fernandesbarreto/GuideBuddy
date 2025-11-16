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
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var languageManager: LanguageManager
    @Query private var users: [User]
    @State private var isUpdating = false
    @State private var isViewVisible = true
    @State private var currentLanguage: String = "pt-BR" // Armazena o idioma atual localmente
    
    let languages = [
        ("Português", "pt-BR"),
        ("English", "en"),
        ("Español", "es")
    ]
    
    var currentUser: User? {
        users.first
    }
    
    var body: some View {
        List {
            ForEach(languages, id: \.1) { language in
                HStack {
                    Text(language.0)
                        .font(.system(size: 17))
                    
                    Spacer()
                    
                    Circle()
                        .strokeBorder(language.1 == currentLanguage ? Color.docGreen2 : Color.gray,
                                      lineWidth: 2)
                        .background(
                            Circle()
                                .fill(language.1 == currentLanguage ? Color.docGreen2 : Color.clear)
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
        .id("LanguagePickerView-Stable") // ID estável para evitar que a view seja recriada
        .onAppear {
            isViewVisible = true
            // Carrega o idioma atual do usuário
            if let user = users.first {
                currentLanguage = user.preferredLanguage
            }
        }
        .onDisappear {
            isViewVisible = false
        }
    }
    
    private func selectLanguage(_ languageCode: String) {
        // Evita múltiplas atualizações simultâneas e atualizações quando a view não está visível
        guard !isUpdating && isViewVisible else { return }
        
        guard let user = currentUser else {
            print("Erro: Nenhum usuário encontrado para salvar idioma")
            return
        }
        
        // Não faz nada se já está no mesmo idioma
        if user.preferredLanguage == languageCode {
            return
        }
        
        isUpdating = true
        
        // Atualiza o idioma localmente primeiro (para feedback visual imediato)
        currentLanguage = languageCode
        
        // Atualiza o idioma no usuário
        user.preferredLanguage = languageCode
        
        // Salva no SwiftData
        do {
            try context.save()
            print("✅ Idioma salvo com sucesso: \(languageCode) para usuário: \(user.name)")
        } catch {
            print("❌ Erro ao salvar idioma: \(error)")
            // Reverte o idioma local se houver erro
            currentLanguage = user.preferredLanguage
            isUpdating = false
            return
        }
        
        // Atualiza o LanguageManager (isso também atualiza o UserDefaults)
        languageManager.setLanguage(languageCode)
        
        // Permite novas atualizações após um pequeno delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if self.isViewVisible {
                self.isUpdating = false
            }
        }
    }
}

