//
//  GuideChat.swift
//  GuideBuddy
//
//  Created by Pedro Fernandes Barreto Costa on 28/08/24.
//

import SwiftUI
import SwiftData

@Model
class Prompt {
    var question: String
    var answer: String
    var timestamp: Date
    
    init(question: String, answer: String, timestamp: Date = Date()) {
        self.question = question
        self.answer = answer
        self.timestamp = timestamp
    }
}

struct QueryHistory: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Prompt.timestamp, order: .reverse) private var prompts: [Prompt]
    @Binding var selectedAnswer: String
    @Environment(\.dismiss) private var dismiss
    
    private func promptsToday() -> [Prompt] {
        return prompts.filter { Calendar.current.isDateInToday($0.timestamp) }
    }
    
    private func promptsYesterday() -> [Prompt] {
        return prompts.filter { Calendar.current.isDateInYesterday($0.timestamp) }
    }
    
    private func promptsLast7Days() -> [Prompt] {
        return prompts.filter {
            Calendar.current.isDate($0.timestamp, equalTo: Date(), toGranularity: .day) &&
            Calendar.current.dateComponents([.day], from: $0.timestamp, to: Date()).day! <= 7 &&
            Calendar.current.dateComponents([.day], from: $0.timestamp, to: Date()).day! >= 3
        }
    }
    
    private func promptsAllTime() -> [Prompt] {
        let todayAndYesterdayPrompts = promptsToday() + promptsYesterday()
        let last7DaysPrompts = promptsLast7Days()
        let filteredPrompts = Set(todayAndYesterdayPrompts + last7DaysPrompts)
        return prompts.filter { !filteredPrompts.contains($0) }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.background).edgesIgnoringSafeArea(.all)
                Group {
                    if prompts.count != 0 {
                        List {
                            if !promptsToday().isEmpty {
                                Section(header: Text("Hoje")) {
                                    ForEach(promptsToday()) { prompt in
                                        promptRow(prompt)
                                    }
                                    .onDelete(perform: delete)
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                                }
                            }
                            
                            if !promptsYesterday().isEmpty {
                                Section(header: Text("Ontem")) {
                                    ForEach(promptsYesterday()) { prompt in
                                        promptRow(prompt)
                                    }
                                    .onDelete(perform: delete)
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                                }
                            }
                            
                            if !promptsLast7Days().isEmpty {
                                Section(header: Text("Últimos 7 Dias")) {
                                    ForEach(promptsLast7Days()) { prompt in
                                        promptRow(prompt)
                                    }
                                    .onDelete(perform: delete)
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                                }
                            }
                            
                            if !promptsAllTime().isEmpty {
                                Section(header: Text("Anterior a 7 Dias")) {
                                    ForEach(promptsAllTime()) { prompt in
                                        promptRow(prompt)
                                    }
                                    .onDelete(perform: delete)
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                                }
                            }
                        }
                    } else {
                        ContentUnavailableView("Faça uma pergunta!", systemImage: "dog")
                    }
                }
                .listStyle(.plain)

            }
            
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Histórico")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
                  .background(Color.background)
        }
        
    }
    
    private func promptRow(_ prompt: Prompt) -> some View {
        Button(action: {
            selectedAnswer = prompt.answer
            dismiss()
        }) {
            HStack(spacing: 16) {
                VStack(alignment: .leading) {
                    Text(prompt.question).font(.title2)
                }
            }
            .padding(6)
        }
    }
    
    private func delete(at offsets: IndexSet) {
        offsets.forEach { index in
            let prompt = prompts[index]
            context.delete(prompt)
        }
    }
}

#Preview {
    QueryHistory(selectedAnswer: .constant(""))
        .modelContainer(for: Prompt.self, inMemory: true)
}
