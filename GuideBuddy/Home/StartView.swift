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
    var language: Int
    var age: Int
    var documentos: [String]
    
    init(name: String, language: Int, age: Int, documentos: [String]) {
        self.name = name
        self.language = language
        self.age = age
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
    @State private var isShowingStartView = true
    @Environment(\.modelContext) private var context
    @EnvironmentObject var languageManager: LanguageManager
    let documentos: [String] =  ["Passaporte",
            "Comprovante de residência",
            "Carta de aceite universitário",
            "Passagens",
            "Comprovante financeiro",
            "Visto de Estudo",
           "Carta de Indicação",
           "CPF",
            "Histórico Escolar",
         "Laudos Médicos"]
    let fillData = ["Preencha os campos", "Fill in your details", "Rellena tus datos"]
       let flags = ["portugues", "ingles", "espanhol"]
       let languageCodes = ["pt-BR", "en", "es"]
       let firstText = ["Vamos lá", "Let's go", "Vamos alla"]
       let secondText = ["Preencha seus dados", "Fill in your details", "Rellena tus datos"]
       let thirdText = ["Nome do usuário", "User name", "Nombre de usuario"]
       let fourthText = ["Idade", "Age", "Edad"]
       let fifthText = ["Começar", "Start", "Comezar"]
    let name = ""
    let age = 18
    let language = 1
    var body: some View {
        VStack {
            if isShowingStartView {
                ZStack {
                    AnimationScreen()
                }
                .onAppear {
                    handleButtonTap()
                    languageManager.setLanguage(languageCodes[language])
                                               languageManager.setLanguage(languageCodes[language])
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        isShowingStartView = false
                    }
                }
            } else {
                HomeView()
                    .onAppear {
                        handleButtonTap()
                        languageManager.setLanguage(languageCodes[language])
                                                   languageManager.setLanguage(languageCodes[language])
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                            isShowingStartView = false
                        }
                    }
                
            }
        }
    }
    
    private func handleButtonTap() {
      
            let user = User(name: name, language: language, age: age ?? 18, documentos: documentos)
            context.insert(user)
        
    }
}
extension String {
   var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
#Preview {
    StartView()
        .environmentObject(LanguageManager())
}
