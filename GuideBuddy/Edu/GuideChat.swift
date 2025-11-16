import SwiftUI
import SwiftData
import AVFoundation
import Speech


struct GuideChat: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    
    @Query private var users: [User]
    
    @State private var question: String = ""
    @Binding var answer: String
    @State private var isRecording: Bool = false
    @State private var selectedLanguage = "pt-BR"
    @State private var imageOpacity: Double = 1.0
    @State private var isAnimating = false
    @State private var isSendingQuestion = false
    @State private var showRestartButton = false
    
    // Computed property para obter a linguagem preferida do usuário
    private var userPreferredLanguage: String {
        users.first?.preferredLanguage ?? "pt-BR"
    }
    
    // SpeechRecognizer será inicializado no onAppear com a linguagem correta
    @StateObject private var speechRecognizer = SpeechRecognizer(locale: Locale(identifier: "pt-BR"))
    

    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    // Background adaptativo que segue o tema do app
                    Color(UIColor.systemBackground)
                        .edgesIgnoringSafeArea(.all)
                    
                    if answer.isEmpty{
                        Image(.eduGreen)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 72, height: 72)
                            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                            .opacity(imageOpacity)
                        
                        if !showRestartButton {
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.gray)
                                
                                TextField("Search", text: $question)
                                    .disableAutocorrection(true)
                                    .cornerRadius(8)
                                    .foregroundColor(.primary) // Adapta ao tema
                                    .onSubmit {
                                        sendQuestion()
                                    }
                                
                                Button(action: manageMic) {
                                    Image(systemName: buttonIconName)
                                        .foregroundColor(buttonIconColor)
                                }
                                .disabled(isSendingQuestion)
                            }
                            .padding(8)
                            .background(Color(UIColor.secondarySystemBackground)) // Adapta ao tema
                            .cornerRadius(40)
                            .padding(.horizontal)
                            .position(x: geometry.size.width / 2, y: geometry.size.height / 1.05)
                        }
                        
                    } else {
                        ScrollView {
                            Text(answer)
                                .multilineTextAlignment(.leading)
                                .padding(.horizontal)
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.primary) // Adapta ao tema
                        }
                        .frame(height: geometry.size.height * 0.9)
                        .padding(.bottom, geometry.size.height * 0.08)
                        Button(action: restartChat) {
                            Text("perguntar_novamente")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .background(.fernGreen)
                                .cornerRadius(40)
                        }
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 1.05)
                    }
                }
                .onReceive(speechRecognizer.$transcript) { transcript in
                    if(!transcript.isEmpty){
                        question = transcript
                    }
                }
            }
            .onAppear {
                // Usa a linguagem preferida do usuário do SwiftData
                selectedLanguage = userPreferredLanguage
                // Atualiza o SpeechRecognizer com a linguagem correta
                let locale = Locale(identifier: selectedLanguage)
                speechRecognizer.setLocale(locale: locale)
                print("GuideChat - Linguagem configurada: \(selectedLanguage)")
            }
            .onChange(of: userPreferredLanguage) { oldValue, newValue in
                // Atualiza a linguagem se o usuário mudar a preferência
                selectedLanguage = newValue
                changeLanguage(to: newValue)
            }
        }
    }
    
    var buttonIconName: String {
        if isRecording {
            return "mic.fill"
        } else if !question.isEmpty {
            return "arrow.turn.right.up"
        } else {
            return "mic.slash.fill"
        }
    }
    
    var buttonIconColor: Color {
        if isRecording {
            return .red
        } else {
            return .gray
        }
    }
    
    func manageMic() {
        if isRecording {
            speechRecognizer.stopTranscribing()
            isRecording = false
        } else {
            if question.isEmpty {
                speechRecognizer.resetTranscript()
                speechRecognizer.startTranscribing()
                isRecording = true
            } else {
                sendQuestion()
            }
        }
    }
    
    
    func sendQuestion() {
        guard !isSendingQuestion else { return }
        dismissKeyboard()
        startFlickerAnimation()
        
        if question.isEmpty { return }
        isSendingQuestion = true
        
        // Envia a pergunta com a linguagem preferida do usuário
        LLMService.shared.send(prompt: question, language: userPreferredLanguage) { text in
            DispatchQueue.main.async {
                self.answer = text
                let newPrompt = Prompt(question: question, answer: answer, timestamp: Date())
                context.insert(newPrompt)
                
                self.stopFlickerAnimation()
                self.isSendingQuestion = false
                self.showRestartButton = true
            }
        }
    }
    
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func changeLanguage(to languageCode: String) {
        // Mapeia o código de idioma para o formato correto do Locale
        let localeIdentifier: String
        switch languageCode {
        case "pt-BR":
            localeIdentifier = "pt-BR"
        case "en":
            localeIdentifier = "en-US"
        case "es":
            localeIdentifier = "es-ES"
        default:
            localeIdentifier = "pt-BR"
        }
        
        let locale = Locale(identifier: localeIdentifier)
        speechRecognizer.setLocale(locale: locale)
        print("GuideChat - Idioma do SpeechRecognizer alterado para: \(localeIdentifier)")
    }
    
    func startFlickerAnimation() {
        isAnimating = true
        withAnimation(Animation.easeInOut(duration: 0.8).repeatForever(autoreverses: true)) {
            imageOpacity = 0.3
        }
    }
    
    func stopFlickerAnimation() {
        isAnimating = false
        withAnimation {
            imageOpacity = 1.0
        }
    }
    
    func restartChat() {
        question = ""
        answer = ""
        isRecording = false
        isAnimating = false
        imageOpacity = 1.0
        showRestartButton = false
    }
}

