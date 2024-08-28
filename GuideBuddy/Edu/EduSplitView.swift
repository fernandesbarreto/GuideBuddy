//
//  EduSplitView.swift
//  GuideBuddy
//
//  Created by Pedro Fernandes Barreto Costa on 28/08/24.
//

import SwiftUI

struct EduSplitView: View {
    @State private var selectedAnswer: String = ""

    var body: some View {
        NavigationSplitView {
            QueryHistory(selectedAnswer: $selectedAnswer)
                .frame(minWidth: 250)
        } detail: {
            GuideChat()
        }
    }
}

#Preview {
    EduSplitView()
}
