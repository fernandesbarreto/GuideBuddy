//
//  EduView.swift
//  GuideBuddy
//
//  Created by Pedro Fernandes Barreto Costa on 28/08/24.
//

import SwiftUI

struct EduView: View {
    @State private var isShowingQueryHistory = false
    @State var answer = ""
    
    var body: some View {
        NavigationStack {
            VStack {
//                NavBar(
//                    actionLeading: {
//                        print("Trailing button tapped")
//                        
//                    },
//                    actionTrailing: {
//                       
//                        isShowingQueryHistory = true
//                    },
//                    iconNameLeading: "",
//                    iconNameTrailing: "clock"
//                )
                
                GuideChat(answer: $answer)
                    .navigationBarTitleDisplayMode(.inline)
                
                NavigationLink(
                    destination: QueryHistory(selectedAnswer: $answer),
                    isActive: $isShowingQueryHistory
                ) {
                    EmptyView()
                }
                .hidden()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.clear.opacity(0.1), for: .navigationBar)
//            .toolbarBackground(.visible, for: .navigationBar)
            .navigationTitle("gui_bu".localized)
            
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {

                    NavigationLink(destination: QueryHistory(selectedAnswer: $answer),
                           label: {
                        Image(systemName: "clock")
                            .foregroundStyle(Color.verdePrincipal)

                    })
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
                  .background(Color(UIColor.systemBackground)) // Adapta ao tema
        }
    }
}

#Preview {
    EduView()
}
