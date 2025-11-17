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
    @EnvironmentObject var languageManager: LanguageManager
    @Query private var users: [User]
    var onComplete: (String) -> Void
    @State private var name = ""
    @State private var inputName = ""
    @State private var showNameAlert = false
    @State private var showChangeNameAlert = false
    @State private var newName = ""
    @State private var selectedLanguage = "pt-BR"
    @State private var userCreated = false
    @State private var refreshID = UUID()
    
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
                VStack {
                    Spacer()
                    
                    // Logo do GuiBu no centro
                    Image("GuiBu")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                    
                    Spacer()
                    
                    // Parte de preenchimento na parte de baixo
                    VStack(alignment: .leading, spacing: 30) {
                        VStack(alignment: .leading, spacing: 10){
                            Text("escolha_nome".localized)
                                .font(.title3)
                                .fontWeight(.medium)
                            
                            TextField("digite_seu_nome".localized, text: $inputName)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                )
                            
                            
                        }
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("linguagem_preferida".localized)
                                .font(.title3)
                                .fontWeight(.medium)
                              
                            
                            Picker("linguagem".localized, selection: $selectedLanguage) {
                                ForEach(languages, id: \.1) { language in
                                    Text(language.0).tag(language.1)
                                }
                            }
                            .pickerStyle(.menu)
                            .onChange(of: selectedLanguage) { oldValue, newValue in
                                // Atualiza o LanguageManager quando o usuário seleciona um idioma
                                languageManager.setLanguage(newValue)
                            }
                        
                        }
                        
                        Button(action: {
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
                        }) {
                            Text("continuar".localized)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 15)
                                .background(inputName.isEmpty ? Color.gray : Color.docGreen2)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }
                        .disabled(inputName.isEmpty)
                        .padding(.horizontal, 20)
                    }
                    .padding(.bottom, 40)
                }
                .padding()
                .id(refreshID)
            }
        }
        .onChange(of: languageManager.currentLanguage) { oldValue, newValue in
            // Força atualização da view quando o idioma muda
            if oldValue != newValue {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    refreshID = UUID()
                }
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