final class LLMService {
    static let shared = LLMService()
    
    // PARA TESTES: cole aqui sua chave
    private let apiKey = "AIzaSyBMlAb7fWFY7vdf-QlGcGv39rgIQ-qeaVs"
    private let model   = "gemini-2.0-flash"
    
    private init() {}
    
    func send(prompt: String, language: String = "pt-BR", completion: @escaping (String) -> Void) {
        let urlString = "https://generativelanguage.googleapis.com/v1beta/models/\(model):generateContent?key=\(apiKey)"
        guard let url = URL(string: urlString) else {
            completion("❌ URL inválida")
            return
        }
        
        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        req.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Mapeia o código de idioma para o nome do idioma
        let languageName: String
        switch language {
        case "pt-BR":
            languageName = "português"
        case "en":
            languageName = "english"
        case "es":
            languageName = "español"
        default:
            languageName = "português"
        }
        
        // Adiciona instrução para responder no idioma do usuário
        let systemInstruction = "Você é um assistente útil. Sempre responda em \(languageName). Seja claro, conciso e amigável."
        let fullPrompt = "\(systemInstruction)\n\nPergunta do usuário: \(prompt)"
        
        // ⚠️ Somente `contents`, sem temperature/candidateCount
        let body: [String: Any] = [
            "contents": [
                [
                    "parts": [
                        ["text": fullPrompt]
                    ]
                ]
            ]
        ]
        
        do {
            req.httpBody = try JSONSerialization.data(withJSONObject: body)
        } catch {
            completion("❌ Erro ao serializar JSON: \(error.localizedDescription)")
            return
        }
        
        print("🔷 [LLMService] Enviando para Gemini:\n\(prompt)\n")
        
        URLSession.shared.dataTask(with: req) { data, response, error in
            if let err = error {
                print("❌ [LLMService] Erro de rede:", err)
                completion("❌ Erro de rede: \(err.localizedDescription)")
                return
            }
            guard let http = response as? HTTPURLResponse else {
                completion("❌ Response inválida")
                return
            }
            print("🔷 [LLMService] Status code:", http.statusCode)
            let raw = data.flatMap { String(data: $0, encoding: .utf8) } ?? "sem conteúdo"
            print("🔷 [LLMService] Body cru:\n\(raw)\n")
            
            guard (200...299).contains(http.statusCode) else {
                completion("❌ HTTP \(http.statusCode): \(raw)")
                return
            }
            
            // Parsea `candidates → content → parts → text`
            do {
                guard
                    let d = data,
                    let json = try JSONSerialization.jsonObject(with: d) as? [String: Any],
                    let candidates = json["candidates"] as? [[String: Any]],
                    let first = candidates.first,
                    let content = (first["content"] as? [String:Any])?["parts"] as? [[String:Any]],
                    let text = content.first?["text"] as? String
                else {
                    print("❌ [LLMService] Formato inesperado")
                    completion("❌ Erro ao parsear resposta")
                    return
                }
                completion(text.trimmingCharacters(in: .whitespacesAndNewlines))
            } catch {
                print("❌ [LLMService] JSON inválido:", error)
                completion("❌ Erro ao parsear JSON: \(error.localizedDescription)")
            }
        }
        .resume()
    }
}
