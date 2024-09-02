//
//  Profile.swift
//  GuideBuddy
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 29/08/24.
//

import SwiftUI
import SwiftData

@Model
class Photo {
    var profilePhoto: Photo
  
    
    init(profilePhoto: Photo) {
        self.profilePhoto = profilePhoto
       
    }
}

struct Profile: View {
    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented = false
    @State private var selectedBackground: UIImage?
    @State private var isBackgroundPickerPresented = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ZStack {
                        if let selectedBackground = selectedBackground {
                            // Exibe a imagem capturada para a capa
                            Image(uiImage: selectedBackground)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 393, height: 253)
                                .clipped()
                        } else {
                            // Exibe um placeholder quando nenhuma imagem de capa é selecionada
                            Rectangle()
                                .foregroundColor(.gray)
                                .frame(width: 393, height: 253)
                                .overlay(
                                    Text("Toque para selecionar capa")
                                        .font(.title2)
                                        .foregroundColor(.white)
                                        .padding()
                                )
                        }
                        
                        Button(action: {
                            isBackgroundPickerPresented = true
                        }) {
                            // Botão invisível sobre a imagem para selecionar nova capa
                            Color.clear.frame(width: 393, height: 253)
                        }
                        .sheet(isPresented: $isBackgroundPickerPresented) {
                            // Apresenta o ImagePicker quando o botão é pressionado
                            ImagePicker(selectedBackground: $selectedBackground, selectedImage: $selectedImage, sourceType: .photoLibrary)
                        }
                    }
                    .offset(y: -30)
                    Spacer()
                        .frame(height: 20) // Espaçamento entre capa e foto de perfil
                    
                    ZStack {
                        if let selectedImage = selectedImage {
                            // Exibe a imagem capturada para o perfil
                            Image(uiImage: selectedImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 106, height: 106)
                                .clipShape(Circle())
                        } else {
                            // Exibe um placeholder quando nenhuma imagem de perfil é selecionada
                            Image("profileImage")
                                .resizable()
                                .frame(width: 106, height: 106)
                                .scaledToFill()
                                .clipShape(Circle())
                        }
                        
                        Button(action: {
                            isImagePickerPresented = true
                        }) {
                            // Botão invisível sobre a imagem para selecionar nova foto de perfil
                            Color.clear.frame(width: 106, height: 106)
                        }
                        .sheet(isPresented: $isImagePickerPresented) {
                            // Apresenta o ImagePicker quando o botão é pressionado
                            ImagePicker(selectedBackground: $selectedBackground, selectedImage: $selectedImage, sourceType: .camera)
                        }
                    }
                    
                    Text("Pedro Nunes")
                        .font(.title)
                        .padding(.top, 10)
                    
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.clear.opacity(0.1), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationTitle("Profile")
            
            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button(action: {}, label: {
//                        Image(systemName: "")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 30)
//                    })
//                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {}, label: {
                        Image(systemName: "ellipsis")
                            .foregroundStyle(Color.white)
                    })
                }
            }
        }
    }
}


#Preview {
    Profile()
}
