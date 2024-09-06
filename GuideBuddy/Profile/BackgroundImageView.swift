//
//  BackgroundImageView.swift
//  GuiBu
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 06/09/24.
//

import SwiftUI

struct BackgroundImageView: View {
    @State var selectedBackground: UIImage?
    @State var isBackgroundPickerPresented = false
    var body: some View {
        NavigationStack{
            VStack{
                if let selectedBackground = selectedBackground {
                    Image(uiImage: selectedBackground)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 393, height: 300)
                        .clipped()
                } else {
                    Image("backgroundImage")
                        .frame(width: 393, height: 300)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.clear.opacity(0.1), for: .navigationBar)
            .navigationTitle("Capa")
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isBackgroundPickerPresented = true
                    }, label: {
                        Text("Editar")
                            .foregroundStyle(Color.verdePrincipal)
                    })
                    .sheet(isPresented: $isBackgroundPickerPresented) {
                        ImagePicker2(selectedBackground: $selectedBackground, sourceType: .photoLibrary)
                    }
                }
            }
        }
    }
}

#Preview {
    BackgroundImageView()
}
