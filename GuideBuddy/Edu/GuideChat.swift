import SwiftUI
import OpenAI
import AVFoundation
import Speech

struct GuideChat: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss
    
    @State private var question: String = ""
    @Binding var answer: String
    @State private var isRecording: Bool = false
    @State private var selectedLanguage = "pt-BR"
    @State private var imageOpacity: Double = 1.0
    @State private var isAnimating = false
    @State private var isSendingQuestion = false
    @State private var showRestartButton = false
    
    @StateObject var speechRecognizer = SpeechRecognizer(locale: Locale(identifier: "pt-BR"))
    
    let ourOpenAI = OpenAI(apiToken: "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")
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    Color(.background).edgesIgnoringSafeArea(.all)
                    
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
                            .background(Color.textFieldGray)
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
                selectedLanguage = UserDefaults.standard.string(forKey: "selectedLanguage") ?? "pt-BR"
                changeLanguage(to: selectedLanguage)
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
        if question.isEmpty {
            return
        }
        isSendingQuestion = true
        
        let query = ChatQuery(
            messages: [.init(
                role: .user,
                content: "Você é um assistente virtual para estudantes estrangeiros que residem em Recife. Antes de responder essa pergunta, avise (EM APENAS UMA PALAVRA, SEM `EIXO:`, `TEMA:` OU SIMILARES) qual é o eixo de interesse da questão: Transporte; Saúde; Moradia; Segurança; Documentação. Depois, responda a pergunta, pesquisando se necessário e informando quais locais em Recife podem ser prestativos: " + question)!],
            model: .gpt4_o_mini)
        
        ourOpenAI.chats(query: query) { result in
            switch result {
            case .success(let chatResult):
                let content = chatResult.choices[0].message.content?.string
                print(content!)
                answer = content ?? "Erro ao obter resposta"
                let newPrompt = Prompt(question: question, answer: answer, timestamp: Date())
                context.insert(newPrompt)
                
            case .failure(_):
                answer = "O mago não pode responder no momento"
            }
            
            stopFlickerAnimation()
            isSendingQuestion = false // Reset to false after response is received
            showRestartButton = true // Show the restart button after getting an answer
        }
    }
    
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func changeLanguage(to languageCode: String) {
        let locale = Locale(identifier: languageCode)
        speechRecognizer.setLocale(locale: locale)
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
