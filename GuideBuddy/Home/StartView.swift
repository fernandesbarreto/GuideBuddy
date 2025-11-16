//
//  StartView.swift
//  GuiBu
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 31/10/24.
//
@Model
class Document {
    var title: String
    init(title: String) {
        self.title = title
    }
}

@Model
class User {
    var name: String
//    var language: Int
//    var age: Int
    var documentos: [String]
    var choosenBackground: String
    var preferredLanguage: String // pt-BR, en, es
    @Relationship(deleteRule: .cascade) var documents: [ItemEntity] = []
    
    init(name: String,/* language: Int, age: Int,*/ documentos: [String], choosenBackground: String = "defaultBackground", preferredLanguage: String = "pt-BR") {
        self.name = name
//        self.language = language
//        self.age = age
        self.documentos = documentos
        self.choosenBackground = choosenBackground
        self.preferredLanguage = preferredLanguage
        self.documents = []
    }
}

@Model
class Item {
    var name: String
    @Relationship var owner: User

    init(name: String, owner: User) {
        self.name = name
        self.owner = owner
    }
}
import SwiftUI
import SwiftData

// Função helper para aplicar tema globalmente
func applyThemeFromBackground(_ backgroundName: String) {
    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
        for window in windowScene.windows {
            switch backgroundName {
            case "lightBackground":
                window.overrideUserInterfaceStyle = .light
            case "darkBackground":
                window.overrideUserInterfaceStyle = .dark
            default:
                window.overrideUserInterfaceStyle = .unspecified
            }
        }
    }
}

struct StartView: View {
    @Environment(\.modelContext) private var context
    @EnvironmentObject var languageManager: LanguageManager
    
    @Query private var users: [User] // Consulta todos os usuários salvos
    
    @State private var isShowingAnimation = true
    @State private var animationCompleted = false
    
    let documentos: [String] = ["Passaporte",
                                 "Comprovante de residência",
                                 "Carta de aceite universitário",
                                 "Passagens",
                                 "Comprovante financeiro",
                                 "Visto de Estudo",
                                 "Carta de Indicação",
                                 "CPF",
                                 "Histórico Escolar",
                                 "Laudos Médicos"]
    
    var body: some View {
        Group {
            if isShowingAnimation {
                AnimationScreen()
                    .onAppear {
                        // Sempre mostra a animação completa (5 segundos)
                        // Aplica configurações do usuário se existir
                        if !users.isEmpty {
                            applyUserSettings()
                        }
                        // Após 5 segundos, finaliza a animação
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                            isShowingAnimation = false
                            animationCompleted = true
                        }
                    }
            } else if animationCompleted {
                // Após animação, decide qual tela mostrar baseado apenas no @Query
                if users.isEmpty {
                    // Não há usuário, mostra login
                    LoginView { name in
                        // Callback após criar usuário - não precisa fazer nada
                        // O onChange vai detectar a mudança
                        print("Callback do LoginView chamado")
                    }
                    .id("login-\(users.count)")
                } else {
                    // Há usuário, mostra HomeView
                    HomeView()
                        .onAppear {
                            applyUserSettings()
                        }
                        .id("home-\(users.first?.name ?? "")")
                }
            }
        }
        .id("startView-\(users.count)") // Força atualização quando users.count muda
        .onChange(of: users.count) { oldCount, newCount in
            // Quando usuário é criado ou carregado, aplica configurações
            print("onChange users.count: \(oldCount) -> \(newCount)")
            if newCount > 0 && oldCount == 0 {
                // Usuário foi criado (de 0 para 1+)
                print("✅ NOVO USUÁRIO CRIADO! Aplicando configurações...")
                // Aguarda um momento para garantir que o SwiftData atualizou
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    applyUserSettings()
                    // Força a atualização da view
                    isShowingAnimation = false
                    animationCompleted = true
                }
            } else if newCount > 0 {
                // Usuário já existia
                print("✅ Usuário existente detectado! Aplicando configurações...")
                applyUserSettings()
            }
        }
        .task {
            // Aguarda um momento para garantir que o SwiftData carregou
            try? await Task.sleep(nanoseconds: 200_000_000) // 0.2 segundos
            print("=== TASK - Verificando usuário ===")
            print("users.count: \(users.count)")
            
            // Aplica configurações do usuário se existir (mas não pula a animação)
            if !users.isEmpty {
                print("✅ Usuário encontrado! Aplicando configurações...")
                applyUserSettings()
            }
        }
    }
    
    private func applyUserSettings() {
        guard let currentUser = users.first else { return }
        print("=== APLICANDO CONFIGURAÇÕES DO USUÁRIO ===")
        print("Nome: \(currentUser.name)")
        print("Linguagem: \(currentUser.preferredLanguage)")
        print("Tema: \(currentUser.choosenBackground)")
        print("Documentos: \(currentUser.documents.count)")
        languageManager.setLanguage(currentUser.preferredLanguage)
        applyThemeFromBackground(currentUser.choosenBackground)
    }
}
