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
                NavBar(
                    actionLeading: {
                        print("Trailing button tapped")
                        
                    },
                    actionTrailing: {
                       
                        isShowingQueryHistory = true
                    },
                    iconNameLeading: "",
                    iconNameTrailing: "clock"
                )
                
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
        }
    }
}

#Preview {
    EduView()
}
