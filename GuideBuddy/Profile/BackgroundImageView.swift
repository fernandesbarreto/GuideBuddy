//
//  BackgroundImageView.swift
//  GuiBu
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 06/09/24.
//

import SwiftUI

struct BackgroundImageView: View {
    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented = false
    @State private var selectedBackground: UIImage?
    @State private var isBackgroundPickerPresented = false
    @State private var isBackgroundPickerGaleryPresented = false
    @State private var showSheet = false
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
                        showSheet = true
                      
                    }, label: {
                        Text("Editar")
                            .foregroundStyle(Color.verdePrincipal)
                    })
                    .sheet(isPresented: $showSheet) {
                        VStack {
                            Text("Editar foto do perfil")
                                .font(.headline)
                                .padding()

                            Divider()
                            Button(action: {
                                isBackgroundPickerPresented = true
                            }, label: {
                                HStack {
                                    Text("Tirar foto")
                                    Spacer()
                                    Image(systemName: "camera")
                                    
                                }
                                .padding()
                            })
                            .sheet(isPresented: $isBackgroundPickerPresented) {
                                ImagePicker(selectedImage: $selectedImage, sourceType: .camera)
                            }
                            Divider()
                            Button(action: {
                                isBackgroundPickerGaleryPresented = true
                            }, label: {
                                HStack {
                                    Text("Escolher foto")
                                    Spacer()
                                    Image(systemName: "photo")
                                }
                                .padding()
                            })
                            .sheet(isPresented: $isBackgroundPickerGaleryPresented) {
                                ImagePicker(selectedImage: $selectedImage, sourceType: .photoLibrary)
                            }
                            Divider()

                            // Opção para apagar foto
                            Button(action: {
                                
                            }, label: {
                                HStack {
                                    Text("Apagar foto")
                                        .foregroundColor(.red)
                                    Spacer()
                                    Image(systemName: "trash")
                                    
                                }
                                
                            })
                            .padding()
                           
                                Spacer()
                            }
                        
                        .padding()
                        .presentationDetents([.fraction(0.4), .medium])
                      
                    }
                }
            }
        }
    }
}

#Preview {
    BackgroundImageView()
}
/*.sheet(isPresented: $isBackgroundPickerPresented) {
    ImagePicker2(selectedBackground: $selectedBackground, sourceType: .photoLibrary)
}
*/
