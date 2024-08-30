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
        NavigationStack{
            ScrollView{
                VStack {
                    ZStack {
                        VStack{
                            if let selectedBackground = selectedBackground {
                                // Exibe a imagem capturada
                                Image(uiImage: selectedBackground)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 393, height: 253)
                                
                                    .padding()
                            } else {
                                // Exibe um texto quando nenhuma imagem é selecionada
                                Rectangle()
                                    .foregroundStyle(.gray)
                                    .frame(width: 393, height: 253)
                                    .scaledToFill()
                            }
                            
                            Button(action: {
                                isBackgroundPickerPresented = true
                            }) {
                                Text("Toque para selecionar capa")
                                    .font(.title2)
                                    .padding()
                                
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }.frame(width: 393, height: 253)
                                .sheet(isPresented: $isBackgroundPickerPresented) {
                                    // Apresenta o ImagePicker quando o botão é pressionado
                                    ImagePicker(selectedImage: $selectedImage, sourceType: .camera)
                                }
                            Spacer()
                            
                        }
                                if let selectedImage = selectedImage {
                                    // Exibe a imagem capturada
                                    Image(uiImage: selectedImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 106, height: 106)
                                        .cornerRadius(100)
                                        .padding()
                                } else {
                                    // Exibe um texto quando nenhuma imagem é selecionada
                                    Image("profileImage")
                                        .frame(width: 106, height: 106)
                                        .scaledToFill()
                                }

                                Button(action: {
                                    isImagePickerPresented = true
                                }) {
                                    Text("     ")
                                        .font(.title2)
                                        .padding()
                                        
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                }.frame(width: 106, height: 106)
                                .sheet(isPresented: $isImagePickerPresented) {
                                    // Apresenta o ImagePicker quando o botão é pressionado
                                    ImagePicker(selectedImage: $selectedImage, sourceType: .camera)
                                }
                            }
Text("Pedro Nunes")
                }
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.white.opacity(0.8), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationTitle("Profile")
            
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action:{}, label: {
                        
                        Image("")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                    })
                  
    
                }
                
        
                
                ToolbarItem(placement: .navigationBarTrailing) {

                    Button(action: {
                       

                    },
                           label: {
                        Image(systemName: "")
                            .foregroundStyle(Color(.white))

                    })
                }
            }
        }
    }
}

#Preview {
    Profile()
}
