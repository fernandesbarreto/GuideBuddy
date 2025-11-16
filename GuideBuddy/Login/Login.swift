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
    @State private var showChangeNameAlert = false
    @State private var newName = ""
    @State private var selectedLanguage = "pt-BR"
    @State private var userCreated = false
    
    let languages = [
        ("Português", "pt-BR"),
        ("English", "en"),
        ("Español", "es")
    ]
    let documentosIniciais: [String] = ["Passaporte",
                                 "Comprovante de residência",
                                 "Carta de aceite universitário",
                                 "Passagens",
                                 "Comprovante financeiro",
                                 "Visto de Estudo",
                                 "Carta de Indicação",
                                 "CPF",
                                 "Histórico Escolar",
                                 "Laudos Médicos"]
    let backround: String = ""
    
    var body: some View {
        NavigationStack {
            if let currentUser = users.first {
                // Usuário já existe
                VStack{
                    VStack(spacing: 20) {
                        Text("bem_vindo".localized.replacingOccurrences(of: "%@", with: currentUser.name))
                            .font(.largeTitle)
                        
                        Button("mudar_nome".localized) {
                            newName = currentUser.name
                            showChangeNameAlert = true
                        }
                    }
                    .padding()
                    
                    NavigationLink(destination: HomeView()) {
                        Text("entrar".localized)
                        
                    }
                }
            } else {
                // Primeiro acesso, pede nome
                VStack(spacing: 20) {
                    Text("escolha_nome".localized)
                        .font(.title)
                    
                    TextField("digite_seu_nome".localized, text: $inputName)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("linguagem_preferida".localized)
                            .font(.system(size: 16, weight: .medium))
                            .padding(.horizontal)
                        
                        Picker("linguagem".localized, selection: $selectedLanguage) {
                            ForEach(languages, id: \.1) { language in
                                Text(language.0).tag(language.1)
                            }
                        }
                        .pickerStyle(.menu)
                        .padding(.horizontal)
                    }
                    
                    Button("continuar".localized) {
                        print("=== BOTÃO CONTINUAR PRESSIONADO ===")
                        if !inputName.isEmpty {
                            print("Criando usuário: \(inputName) com linguagem: \(selectedLanguage)")
                            let newUser = User(name: inputName, documentos: documentosIniciais, choosenBackground: "defaultBackground", preferredLanguage: selectedLanguage)
                            print("Usuário criado: \(newUser.name)")
                            
                            // Insere no contexto
                            context.insert(newUser)
                            
                            // Salva o contexto
                            do {
                                try context.save()
                                print("✅ Context.save() executado com sucesso!")
                                
                                // Aguarda um momento para o SwiftData processar
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    // Verifica se foi salvo usando o mesmo contexto
                                    let fetchDescriptor = FetchDescriptor<User>()
                                    do {
                                        let savedUsers = try context.fetch(fetchDescriptor)
                                        print("   Usuários encontrados após salvar: \(savedUsers.count)")
                                        if savedUsers.count > 0 {
                                            print("   ✅ Primeiro usuário: \(savedUsers.first?.name ?? "sem nome")")
                                        }
                                    } catch {
                                        print("   ❌ Erro ao buscar usuários: \(error)")
                                    }
                                    
                                    userCreated = true
                                    // Chama o callback
                                    onComplete(inputName)
                                }
                            } catch {
                                print("❌ Erro ao salvar usuário: \(error)")
                                print("   Detalhes: \(error.localizedDescription)")
                                userCreated = false
                            }
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
        .alert("digite_nome_valido".localized, isPresented: $showNameAlert, actions: {
            Button("ok".localized, role: .cancel) { }
        })
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
        .onChange(of: users.count) { oldCount, newCount in
            // Quando o usuário é criado, o @Query atualiza e a view muda automaticamente
            print("LoginView - users.count mudou: \(oldCount) -> \(newCount)")
            if newCount > 0 && userCreated {
                // Usuário foi criado, o callback já foi chamado
                // A view vai mudar automaticamente porque o @Query atualizou
            }
        }
    }
}


