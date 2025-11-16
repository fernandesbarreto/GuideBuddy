//
//  AparenciaView.swift
//  GuiBu
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 14/09/25.
//


//
//  AparenciaView.swift
//  GuiBU
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 11/04/25.
//

import SwiftUI
import SwiftData

struct AparenciaView: View {
    enum ThemeOption: Int, CaseIterable, Identifiable {
//        case sistema
        case claro
        case escuro

        var id: Int { rawValue }

        var title: String {
            switch self {
//            case .sistema: return "padrao_telefone".localized
            case .claro: return "modo_claro".localized
            case .escuro: return "modo_escuro".localized
            }
        }

        var imageName: String {
            switch self {
//            case .sistema: return "default_mode"
            case .claro: return "light_mode"
            case .escuro: return "dark_mode"
            }
        }

        var backgroundName: String {
            switch self {
//            case .sistema: return "defaultBackground"
            case .claro: return "lightBackground"
            case .escuro: return "darkBackground"
            }
        }
    }

    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss
    @Query private var users: [User]

    @State private var selectedTheme: ThemeOption = .claro
    @State private var isUpdating = false
    @State private var isViewVisible = true

    var body: some View {
        List {
            ForEach(ThemeOption.allCases) { option in
                HStack {
                    Image(option.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60)

                    Text(option.title)
                        .font(.system(size: 17))

                    Spacer()

                    Circle()
                        .strokeBorder(option == selectedTheme ? Color.docGreen2 : Color.gray,
                                      lineWidth: 2)
                        .background(
                            Circle()
                                .fill(option == selectedTheme ? Color.docGreen2 : Color.clear)
                        )
                        .frame(width: 20, height: 20)
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    // Evita múltiplas atualizações simultâneas e atualizações quando a view não está visível
                    guard !isUpdating && isViewVisible else { return }
                    
                    // Não faz nada se já está no mesmo tema
                    if selectedTheme == option {
                        return
                    }
                    
                    isUpdating = true
                    
                    selectedTheme = option
                    applyTheme(option)
                    saveUserBackground(option.backgroundName)
                    
                    // Permite novas atualizações após um pequeno delay
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        if self.isViewVisible {
                            self.isUpdating = false
                        }
                    }
                }
                .listRowBackground(Color.clear)
            }
        }
        .scrollContentBackground(.hidden)
        .navigationTitle("aparencia".localized)
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            isViewVisible = true
            if let currentUser = users.first {
                // Define o tema inicial com base na variável do usuário
                switch currentUser.choosenBackground {
                case "lightBackground": selectedTheme = .claro
                case "darkBackground": selectedTheme = .escuro
                default: selectedTheme = .claro
                }
                applyTheme(selectedTheme)
            }
        }
        .onDisappear {
            isViewVisible = false
        }
    }

    private func applyTheme(_ option: ThemeOption) {
        // Aplica o tema em todas as janelas do app na thread principal
        // Verifica se a view ainda está visível antes de aplicar
        guard isViewVisible else { return }
        
        DispatchQueue.main.async {
            guard self.isViewVisible else { return }
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                for window in windowScene.windows {
                    switch option {
//                    case .sistema:
//                        window.overrideUserInterfaceStyle = .unspecified
                    case .claro:
                        window.overrideUserInterfaceStyle = .light
                    case .escuro:
                        window.overrideUserInterfaceStyle = .dark
                    }
                }
            }
        }
    }

    private func saveUserBackground(_ backgroundName: String) {
        guard isViewVisible else { return }
        guard let currentUser = users.first else {
            print("Erro: Nenhum usuário encontrado para salvar tema")
            return
        }
        currentUser.choosenBackground = backgroundName
        
        // Salva no SwiftData
        do {
            try context.save()
            print("✅ Tema salvo com sucesso: \(backgroundName) para usuário: \(currentUser.name)")
        } catch {
            print("❌ Erro ao salvar tema: \(error)")
        }
    }
}
