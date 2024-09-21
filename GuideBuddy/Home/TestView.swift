//
//  TestView.swift
//  GuideBuddy
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 29/08/24.
//

import SwiftUI

struct TestView: View {
        @State private var selectedTab = 0
        let tabs = ["Progress", "Activities"]

        var body: some View {
            NavigationStack {
                VStack {
                    // Conteúdo conforme a seleção
                    if selectedTab == 0 {
                        Text("Progress View")
                            .padding()
                    } else {
                        Text("Activities View")
                            .padding()
                    }
                }
                .navigationTitle("You")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Picker("Options", selection: $selectedTab) {
                            ForEach(0..<tabs.count) { index in
                                Text(self.tabs[index])
                                    .tag(index)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle()) // Estilo segmentado
                        .frame(width: 200) // Controla o tamanho do picker
                    }

                    // Ícone à esquerda
                    ToolbarItem(placement: .navigationBarLeading) {
                        Image(systemName: "person.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }

                    // Ícone à direita
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Image(systemName: "gear")
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
            }
            }
        }
    }




#Preview {
    TestView()
}
