//
//  SlangView.swift
//  GuiBu
//
//  Created by Pedro Fernandes Barreto Costa on 12/09/24.
//

import SwiftUI

struct DailySlangView: View {
    @State private var currentDayOffset = 0
    
    private var dailySlang: Slang {
        let currentDay = Calendar.current.component(.day, from: Date()) + currentDayOffset
        let index = currentDay % slangs.count
        return slangs[index]
    }
    
    var body: some View {
        VStack(spacing: 20) {
            

            VStack(alignment: .leading) {
                Text(dailySlang.slang)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
                
                Text("Definição: \(dailySlang.definition)")
                    .font(.body)
                    .multilineTextAlignment(.leading)
                    .padding([.top, .bottom])
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
                
                Text("Exemplo: \(dailySlang.examples)")
                    .font(.body)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 280, alignment: .top)
            
            Spacer()
            
            if let image = UIImage(named: dailySlang.imageName) {
                VStack {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 300, maxHeight: 200)
                        .cornerRadius(10)
                }
                .frame(width: 300, height: 200)
            } else {
                VStack {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 300, maxHeight: 200)
                        .cornerRadius(10)
                        .foregroundColor(.gray)
                }
                .frame(width: 300, height: 200)
            }
            
            Spacer()
            
            HStack {
                Button(action: {
                    if currentDayOffset > 0 {
                        currentDayOffset -= 1
                    } else {
                        currentDayOffset = slangs.count - 1
                    }
                }) {
                    Text("Anterior")
                }
                
                Spacer()
                
                Button(action: {
                    if currentDayOffset < slangs.count - 1 {
                        currentDayOffset += 1
                    } else {
                        currentDayOffset = 0
                    }
                }) {
                    Text("Próxima")
                }
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Gírias")
    }
}

#Preview {
    DailySlangView()
}
