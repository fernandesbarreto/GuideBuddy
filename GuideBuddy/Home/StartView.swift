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
    
    init(name: String,/* language: Int, age: Int,*/ documentos: [String]) {
        self.name = name
//        self.language = language
//        self.age = age
        self.documentos = documentos
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

struct StartView: View {
    @Environment(\.modelContext) private var context
    @EnvironmentObject var languageManager: LanguageManager
    
    @Query private var users: [User] // Consulta todos os usuários salvos
    
    @State private var isShowingAnimation = true
    @State private var isShowingLogin = false
    
    @State private var username = ""
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
    
    let languageCodes = ["pt-BR", "en", "es"]
    let language = 0 // padrão inicial
    
    var body: some View {
        VStack {
            if isShowingAnimation {
                AnimationScreen()
                    .onAppear {
                        // Após 3 segundos, verifica se existe usuário
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                            if users.isEmpty {
                                // Nenhum usuário, mostrar login
                                isShowingLogin = true
                            } else {
                                // Usuário existe, ir direto para HomeView
                                languageManager.setLanguage(languageCodes[language])
                            }
                            isShowingAnimation = false
                        }
                    }
            } else if isShowingLogin {
                LoginView { name in
                    let user = User(name: name, documentos: documentos)
                    context.insert(user)
                    languageManager.setLanguage(languageCodes[language])
                    isShowingLogin = false
                }
            } else {
                HomeView()
                    .onAppear {
                        languageManager.setLanguage(languageCodes[language])
                    }
            }
        }
    }
}
