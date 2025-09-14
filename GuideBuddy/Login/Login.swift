import SwiftUI
import SwiftData

//@Model
//class User {
//    var name: String
//    
//    init(name: String) {
//        self.name = name
//    }
//}

struct LoginView: View {
    @Environment(\.modelContext) private var context
    @Query private var users: [User]
    var onComplete: (String) -> Void
       @State private var name = ""
    @State private var inputName = ""
    @State private var showNameAlert = false
    
    var body: some View {
        NavigationStack {
            if let currentUser = users.first {
                // Usuário já existe
                VStack{
                    VStack(spacing: 20) {
                        Text("Bem-vindo ao GuiBu, \(currentUser.name)!")
                            .font(.largeTitle)
                        
                        Button("Mudar Nome") {
                            showNameAlert = true
                        }
                    }
                    .padding()
                    
                    NavigationLink(destination: HomeView()) {
                        Text("Entrar")
                        
                    }
                }
            } else {
                // Primeiro acesso, pede nome
                VStack(spacing: 20) {
                    Text("Escolha um nome")
                        .font(.title)
                    
                    TextField("Digite seu nome", text: $inputName)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                    
                    Button("Continuar") {
                        if !inputName.isEmpty {
                            let newUser = User(name: inputName, documentos: [""])
                            context.insert(newUser)
                        } else {
                            showNameAlert = true
                        }
                    }
                    .disabled(inputName.isEmpty)
                    .buttonStyle(.borderedProminent)
                }
                .padding()
            }
        }
        .alert("Digite um nome válido", isPresented: $showNameAlert, actions: {
            Button("OK", role: .cancel) { }
        })
    }
}


