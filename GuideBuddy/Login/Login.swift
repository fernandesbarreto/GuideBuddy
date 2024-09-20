//
//  Login.swift
//  GuideBuddy
//
//  Created by Raquel Ribeiro Hatem de Farias on 27/08/24.
//

//import SwiftUI
//import SwiftData
//
//@Model
//class User {
//    var name: String
//    var language: Int
//    var age: Int
//    
//    init(name: String, language: Int, age: Int) {
//        self.name = name
//        self.language = language
//        self.age = age
//    }
//}
//
//struct Login: View {
//    @Environment(\.modelContext) private var context
//    
//    @EnvironmentObject var languageManager: LanguageManager
//    
//    @State private var name = ""
//    @State private var age: Int?
//    @State private var languages: Int = 0
//    @State var language = 0
//    @State private var failedInput = false
//    
//    let fillData = ["Preencha os campos", "Fill in your details", "Rellena tus datos"]
//    
//    let flags = ["portugues", "ingles", "espanhol"]
//    let languageCodes = ["pt-BR", "en", "es"]
//    let lingua = ["pt-BR"]
//    let firstText = ["Vamos lá", "Let's go", "Vamos alla"]
//    let secondText = ["Preencha seus dados", "Fill in your details", "Rellena tus datos"]
//    let thirdText = ["Nome do usuário", "User name", "Nombre de usuario"]
//    let fourthText = ["Idade", "Age", "Edad"]
//    let fifthText = ["Começar", "Start", "Comezar"]
//    
//    var body: some View {
//        
//        NavigationStack{
//            
//            GeometryReader { geometry in
//                
//                VStack {
//                    Image("GuideBuddy")
//                        .position(x: geometry.size.width/2, y: geometry.size.height/3.5)
//                    
//                    Text(firstText[language])
//                        .position(x: geometry.size.width/6.5 ,y: geometry.size.height/2.5)
//                    
//                    Text(secondText[language])
//                        .position(x: geometry.size.width/3.6, y: geometry.size.height/3.5)
//                    
//                    TextField(thirdText[language], text: $name)
//                        .padding(.leading)
//                        .frame(width: geometry.size.width*0.88, height: 48)
//                        .background(
//                            RoundedRectangle(cornerRadius: 8)
//                                .fill(Color.barraTexto)
//                        )
//                        .position(x: geometry.size.width/2, y: 150)
//                    Spacer()
//                    TextField(fourthText[language], value: $age, format: .number)
//                        .keyboardType(.numberPad)
//                        .padding(.leading)
//                        .frame(width: geometry.size.width*0.88, height: 48)
//                        .background(
//                            RoundedRectangle(cornerRadius: 8)
//                                .fill(Color.barraTexto)
//                        )
//                        .position(x: geometry.size.width/2, y: 100)
//                    
//                    Button (action: {
//                        handleButtonTap()
//                        languageManager.setLanguage(lingua)
//                    }) {
//                        Text(fifthText[language])
//                            .foregroundStyle(.white)
//                            .frame(width: geometry.size.width*0.88, height: 50)
//                            .background((name.isEmpty || age == nil) ? Color.gray : Color.verde)
//                            .background(Color.verde)
//                            .cornerRadius(14)
//                    }
//                    .alert(fillData[language],
//                           isPresented: $failedInput,
//                           actions: {
//                        Button("OK", role: .cancel, action: {})
//                    })
//                    .position(x: geometry.size.width/2, y: geometry.size.height/8.5)
//                    
//                    HStack {
//                        Button {
//                            languages = (languages - 1 + flags.count) % flags.count
//                            language = (language - 1 + 3) % 3
//                        } label: {
//                            Image(systemName: "chevron.left")
//                        }
//                        
//                        Image(flags[languages])
//                        
//                        Button {
//                            languages = (languages + 1) % flags.count
//                            language = (language + 1 + 3) % 3
//                        } label: {
//                            Image(systemName: "chevron.right")
//                        }
//                    }
//                    .position(x: geometry.size.width/2, y: geometry.size.height/11)
//                }
//                
//                Spacer()
//            }
//        }
//    }
//    private func handleButtonTap() {
//        if name.isEmpty || age == nil {
//            failedInput = true
//        } else {
//            let user = User(name: name, language: language, age: age ?? 18)
//            context.insert(user)
//        }
//        print("info here \(name), \(language), \(String(describing: age))")
//    }
//}
//
//extension String {
//    var localized: String {
//        return NSLocalizedString(self, comment: "")
//    }
//}
//
//#Preview {
//    Login()
//}
//
import SwiftUI
import SwiftData


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

