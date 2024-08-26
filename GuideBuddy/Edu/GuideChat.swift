//
//  GuideChat.swift
//  GuideBuddy
//
//  Created by Pedro Fernandes Barreto Costa on 26/08/24.
//


import SwiftUI
import OpenAI
import AVFoundation
import Speech

struct GuideChat: View {
    @State private var question: String = ""
    @State private var answer: String = ""
    @State private var isRecording: Bool = false
    @State private var selectedLanguage = "en-US"
    @State private var imageOpacity: Double = 1.0
    @State private var isAnimating = false

    @StateObject var speechRecognizer = SpeechRecognizer(locale: Locale(identifier: "en-US"))

    let ourOpenAI = OpenAI(apiToken: "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")
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(.background).edgesIgnoringSafeArea(.all)
                Text("GuideBuddy")
                    .position(x: geometry.size.width / 2, y: 16)
                
                Button(action: {
                    print("Abrir outra pagina")
                }) {
                    Image(systemName: "house.fill")
                        .foregroundColor(.fernGreen)
                        .font(.title2)
                }
                .position(x: geometry.size.width * 9 / 10, y: 16)
                
                if answer.isEmpty {
                    Image(.eduGreen)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 72, height: 72)
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                        .opacity(imageOpacity)
                    
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        
                        TextField("Search", text: $question)
                            .disableAutocorrection(true)
                            .cornerRadius(8)
                            .onSubmit() {
                                sendQuestion()
                            }
                        
                        Button(action: manageMic) {
                            Image(systemName: isRecording ? "mic.fill" : "mic.slash.fill")
                                .foregroundColor(isRecording ? .red : .gray)
                        }
                    }
                    .padding(8)
                    .background(Color.textFieldGray)
                    .cornerRadius(40)
                    .padding(.horizontal)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 1.05)
                    
                } else {
                    ScrollView {
                        Text(answer)
                            .multilineTextAlignment(.leading)
                            .padding()
                            .frame(maxWidth: .infinity)
                    }
                    .frame(maxHeight: geometry.size.height * 0.8)
                }
            }
            .onReceive(speechRecognizer.$transcript) { transcript in
                question = transcript
            }
        }
        .onAppear {
            selectedLanguage = UserDefaults.standard.string(forKey: "selectedLanguage") ?? "pt-BR"
            changeLanguage(to: selectedLanguage)
        }
    }
    
    func manageMic() {
        if !isRecording {
            speechRecognizer.resetTranscript()
            speechRecognizer.startTranscribing()
        } else {
            speechRecognizer.stopTranscribing()
        }
        isRecording.toggle()
    }
    
    func sendQuestion() {
        dismissKeyboard()
        startFlickerAnimation()

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
                case .failure(_):
                    answer = "O mago não pode responder no momento"
            }
            
            stopFlickerAnimation()
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
}

#Preview {
    GuideChat()
}
