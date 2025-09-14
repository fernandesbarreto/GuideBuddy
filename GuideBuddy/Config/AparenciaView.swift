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

struct AparenciaView: View {
    enum ThemeOption: Int, CaseIterable, Identifiable {
        case sistema
        case claro
        case escuro

        var id: Int { rawValue }

        var title: String {
            switch self {
            case .sistema: return "Padrão do telefone"
            case .claro: return "Modo claro"
            case .escuro: return "Modo escuro"
            }
        }

        var imageName: String {
            switch self {
            case .sistema: return "default_mode"
            case .claro: return "light_mode"
            case .escuro: return "dark_mode"
            }
        }
    }

    @AppStorage("selectedTheme") private var selectedTheme: Int = ThemeOption.sistema.rawValue

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
                        .strokeBorder(option.rawValue == selectedTheme ? Color.green : Color.gray,
                                      lineWidth: 2)
                        .background(
                            Circle()
                                .fill(option.rawValue == selectedTheme ? Color.green : Color.clear)
                        )
                        .frame(width: 20, height: 20)
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    selectedTheme = option.rawValue
                    applyTheme(option)
                }
                .listRowBackground(Color.clear)
            }
        }
        .scrollContentBackground(.hidden)
        .navigationTitle("Aparência")
        .navigationBarTitleDisplayMode(.large)
    }

    private func applyTheme(_ option: ThemeOption) {
        guard let window = UIApplication.shared.connectedScenes
            .compactMap({ ($0 as? UIWindowScene)?.keyWindow })
            .first else { return }

        switch option {
        case .sistema:
            window.overrideUserInterfaceStyle = .unspecified
        case .claro:
            window.overrideUserInterfaceStyle = .light
        case .escuro:
            window.overrideUserInterfaceStyle = .dark
        }
    }
}

#Preview {
    NavigationStack {
        AparenciaView()
    }
}