struct Login: View {
    @Environment(\.modelContext) private var context
    @EnvironmentObject var languageManager: LanguageManager
    
    @State private var name = ""
    @State private var age: Int?
    @State private var languages: Int = 0
    @State var language = 0
    @State private var failedInput = false
    @State private var navigateToMenu = false
    
    let fillData = ["Preencha os campos", "Fill in your details", "Rellena tus datos"]
    let flags = ["portugues", "ingles", "espanhol"]
    let languageCodes = ["pt-BR", "en", "es"]
    let firstText = ["Vamos lá", "Let's go", "Vamos alla"]
    let secondText = ["Preencha seus dados", "Fill in your details", "Rellena tus datos"]
    let thirdText = ["Nome do usuário", "User name", "Nombre de usuario"]
    let fourthText = ["Idade", "Age", "Edad"]
    let fifthText = ["Começar", "Start", "Comezar"]
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
    
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                

                ZStack {
                    
                    
                    ScrollView {
//                        Image("GuideBuddy")
//                            .resizable()
//                            .frame(width: 106, height: 32)
                        AnimationScreen()
                            .position(x: geometry.size.width/2, y: geometry.size.height/3.5)
                        VStack(alignment: .leading) {
                           
                            Spacer()
                            
                            Text(firstText[language])
                                .padding(.top, 350)

                            Text(secondText[language])
                                .padding(.top, 0)

                            TextField(thirdText[language], text: $name)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.barraTexto)
                                )
                                .padding(.bottom, 10)

                            TextField(fourthText[language], value: $age, format: .number)
                                .keyboardType(.numberPad)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.barraTexto)
                                )
                                .padding(.bottom, 30)
                            
                            

                            Button(action: {
                                languageManager.setLanguage(languageCodes[language])
                                handleButtonTap()
                                //languageManager.setLanguage(languageCodes[language])
                            }) {
                                Text(fifthText[language])
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, minHeight: 50)
                                    .background((name.isEmpty || age == nil) ? Color.gray : Color.verde)
                                    .cornerRadius(14)
                            }
                            .alert(fillData[language],
                                   isPresented: $failedInput,
                                   actions: {
                                Button("OK", role: .cancel, action: {})
                            })
                            .padding(.bottom, 50)

                            HStack {
                                Button {
                                    languages = (languages - 1 + flags.count) % flags.count
                                    language = (language - 1 + 3) % 3
                                } label: {
                                    Image(systemName: "chevron.left")
                                }

                                Image(flags[languages])
    //                                .resizable()
    //                                .frame(width: 24, height: 24)

                                Button {
                                    languages = (languages + 1) % flags.count
                                    language = (language + 1 + 3) % 3
                                } label: {
                                    Image(systemName: "chevron.right")
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                        }
                        .padding()
                    }
                }


//                Spacer()
            }
        }
    }
    
    private func handleButtonTap() {
        if name.isEmpty || age == nil {
            failedInput = true
        } else {
            let user = User(name: name, language: language, age: age ?? 18, documentos: documentos)
            context.insert(user)
        }
    }
}

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

#Preview {
    Login()
        .environmentObject(LanguageManager())
}
